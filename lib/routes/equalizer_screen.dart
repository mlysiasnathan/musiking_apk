import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_tab_screen_bottom_bar.dart';

class EqualizerScreen extends StatelessWidget {
  const EqualizerScreen({Key? key}) : super(key: key);
  static const routeName = '/equalizer';

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
        child: Center(
            child: Text('For the Equalizer keep waiting for the next update')));
  }
}
