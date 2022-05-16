import 'dart:math';

import 'package:flutter/material.dart';

class TimersModel extends ChangeNotifier {
  List<TimerItem> timers = [
    TimerItem(name: 'TEST Timer 1', time: 0),
    TimerItem(name: 'TEST Timer 2', time: (Random().nextInt(10) + 1)),
    TimerItem(name: 'TEST Timer 3', time: (Random().nextInt(10) + 1))
  ];

  void add(TimerItem timer) {
    timers.add(timer);
    notifyListeners();
  }

  void remove(int id) {
    for (int i = 0; i < timers.length; i++) {
      if (timers[i].id == id) {
        timers.removeAt(i);
        notifyListeners();
        return;
      }
    }
  }

  void removeAll() {
    timers.clear();
    notifyListeners();
  }

  TimerItem getByPosition(int index) {
    try {
      return timers[index];
    } catch (e) {
      return null;
    }
  }
}

class TimerItem {
  // dataclass for timer's widget
  static int idCounter = 0;

  final int id;
  final String name;
  final int time;
  final Color color = Color.fromARGB(0, 0, 0, 0); // UNUSED

  // TODO: implement or remove color
  TimerItem({
    this.name,
    this.time,
  }) : id = idCounter++;

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is TimerItem && other.id == id;
}
