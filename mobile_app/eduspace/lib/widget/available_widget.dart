import 'package:eduspace/const/color.dart';
import 'package:flutter/material.dart';

class AvailableWidget extends StatelessWidget {
  AvailableWidget({required this.title, required this.roomNo, required this.time});
  final String title;
  final String roomNo;
  final String time;

  // Method that controls if the room is available then show booked button or not show Icon
  bool isAvailable(String title) {
    if (title == 'Available Rooms') {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool available = isAvailable(title);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        SizedBox(height: 10),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Room No : $roomNo'),
                    Text('Available time : $time'),
                  ],
                ),
                available
                    ? ElevatedButton(
                  onPressed: () {
                    // Add your booking logic here
                  },
                  child: Icon(Icons.calendar_today, color: Colors.white),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    padding: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  )
                )
                    : Icon(Icons.access_time_filled_sharp),
                SizedBox(height: 10,)
              ],
            ),
          ),
        ),
      ],
    );
  }
}