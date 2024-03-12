import 'dart:async';

typedef CountdownCallback = void Function(String formattedTime);

class CountdownTimer {
  late Timer _timer;
  late int _countdown;

  CountdownTimer({required int duration}) {
    _countdown = duration;
  }

  void startCountdown(CountdownCallback callback) {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (timer) {
      if (_countdown > 0) {
        _countdown--;
        callback(formatCountdown());
      } else {
        _timer.cancel();
      }
    });
  }

  String formatCountdown() {
    final minutes = _countdown ~/ 60;
    final seconds = _countdown % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void cancel() {
    _timer.cancel();
  }
}
