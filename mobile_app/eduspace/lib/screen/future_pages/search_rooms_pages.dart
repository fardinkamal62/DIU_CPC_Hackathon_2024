import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../const/class_model.dart';

class SearchRoomsPages extends StatefulWidget {
  @override
  _ClassListPageState createState() => _ClassListPageState();
}

class _ClassListPageState extends State<SearchRoomsPages> {
  List<ClassModel> classes = [];
  String selectedTime = '';
  String selectedDay = '';
  String selectedClassroom = '';

  // Fetch data from API
  Future<void> fetchData() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:3000/api/schedules'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        // Convert the fetched data to ClassModel list
        classes = data.map((item) => ClassModel.fromJson(item)).toList();
      });
      print(classes);  // Debugging: Print the fetched data
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  // Dropdown filter items
  List<String> get times => classes.map((c) => c.time).toSet().toList();
  List<String> get days => classes.map((c) => c.day).toSet().toList();
  List<String> get classrooms => classes.map((c) => c.classroom).toSet().toList();

  List<ClassModel> get filteredClasses {
    return classes.where((classModel) {
      return (selectedTime.isEmpty || classModel.time == selectedTime) &&
          (selectedDay.isEmpty || classModel.day == selectedDay) &&
          (selectedClassroom.isEmpty || classModel.classroom == selectedClassroom);
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
              // Display the filtered classes
              Expanded(
                child: ListView.builder(
                  itemCount: filteredClasses.length,
                  itemBuilder: (context, index) {
                    final classModel = filteredClasses[index];
                    return ListTile(
                      title: Text(classModel.className),
                      subtitle: Text('${classModel.time} - ${classModel.day} - ${classModel.classroom}'),
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
