class TimeWatcher {
  static TimeWatcher _instance;
  static Stopwatch _stopwatch;

  TimeWatcher._();

  static TimeWatcher getInstance() {
    _instance ??= TimeWatcher._();
    _stopwatch ??= Stopwatch();
    return _instance;
  }

  void start() {
    _stopwatch.start();
  }

  void stop() {
    _stopwatch.stop();
  }

  void reset() {
    _stopwatch.reset();
  }

  Duration elapsedDuration() {
    return _stopwatch.elapsed;
  }
}
