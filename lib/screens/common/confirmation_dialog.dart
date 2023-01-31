import 'package:flutter/material.dart';

Future<dynamic> showConfirmationDialog(
  BuildContext context, {
  String title = "Attention!",
  String content = "Do you really want to perform this action?",
  String affirmativeOption = "Confirm",
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text(
              affirmativeOption.toUpperCase(),
              style:
                  TextStyle(color: Colors.brown, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    },
  );
}
