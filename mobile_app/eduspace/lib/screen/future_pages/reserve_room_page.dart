import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReserveRoomPage extends StatefulWidget {
  @override
  _ReserveRoomPageState createState() => _ReserveRoomPageState();
}

class _ReserveRoomPageState extends State<ReserveRoomPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  final _roomController = TextEditingController();
  final _peopleController = TextEditingController();
  final _reservationTypeController = TextEditingController();

  final List<String> times = ['10:00 AM', '12:00 PM', '02:00 PM'];
  final List<String> rooms = ['101', '102', '103'];
  final List<String> peopleOptions = ['1', '2', '3', '4', '5+'];
  final List<String> reservationTypes = ['Meeting', 'Workshop', 'Conference'];

  Future<void> _sendReservationRequest() async {
    if (_formKey.currentState!.validate()) {
      final reservationData = {
        'name': _nameController.text,
        'email': _emailController.text,
        'startDate': _startDateController.text,
        'endDate': _endDateController.text,
        'startTime': _startTimeController.text,
        'endTime': _endTimeController.text,
        'room': _roomController.text,
        'people': _peopleController.text,
        'reservationType': _reservationTypeController.text,
      };

      final response = await http.post(
        Uri.parse('http://10.0.2.2:3000/api/reservation'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(reservationData),
      );

      if (response.statusCode == 200) {
        _showSnackBar('Reservation successfully made');
      } else {
        _showSnackBar('Failed to make reservation: ${response.body}');
      }
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reserve a Space'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _startDateController,
                decoration: InputDecoration(labelText: 'Start Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the start date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _endDateController,
                decoration: InputDecoration(labelText: 'End Date'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the end date';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Start Time'),
                value: _startTimeController.text.isEmpty ? null : _startTimeController.text,
                onChanged: (value) {
                  setState(() {
                    _startTimeController.text = value ?? '';
                  });
                },
                items: times.map((time) {
                  return DropdownMenuItem<String>(
                    value: time,
                    child: Text(time),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a start time';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'End Time'),
                value: _endTimeController.text.isEmpty ? null : _endTimeController.text,
                onChanged: (value) {
                  setState(() {
                    _endTimeController.text = value ?? '';
                  });
                },
                items: times.map((time) {
                  return DropdownMenuItem<String>(
                    value: time,
                    child: Text(time),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select an end time';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Room'),
                value: _roomController.text.isEmpty ? null : _roomController.text,
                onChanged: (value) {
                  setState(() {
                    _roomController.text = value ?? '';
                  });
                },
                items: rooms.map((room) {
                  return DropdownMenuItem<String>(
                    value: room,
                    child: Text(room),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a room';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Number of People'),
                value: _peopleController.text.isEmpty ? null : _peopleController.text,
                onChanged: (value) {
                  setState(() {
                    _peopleController.text = value ?? '';
                  });
                },
                items: peopleOptions.map((people) {
                  return DropdownMenuItem<String>(
                    value: people,
                    child: Text(people),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select the number of people';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Reservation Type'),
                value: _reservationTypeController.text.isEmpty ? null : _reservationTypeController.text,
                onChanged: (value) {
                  setState(() {
                    _reservationTypeController.text = value ?? '';
                  });
                },
                items: reservationTypes.map((type) {
                  return DropdownMenuItem<String>(
                    value: type,
                    child: Text(type),
                  );
                }).toList(),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a reservation type';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _sendReservationRequest,
                child: Text('Reserve'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
