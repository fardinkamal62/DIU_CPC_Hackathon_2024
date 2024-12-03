// reserve_space_page.dart
import 'package:flutter/material.dart';
import '../../const/reservation_model.dart';

class ReserveRoomPage extends StatefulWidget {
  @override
  _ReserveSpacePageState createState() => _ReserveSpacePageState();
}

class _ReserveSpacePageState extends State<ReserveRoomPage> {
  final List<ReservationModel> reservations = [];
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _roomController = TextEditingController();

  final List<String> dates = ['2023-10-01', '2023-10-02', '2023-10-03'];
  final List<String> times = ['10:00 AM', '12:00 PM', '02:00 PM'];
  final List<String> rooms = ['101', '102', '103'];

  void _addReservation() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        reservations.add(ReservationModel(
          name: _nameController.text,
          date: _dateController.text,
          time: _timeController.text,
          room: _roomController.text,
        ));
      });
      _sendConfirmationEmail(_emailController.text);
      _nameController.clear();
      _emailController.clear();
      _dateController.clear();
      _timeController.clear();
      _roomController.clear();
    }
  }

  void _sendConfirmationEmail(String email) {
    // Add your email sending logic here
    print('Confirmation email sent to $email');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reserve a Space'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: _formKey,
              child: Column(
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
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Date'),
                    value: _dateController.text.isEmpty ? null : _dateController.text,
                    onChanged: (value) {
                      setState(() {
                        _dateController.text = value ?? '';
                      });
                    },
                    items: dates.map((date) {
                      return DropdownMenuItem<String>(
                        value: date,
                        child: Text(date),
                      );
                    }).toList(),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a date';
                      }
                      return null;
                    },
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Time'),
                    value: _timeController.text.isEmpty ? null : _timeController.text,
                    onChanged: (value) {
                      setState(() {
                        _timeController.text = value ?? '';
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
                        return 'Please select a time';
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
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _addReservation,
                    child: Text('Reserve'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: reservations.length,
                itemBuilder: (context, index) {
                  final reservation = reservations[index];
                  return ListTile(
                    title: Text(reservation.name),
                    subtitle: Text('${reservation.date} - ${reservation.time} - ${reservation.room}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}