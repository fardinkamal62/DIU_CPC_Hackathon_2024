import 'dart:convert';
import 'package:eduspace/widget/available_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  List<Map<String, dynamic>> schedules = [];

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/schedules'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        schedules = data.map((item) => Map<String, dynamic>.from(item)).toList();
      });
      print(schedules);  // Debugging: Print the fetched data
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Occupied Rooms',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Dynamically render available rooms and schedules
                for (var schedule in schedules)
                  ..._buildRoomScheduleWidgets(schedule),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to build the widget for each room's schedule
  List<Widget> _buildRoomScheduleWidgets(Map<String, dynamic> schedule) {
    List<Widget> widgets = [];
    final roomNumber = schedule['roomNumber'];
    final scheduleData = schedule['schedule'];

    // Loop through the schedule days
    for (var daySchedule in scheduleData) {
      final day = daySchedule['day'];
      final times = daySchedule['times'];

      // Add room and day information
      widgets.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            'Room: $roomNumber - $day',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );

      // Add time slots for the day
      for (var timeSlot in times) {
        final startTime = timeSlot['startTime'];
        final endTime = timeSlot['endTime'];
        widgets.add(
          AvailableWidget(
            title: '$roomNumber - $day',
            roomNo: '$roomNumber',
            time: '$startTime - $endTime',
          ),
        );
      }
    }
    return widgets;
  }
}
