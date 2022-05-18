import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../models/TimerModel.dart';
import "../../utils/MyCountdownController.dart";

class TimerWidget extends StatefulWidget {
  final TimerItem timer;
  final MyCountdownController _controller =
      new MyCountdownController(autoStart: false);

  TimerWidget({Key key, this.timer}) : super(key: key);

  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  // function to format the time
  String _formatTime(int time) {
    final hours = time ~/ 3600;
    final minutes = (time % 3600) ~/ 60;
    final seconds = (time % 3600) % 60;
    return '${hours.toString().padLeft(2, '0')}:' +
        '${minutes.toString().padLeft(2, '0')}:' +
        '${seconds.toString().padLeft(2, '0')}';
  }

  Icon getIcon() {
    if (widget._controller.isPaused) {
      return Icon(Icons.play_arrow);
    } else {
      return Icon(Icons.pause);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.timer.name,
                  style: TextStyle(fontSize: 20),
                ),
                Countdown(
                  controller: widget._controller,
                  seconds: widget.timer.time,
                  build: (_, double time) {
                    return Text(
                      _formatTime(time.toInt()),
                      style: TextStyle(fontSize: 18),
                    );
                  },
                  interval: Duration(seconds: 1),
                  onFinished: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${widget.timer.name} is done!')),
                    );
                    widget._controller.restart();
                    widget._controller.pause();
                    setState(() {});
                  },
                )
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.delete),
                      tooltip: "Delete",
                      onPressed: () =>
                          context.read<TimersModel>().remove(widget.timer.id),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (widget._controller.isPaused) {
                            widget._controller.start();
                          } else {
                            widget._controller.pause();
                          }
                        });
                      },
                      tooltip: 'Play/Pause',
                      icon: getIcon(),
                    ),
                    IconButton(
                      icon: Icon(Icons.stop),
                      tooltip: "Stop",
                      onPressed: () {
                        setState(() {
                          widget._controller.restart();
                          widget._controller.pause();
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
