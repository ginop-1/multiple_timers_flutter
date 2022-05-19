import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:clock_timer/models/TimerModel.dart';
import 'package:flutter/services.dart';

import 'dart:math';

Future<void> testDialog(
  BuildContext context,
  String inputString,
) async {
  TextEditingController nameController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  return showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: Colors.black45,
    transitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (BuildContext buildContext, Animation animation,
        Animation secondaryAnimation) {
      return Center(
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.height / 3.5,
          padding: EdgeInsets.all(20),
          color: Colors.white,
          child: Column(
            children: [
              // timer's name input
              Card(
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: inputString),
                ),
              ),
              // timer's duration input
              Card(
                child: TextField(
                  controller: timeController,
                  decoration: InputDecoration(labelText: "Enter time duration"),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ], // Only numbers can be entered
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      child: Text('CANCEL'),
                      onPressed: () => Navigator.pop(context),
                    ),
                    ElevatedButton(
                      child: Text('OK'),
                      onPressed: () {
                        String timerName = nameController.text;
                        if (timerName.isNotEmpty) {
                          context.read<TimersModel>().add(
                                TimerItem(
                                  name: timerName,
                                  time: int.parse(timeController.text),
                                ),
                              );
                        }
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Future<void> displayTextInputDialog(
  BuildContext context,
  String inputString,
) async {
  // TODO: redo with proper parameters
  TextEditingController nameController = TextEditingController();

  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('New Timer'),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(hintText: inputString),
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
    },
  );
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
