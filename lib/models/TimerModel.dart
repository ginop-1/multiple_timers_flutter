import 'dart:math';

import 'package:flutter/material.dart';

class TimersModel extends ChangeNotifier {
  List<TimerItem> timers = [
    TimerItem(name: 'TEST Timer 1', time: 0),
    TimerItem(name: 'TEST Timer 2', time: (Random().nextInt(5) + 1)),
    TimerItem(name: 'TEST Timer 3', time: (Random().nextInt(5) + 1))
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

  void rebuild() {
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
  final int id, time;
  final String name;

  TimerItem({
    this.name,
    this.time,
  }) : id = idCounter++;

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is TimerItem && other.id == id;
}
