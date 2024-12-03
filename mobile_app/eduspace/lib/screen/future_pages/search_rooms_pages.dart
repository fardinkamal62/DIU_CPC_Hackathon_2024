// class_list_page.dart
import 'package:flutter/material.dart';
import '../../const/class_model.dart';

class SearchRoomsPages extends StatefulWidget {
  @override
  _ClassListPageState createState() => _ClassListPageState();
}

class _ClassListPageState extends State<SearchRoomsPages> {
  final List<ClassModel> classes = [
    ClassModel(className: 'Math', time: '10:00 AM', day: 'Monday', classroom: '101'),
    ClassModel(className: 'Science', time: '12:00 PM', day: 'Monday', classroom: '102'),
    ClassModel(className: 'History', time: '10:00 AM', day: 'Tuesday', classroom: '101'),
    // Add more classes as needed
  ];

  String selectedTime = '';
  String selectedDay = '';
  String selectedClassroom = '';

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