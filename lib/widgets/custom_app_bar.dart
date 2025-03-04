import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key, this.title}) : super(key: key);
  final Text? title;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(150);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool isExpended = false;
  bool isTrue = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Size deviceSize = MediaQuery.of(context).size;
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          height: isExpended ? 100 : 90,
          curve: Curves.easeOut,
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: widget.title,
            leading: Icon(
              CupertinoIcons.square_grid_2x2,
              color: theme.colorScheme.background,
            ),
            actions: [
              CircleAvatar(
                backgroundColor: isExpended
                    ? theme.colorScheme.background.withOpacity(0.8)
                    : null,
                child: IconButton(
                  splashRadius: 25,
                  onPressed: () {
                    setState(() {
                      isExpended = !isExpended;
                    });
                  },
                  icon: Icon(
                    isExpended
                        ? CupertinoIcons.check_mark_circled
                        : CupertinoIcons.gear_alt,
                    color: isExpended
                        ? theme.primaryColor
                        : theme.colorScheme.background,
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
        if (isExpended)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: theme.colorScheme.background,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Appearance',
                  style: TextStyle(color: theme.primaryColor),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 40,
                      width: deviceSize.width * 0.4,
                      decoration: BoxDecoration(
                        border: Border.all(color: theme.primaryColor, width: 1),
                        color: theme.colorScheme.background,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 100),
                            left: themeProvider.themeMode == ThemeMode.light
                                ? 0
                                : deviceSize.width * 0.2,
                            right: themeProvider.themeMode == ThemeMode.light
                                ? deviceSize.width * 0.2
                                : 0,
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              height: 40,
                              width: deviceSize.width * 0.1,
                              decoration: BoxDecoration(
                                color:
                                    themeProvider.themeMode == ThemeMode.system
                                        ? Colors.transparent
                                        : theme.primaryColorLight,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: themeProvider.setLightTheme,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Light',
                                      style: TextStyle(
                                        color: themeProvider.themeMode ==
                                                ThemeMode.light
                                            ? theme.colorScheme.background
                                            : theme.primaryColor,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Icon(
                                      CupertinoIcons.sun_max_fill,
                                      color: themeProvider.themeMode ==
                                              ThemeMode.light
                                          ? theme.colorScheme.background
                                          : theme.primaryColor,
                                      size: 15,
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: themeProvider.setDarkTheme,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Dark',
                                      style: TextStyle(
                                        color: themeProvider.themeMode ==
                                                ThemeMode.dark
                                            ? theme.colorScheme.background
                                            : theme.primaryColor,
                                        fontSize: 13,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Icon(
                                      CupertinoIcons.moon_fill,
                                      color: themeProvider.themeMode ==
                                              ThemeMode.dark
                                          ? theme.colorScheme.background
                                          : theme.primaryColor,
                                      size: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: themeProvider.followTheSystem,
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        height: 40,
                        width: deviceSize.width * 0.25,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: theme.primaryColor, width: 1),
                          color: themeProvider.themeMode != ThemeMode.system
                              ? Colors.transparent
                              : theme.primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'System',
                              style: TextStyle(
                                color:
                                    themeProvider.themeMode != ThemeMode.system
                                        ? theme.primaryColor
                                        : theme.colorScheme.background,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Icon(
                              Icons.link,
                              color: themeProvider.themeMode != ThemeMode.system
                                  ? theme.primaryColor
                                  : theme.colorScheme.background,
                              size: 15,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
      ],
    );
  }
}
