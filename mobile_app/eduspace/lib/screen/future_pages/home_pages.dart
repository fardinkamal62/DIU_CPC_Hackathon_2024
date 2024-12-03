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
  List<Map<String, dynamic>> freeRooms = [];

  // Fetch data for both schedules and free rooms
  Future<void> fetchData() async {
    // Fetch occupied room schedule data
    final scheduleResponse = await http.get(Uri.parse('http://10.0.2.2:3000/api/schedules'));
    if (scheduleResponse.statusCode == 200) {
      final List<dynamic> scheduleData = jsonDecode(scheduleResponse.body);
      setState(() {
        schedules = scheduleData.map((item) => Map<String, dynamic>.from(item)).toList();
      });
    } else {
      throw Exception('Failed to load occupied rooms');
    }

    // Fetch available room data
    final freeRoomResponse = await http.get(Uri.parse('http://10.0.2.2:3000/api/free-rooms'));
    if (freeRoomResponse.statusCode == 200) {
      final List<dynamic> freeRoomData = jsonDecode(freeRoomResponse.body);
      setState(() {
        freeRooms = freeRoomData.map((item) => Map<String, dynamic>.from(item)).toList();
      });
    } else {
      throw Exception('Failed to load available rooms');
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
                  'Available Rooms',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Dynamically render available rooms
                for (var freeRoom in freeRooms)
                  ..._buildFreeRoomWidgets(freeRoom),
                SizedBox(height: 50),  // Add space between sections

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
                SizedBox(height: 20),  // Add space between sections

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

  // Function to build the widget for available rooms
  List<Widget> _buildFreeRoomWidgets(Map<String, dynamic> freeRoom) {
    List<Widget> widgets = [];
    final roomNumber = freeRoom['roomNumber'];
    final startTime = freeRoom['startTime'];
    final endTime = freeRoom['endTime'];

    // Add available room information
    widgets.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          'Room: $roomNumber (Available)',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    // Add time slot for the available room
    widgets.add(
      AvailableWidget(
        title: '$roomNumber (Available)',
        roomNo: '$roomNumber',
        time: '$startTime - $endTime',
      ),
    );
    // Add reason for the room being available (e.g., cancelled class)
    widgets.add(
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
      ),
    );

    return widgets;
  }
}
