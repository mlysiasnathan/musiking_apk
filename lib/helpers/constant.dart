const String appName = 'Musiking';
const List<String> imageList = [
  'assets/images/musiking.png',
  'assets/images/logo_mini.png',
];

String formatDuration(int? dur) {
  final duration = Duration(milliseconds: dur!.toInt());
  String minutes = duration.inMinutes.toString().padLeft(2, '0');
  String seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}
