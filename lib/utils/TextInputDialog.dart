import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:clock_timer/models/TimerModel.dart';
import 'dart:math';

Future<void> displayTextInputDialog(BuildContext context) async {
  // TODO: redo with proper parameters
  TextEditingController nameController = TextEditingController();

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('New Timer'),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(hintText: "insert name here..."),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                String timerName = nameController.text;
                if (timerName.isNotEmpty) {
                  context.read<TimersModel>().add(TimerItem(
                        name: timerName,
                        // generate random time between 1 and 6 ms
                        time: (Random().nextInt(10) + 1),
                      ));
                }
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
}

Future<TimeOfDay> selectTimeDialog(context) async {
  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);

  final TimeOfDay newTime = await showTimePicker(
    context: context,
    initialTime: _time,
  );
  Navigator.pop(context);
  if (newTime != null) {
    return newTime;
  }
}
