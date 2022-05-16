import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../models/TimerModel.dart';
import '../utils/TextInputDialog.dart' as TextInputDialog;

class Mainbody extends StatelessWidget {
  const Mainbody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your timers List')),
      body: Container(
          child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: _TimersList(),
            ),
          )
        ],
      )),
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
      itemBuilder: (context, index) =>
          _TimerWidget(timer: timers.timers[index]),
      separatorBuilder: (context, index) => Divider(),
    );
  }
}

class _TimerWidget extends StatefulWidget {
  final TimerItem timer;
  final CountdownController _controller =
      new CountdownController(autoStart: false);

  _TimerWidget({Key key, this.timer}) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<_TimerWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 5, right: 10),
          child: Icon(Icons.timer),
        ),
        Text(widget.timer.name, style: TextStyle(fontSize: 18)),
        Spacer(),
        Countdown(
          controller: widget._controller,
          seconds: widget.timer.time,
          build: (_, double time) =>
              Text(time.toString(), style: TextStyle(fontSize: 18)),
          interval: Duration(seconds: 1),
          onFinished: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${widget.timer.name} is done!')),
            );
            widget._controller.restart();
            widget._controller.pause();
          },
        ),
        Spacer(),
        // Start or Resume
        IconButton(
          icon: Icon(Icons.play_arrow),
          onPressed: () {
            widget._controller.start();
          },
        ),
        // Pause
        IconButton(
          icon: Icon(Icons.pause),
          onPressed: () {
            widget._controller.pause();
          },
        ),
        // Stop
        IconButton(
          icon: Icon(Icons.stop),
          onPressed: () {
            widget._controller.restart();
            widget._controller.pause();
          },
        ),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => context.read<TimersModel>().remove(widget.timer.id),
        ),
      ],
    );
  }
}
