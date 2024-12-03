import 'package:flutter/material.dart';

class AvailableWidget extends StatefulWidget {
  const AvailableWidget({super.key});

  @override
  State<AvailableWidget> createState() => _AvailableWidgetState();
}

class _AvailableWidgetState extends State<AvailableWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Text('Available Rooms',style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),),
            SizedBox(height: 10,),
            Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Room No : 101'),
                          Text('Available time : 10:00 AM - 12:00 PM'),
                        ],
                      ),
                      Icon(Icons.access_time_filled_sharp),
                    ],
                  ),
                )
            )
          ],
        ),
      )
    );
  }
}
