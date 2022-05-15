import 'dart:collection';
import 'dart:ui';

import 'package:flutter/material.dart';

class TimersModel extends ChangeNotifier {
  List<Timer> _timers = [];
  TextEditingController nameController = TextEditingController();

  UnmodifiableListView<Timer> get timers => UnmodifiableListView(_timers);

  void add(Timer timer) {
    _timers.add(timer);
    notifyListeners();
  }

  void remove(int index) {
    _timers.removeAt(index);
    notifyListeners();
  }

  void removeAll() {
    _timers.clear();
    notifyListeners();
  }

  Timer getByPosition(int index) {
    try {
      return _timers[index];
    } catch (e) {
      return null;
    }
  }
}

class Timer {
  // dataclass for timer's widget
  final int id;
  final String name;
  final int time;
  final Color color = Color.fromARGB(0, 0, 0, 0); // UNUSED

  Timer({
    this.id,
    this.name,
    this.time,
  });

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is Timer && other.id == id;
}
