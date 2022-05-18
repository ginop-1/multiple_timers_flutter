import 'package:timer_count_down/timer_controller.dart';

class MyCountdownController extends CountdownController {
  @override
  bool isCompleted;

  bool isPaused;

  MyCountdownController(
      {autoStart = false, this.isCompleted = false, this.isPaused = true})
      : super(autoStart: autoStart);

  @override
  void start() {
    isPaused = false;
    super.start();
  }

  @override
  void pause() {
    isPaused = true;
    super.pause();
  }

  @override
  void resume() {
    isPaused = false;
    super.resume();
  }

  @override
  void restart() {
    isPaused = false;
    super.restart();
  }
}
