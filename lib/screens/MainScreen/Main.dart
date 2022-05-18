import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/TimerModel.dart';
import '../../utils/TextInputDialog.dart' as TextInputDialog;
import '../widgets/Timer.dart';

class Mainbody extends StatelessWidget {
  const Mainbody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your timers List')),
      body: _TimersList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => TextInputDialog.displayTextInputDialog(context),
        tooltip: 'Add Timer',
        child: Icon(Icons.add),
      ),
    );
  }
}

class _TimersList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var timers = context.watch<TimersModel>();

    return ListView.separated(
      itemCount: timers.timers.length,
      itemBuilder: (context, index) => TimerWidget(timer: timers.timers[index]),
      separatorBuilder: (context, index) => Divider(),
    );
  }
}
