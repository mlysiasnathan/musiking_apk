import 'package:flutter/material.dart';
import 'package:musiking/helpers/constant.dart';
import 'package:musiking/widgets/new_app_bar.dart';

class DiscoverMusic extends StatelessWidget {
  const DiscoverMusic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const NewAppBar(),
          Text(
            appName,
            style: theme.textTheme.titleMedium!.copyWith(
              color: theme.colorScheme.background,
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Enjoy your favorites Musics',
            style: theme.textTheme.headlineSmall!.copyWith(
              color: theme.colorScheme.background,
            ),
          ),
          const SizedBox(height: 14),
          TextFormField(
            style: theme.textTheme.titleMedium!.copyWith(
              color: theme.primaryColor,
            ),
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search',
            ),
          )
        ],
      ),
    );
  }
}
