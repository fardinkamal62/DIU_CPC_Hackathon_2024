import 'package:eduspace/widget/available_widget.dart';
import 'package:flutter/material.dart';

class HomePages extends StatefulWidget {
  const HomePages({super.key});

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Padding(
            padding:EdgeInsets.all(16),
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
                  AvailableWidget( title: 'Available Rooms', roomNo: '101', time: '10:00 AM - 12:00 PM'),
                  SizedBox(height: 36),
                  Text(
                    'Available Rooms',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  AvailableWidget( title: 'Unavailable Rooms', roomNo: '102', time: '12:00 PM - 02:00 PM'),
                ],
              ),
          ),
        ),
      )
    );
  }
}
