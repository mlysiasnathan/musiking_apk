import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../helpers/constant.dart';
import '../providers/theme_provider.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  void requestStoragePermission() async {
    // only if platform is not web, coz web have no permission
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
      // ensure build method is called
      // setState(() {});
    }
  }
  int _currentPage = 0;
  final PageController _controller = PageController();
  final List<Map<String, dynamic>> demoData = [
    {
      'image': imageList[0],
      'title': 'Discover your sound',
      'desc': 'Explore the latest hits and timeless classics curated just for you'
    },
    {
      'image': imageList[0],
      'title': 'Stream in style',
      'desc':
          'Access to millions of tracks and create your perfect playlist on the go'
    },
    {
      'image': imageList[0],
      'title': 'Feel the Beat',
      'desc': 'Experience immersive audio and playlists tailored to every mood'
    },
  ];

  @override
  Widget build(BuildContext context) {
    void getStarted() {
      requestStoragePermission();
      Provider.of<ThemeProvider>(context, listen: false).getStarted();
    }

    final ThemeData theme = Theme.of(context);
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemCount: demoData.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      AspectRatio(
                        aspectRatio: 1,
                        child: Image.asset(demoData[index]['image']),
                      ),
                      Text(
                        demoData[index]['title'],
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontSize: deviceSize.width * 0.07,
                          fontWeight: FontWeight.w900,
                          overflow: TextOverflow.ellipsis,
                          color: theme.primaryColor,
                        ),
                        maxLines: 3,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        demoData[index]['desc'],
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontSize: deviceSize.width * 0.04,
                          overflow: TextOverflow.ellipsis,
                          color: theme.primaryColor,
                        ),
                        maxLines: 4,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    child: _currentPage == demoData.length - 1
                        ? null
                        : GestureDetector(
                            onTap: () =>
                                _controller.jumpToPage(demoData.length),
                            child: Text(
                              'Skip',
                              style: TextStyle(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      demoData.length,
                      (index) => AnimatedContainer(
                        height: 6,
                        width: _currentPage == index ? 20 : 6,
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? theme.primaryColor
                              : theme.primaryColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: _currentPage == demoData.length - 1
                        ? TextButton(
                            onPressed: getStarted,
                            child: Text(
                              'GET STARTED',
                              style: TextStyle(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.w900,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : GestureDetector(
                            onTap: () => _controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeIn),
                            child: Text(
                              'Next',
                              style: TextStyle(
                                color: theme.primaryColor,
                                fontWeight: FontWeight.w900,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
