/// Single source of "now" so tests can move time.
DateTime Function() clock = () => DateTime.now().toUtc();
