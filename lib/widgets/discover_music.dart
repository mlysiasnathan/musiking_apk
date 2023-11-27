import 'package:flutter/material.dart';
import 'package:musiking/widgets/new_app_bar.dart';

class DiscoverMusic extends StatelessWidget {
  const DiscoverMusic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color primaryColorLight = theme.primaryColorLight;
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const NewAppBar(),
          Text(
            'Musiking',
            style: theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 4),
          Text(
            'Enjoy your favorites Musics',
            style: theme.textTheme.headline6!
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 14),
          TextFormField(
            style: TextStyle(
                color: primaryColorLight, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              fillColor: theme.colorScheme.background,
              filled: true,
              isDense: true,
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13),
                borderSide: BorderSide.none,
              ),
              hintStyle:
                  theme.textTheme.bodyMedium!.copyWith(color: Colors.grey),
              hintText: 'Search',
            ),
          )
        ],
      ),
    );
  }
}
