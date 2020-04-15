import 'dart:math';

extension DurationExtension on Duration {
  String print() {
    if (this == null) {
      return '00:00';
    }

    String twoDigits(int n) => (n >= 10) ? '$n' : '0${max(0, n)}';

    String twoDigitMinutes = twoDigits(this.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(this.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }
}
