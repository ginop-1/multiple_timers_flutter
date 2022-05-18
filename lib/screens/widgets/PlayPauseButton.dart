import 'package:flutter/material.dart';

class PlayPauseButton extends StatefulWidget {
  final Function startFn;
  final Function pauseFn;

  PlayPauseButton({Key key, this.startFn, this.pauseFn}) : super(key: key);

  @override
  _PlayPauseButtonState createState() => _PlayPauseButtonState();
}

class _PlayPauseButtonState extends State<PlayPauseButton> {
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          if (_isPlaying) {
            widget.pauseFn();
          } else {
            widget.startFn();
          }
          _isPlaying = !_isPlaying;
        });
      },
      tooltip: 'Play/Pause',
      icon: _isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
    );
  }
}
