const String appName = 'Musiking';
const List<String> imageList = [
  'assets/musiccovers/musiking_logo.jpg',
  'assets/musiccovers/lysnB_land_logo_png.png',
  'assets/musiccovers/musiking_logo.png',
];

String formatDuration(int? dur) {
  final duration = Duration(milliseconds: dur!.toInt());
  String minutes = duration.inMinutes.toString().padLeft(2, '0');
  String seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}
