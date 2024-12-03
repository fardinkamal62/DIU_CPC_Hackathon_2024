import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchRoomsPages extends StatefulWidget {
  @override
  _SearchRoomsPagesState createState() => _SearchRoomsPagesState();
}

class _SearchRoomsPagesState extends State<SearchRoomsPages> {
  List<Map<String, dynamic>> freeRooms = [];
  String selectedTime = '';
  String selectedDay = '';
  String selectedClassroom = '';

  // Fetch data from the free rooms API endpoint
  Future<void> fetchData() async {
    final freeRoomsResponse = await http.get(Uri.parse('http://10.0.2.2:3000/api/free-rooms'));
    if (freeRoomsResponse.statusCode == 200) {
      final List<dynamic> data = jsonDecode(freeRoomsResponse.body);
      setState(() {
        freeRooms = data.map((item) => Map<String, dynamic>.from(item)).toList();
      });
    } else {
      throw Exception('Failed to load free rooms data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Predefined dropdown filter items
  List<String> get times => ['8:00 - 9:00', '9:00 - 10:00', '10:00 - 11:00', '11:00 - 12:00', '12:00 - 13:00', '13:00 - 14:00', '14:00 - 15:00', '15:00 - 16:00', '16:00 - 17:00', '17:00 - 18:00', '18:00 - 19:00', '19:00 - 20:00', '20:00 - 21:00', '21:00 - 22:00', '22:00 - 23:00', '23:00 - 24:00'];
  List<String> get days => ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
  List<String> get classrooms => ['501', '502', '503', '504', '505', '601', '602', '603', '604', '605', '701', '702', '703', '704', '705', '801', '802', '803', '804', '805', '901', '902', '903', '904', '905'];

  List<Map<String, dynamic>> get filteredRooms {
    return freeRooms.where((room) {
      return (selectedTime.isEmpty || room['startTime'] == selectedTime) &&
          (selectedDay.isEmpty || room['startDate'] == selectedDay) &&
          (selectedClassroom.isEmpty || room['roomNumber'].toString() == selectedClassroom);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Time Dropdown
              DropdownButton<String>(
                hint: Text('Select Time'),
                value: selectedTime.isEmpty ? null : selectedTime,
                onChanged: (value) {
                  setState(() {
                    selectedTime = value ?? '';
                  });
                },
                items: times.map((time) {
                  return DropdownMenuItem<String>(
                    value: time,
                    child: Text(time),
                  );
                }).toList(),
              ),
              // Day Dropdown
              DropdownButton<String>(
                hint: Text('Select Day'),
                value: selectedDay.isEmpty ? null : selectedDay,
                onChanged: (value) {
                  setState(() {
                    selectedDay = value ?? '';
                  });
                },
                items: days.map((day) {
                  return DropdownMenuItem<String>(
                    value: day,
                    child: Text(day),
                  );
                }).toList(),
              ),
              // Classroom Dropdown
              DropdownButton<String>(
                hint: Text('Select Classroom'),
                value: selectedClassroom.isEmpty ? null : selectedClassroom,
                onChanged: (value) {
                  setState(() {
                    selectedClassroom = value ?? '';
                  });
                },
                items: classrooms.map((classroom) {
                  return DropdownMenuItem<String>(
                    value: classroom,
                    child: Text(classroom),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              // Display the filtered rooms
              Expanded(
                child: ListView.builder(
                  itemCount: filteredRooms.length,
                  itemBuilder: (context, index) {
                    final room = filteredRooms[index];
                    return ListTile(
                      title: Text('Room ${room['roomNumber']}'),
                      subtitle: Text('${room['startTime']} - ${room['endTime']} - ${room['reason']}'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
