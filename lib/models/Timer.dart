import 'package:flutter/material.dart';

class TimersModel extends ChangeNotifier {
  List<Timer> timers = [
    Timer(name: 'TEST Timer 1', time: 0),
    Timer(name: 'TEST Timer 2', time: 0),
    Timer(name: 'TEST Timer 3', time: 0)
  ];

  void add(Timer timer) {
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

  Timer getByPosition(int index) {
    try {
      return timers[index];
    } catch (e) {
      return null;
    }
  }
}

class Timer {
  // dataclass for timer's widget
  static int idCounter = 0;

  final int id;
  final String name;
  final int time;
  final Color color = Color.fromARGB(0, 0, 0, 0); // UNUSED

  Timer({
    this.name,
    this.time,
  }) : id = idCounter++;

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Timer && other.id == id;
}
