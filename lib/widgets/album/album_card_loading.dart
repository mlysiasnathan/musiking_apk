import 'package:flutter/material.dart';

class AlbumCardLoading extends StatelessWidget {
  const AlbumCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final deviceSize = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: theme.colorScheme.background,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: SizedBox(
            width: deviceSize.width * 0.43,
            height: deviceSize.width * 0.43,
          ),
        ),
        Container(
          height: deviceSize.height * 0.073,
          width: deviceSize.width * 0.37,
          margin: const EdgeInsets.only(bottom: 18),
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: theme.colorScheme.background.withOpacity(0.6),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: deviceSize.width * 0.23,
                height: 15,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: theme.primaryColor,
                ),
              ),
              Container(
                width: deviceSize.width * 0.1,
                height: 15,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
