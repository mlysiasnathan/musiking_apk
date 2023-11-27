import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/new_app_bar.dart';

class EqualizerScreen extends StatelessWidget {
  const EqualizerScreen({Key? key}) : super(key: key);
  bool get wantKeepAlive => true;
  static const routeName = '/equalizer';

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return SingleChildScrollView(
        key: const ValueKey('equalizer'),
        child: Column(
          children: [
            const NewAppBar(),
            const SizedBox(height: 10),
            Text(
              'For the Equalizer keep waiting for the next update',
              style: theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
            ),
          ],
        ));
  }
}
