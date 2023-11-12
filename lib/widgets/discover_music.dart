import 'package:flutter/material.dart';

class DiscoverMusic extends StatelessWidget {
  const DiscoverMusic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color primaryColorLight = Theme.of(context).primaryColorLight;
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Musiking',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 4),
          Text(
            'Enjoy your favorites Musics',
            style: Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          TextFormField(
            style: TextStyle(
                color: primaryColorLight, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              isDense: true,
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide.none),
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.grey),
              hintText: 'Search',
            ),
          )
        ],
      ),
    );
  }
}
