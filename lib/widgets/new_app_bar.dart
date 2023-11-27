import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:musiking/models/models.dart';
import 'package:provider/provider.dart';

class NewAppBar extends StatefulWidget {
  const NewAppBar({super.key});

  @override
  State<NewAppBar> createState() => _NewAppBarState();
}

class _NewAppBarState extends State<NewAppBar> {
  bool expandedSettings = false;
  bool isTrue = false;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color primaryColorLight = theme.primaryColorLight;
    final Color primaryColor = theme.primaryColor;
    final Size deviceSize = MediaQuery.of(context).size;
    final themeData = Provider.of<ThemeProvider>(context);
    return SafeArea(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                CupertinoIcons.square_grid_2x2,
                color: theme.colorScheme.background,
              ),
              IconButton(
                splashRadius: 25,
                onPressed: () {
                  setState(() {
                    expandedSettings = !expandedSettings;
                  });
                },
                icon: Icon(
                  expandedSettings
                      ? CupertinoIcons.check_mark
                      : CupertinoIcons.gear_alt,
                  color: theme.colorScheme.background,
                ),
              ),
            ],
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(13),
              color: theme.colorScheme.background,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            height: expandedSettings ? 100 : 0,
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
                    GestureDetector(
                      onTap: () {
                        // setState(() {
                        //   themeData.themeMode == ThemeMode.light
                        //       ? themeData.themeMode = ThemeMode.dark
                        //       : themeData.themeMode = ThemeMode.light;
                        // });
                        themeData.toggleDarkLight();
                      },
                      child: Container(
                        height: 40,
                        width: deviceSize.width * 0.4,
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor, width: 1),
                          color: theme.colorScheme.background,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            AnimatedPositioned(
                              duration: const Duration(milliseconds: 100),
                              left: themeData.themeMode == ThemeMode.light
                                  ? 0
                                  : deviceSize.width * 0.2,
                              right: themeData.themeMode == ThemeMode.light
                                  ? deviceSize.width * 0.2
                                  : 0,
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                height: 40,
                                width: deviceSize.width * 0.1,
                                decoration: BoxDecoration(
                                  color: themeData.themeMode == ThemeMode.system
                                      ? Colors.transparent
                                      : primaryColorLight,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Light',
                                        style: TextStyle(
                                          color: themeData.themeMode ==
                                                  ThemeMode.light
                                              ? theme.colorScheme.background
                                              : primaryColor,
                                          fontSize: 13,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Icon(
                                        CupertinoIcons.sun_max_fill,
                                        color: themeData.themeMode ==
                                                ThemeMode.light
                                            ? theme.colorScheme.background
                                            : primaryColor,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Dark',
                                        style: TextStyle(
                                          color: themeData.themeMode ==
                                                  ThemeMode.dark
                                              ? theme.colorScheme.background
                                              : primaryColor,
                                          fontSize: 13,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Icon(
                                        CupertinoIcons.moon_fill,
                                        color: themeData.themeMode ==
                                                ThemeMode.dark
                                            ? theme.colorScheme.background
                                            : primaryColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // setState(() {
                        //   themeData.themeMode == ThemeMode.light
                        //       ? themeData.themeMode = ThemeMode.system
                        //       : themeData.themeMode == ThemeMode.dark
                        //           ? themeData.themeMode = ThemeMode.system
                        //           : themeData.themeMode = ThemeMode.light;
                        // });
                        themeData.followTheSystem();
                      },
                      child: Container(
                        padding: const EdgeInsets.all(3),
                        height: 40,
                        width: deviceSize.width * 0.25,
                        decoration: BoxDecoration(
                          border: Border.all(color: primaryColor, width: 1),
                          color: themeData.themeMode != ThemeMode.system
                              ? theme.colorScheme.background
                              : primaryColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'System',
                                style: TextStyle(
                                  color: themeData.themeMode != ThemeMode.system
                                      ? primaryColor
                                      : theme.colorScheme.background,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Icon(
                                CupertinoIcons.link,
                                color: themeData.themeMode != ThemeMode.system
                                    ? primaryColor
                                    : theme.colorScheme.background,
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
