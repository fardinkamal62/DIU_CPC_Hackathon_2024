

  import 'package:flutter/material.dart';

void showEmailPopup(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter your email'),
          content: TextField(
            controller: emailController,
            decoration: InputDecoration(hintText: 'Email'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showSnackbar(context, 'Your Booking Aplication is Submited you will notifie on you email: ${emailController.text}');
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
