import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: const Icon(
        CupertinoIcons.square_grid_2x2,
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 19),
          child: IconButton(
            splashRadius: 25,
            onPressed: () {},
            icon: const Icon(
              CupertinoIcons.gear_alt,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(50);
}
