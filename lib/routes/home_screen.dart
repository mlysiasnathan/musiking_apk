import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import '../models/playlist_model.dart';
import '../models/playlists_provider.dart';
import '../models/song_model.dart';
import '../models/songs_provider.dart';
import '../widgets/custom_bottom_bar.dart';
import '../widgets/playlist_card.dart';
import '../widgets/section_header.dart';
import '../widgets/song_card.dart';
import '../widgets/song_card_local.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  @override
  void initState() {
    requestStoragePermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final songsData = Provider.of<Songs>(context, listen: false);
    final songs = songsData.songs;
    final playlists = Provider.of<Playlists>(context, listen: false).playlists;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.red.withOpacity(0.8),
            Colors.orange.withOpacity(0.8),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const _CustomAppBar(),
        bottomNavigationBar: const CustomBottomBar(indexPage: 0),
        floatingActionButton: const _PrePlayingSong(),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.miniCenterFloat,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const _DiscoverMusic(),
              _AlbumMusic(playlists: playlists),
              _PlaylistMusic(songs: songs),
              _LocalPlaylistMusic(audioQuery: _audioQuery),
            ],
          ),
        ),
      ),
    );
  }

  void requestStoragePermission() async {
    // only if platform is not web, coz web have no permission
    if (!kIsWeb) {
      bool permissionStatus = await _audioQuery.permissionsStatus();
      if (!permissionStatus) {
        await _audioQuery.permissionsRequest();
      }
      // ensure build method is called
      setState(() {});
    }
  }
}

class _CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const _CustomAppBar({
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

class _PrePlayingSong extends StatelessWidget {
  const _PrePlayingSong({
    Key? key,
    // required this.song,
  }) : super(key: key);

  // final Song song;

  @override
  Widget build(BuildContext context) {
    final songData = Provider.of<Songs>(context);

    return ChangeNotifierProvider(
      create: (c) => songData.currentSong,
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width * 0.96,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Flexible(
              fit: FlexFit.tight,
              child: InkWell(
                onTap: () {
                  // songData.setPosition();
                  Get.toNamed('/song', arguments: songData.currentSong);
                },
                borderRadius: BorderRadius.circular(5),
                child: Row(
                  children: [
                    const SizedBox(width: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Hero(
                        tag: songData.currentSong.title,
                        child: Image.asset(
                          songData.currentSong.coverUrl,
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 18),
                    Text(
                      songData.currentSong.title,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
                          ),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
              splashRadius: 40,
              splashColor: Colors.deepOrange,
              onPressed: () {
                songData.playPause(songData.currentSong);
              },
              icon: Icon(
                songData.isPlaying
                    ? CupertinoIcons.pause_circle
                    : CupertinoIcons.play_circle,
                color: Colors.deepOrange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaylistMusic extends StatelessWidget {
  const _PlaylistMusic({
    Key? key,
    required this.songs,
  }) : super(key: key);

  final List<Song> songs;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(19),
      child: Column(
        children: [
          const SectionHeader(title: 'All Songs'),
          ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.only(top: 14),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: songs.length,
            itemBuilder: ((context, index) {
              return SongCard(song: songs[index]);
            }),
          ),
        ],
      ),
    );
  }
}

class _AlbumMusic extends StatelessWidget {
  const _AlbumMusic({
    Key? key,
    required this.playlists,
  }) : super(key: key);

  final List<Playlist> playlists;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 14,
        top: 14,
        bottom: 14,
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(right: 14),
            child: SectionHeader(
              title: "Albums",
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.27,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: playlists.length,
              itemBuilder: (context, index) {
                return PlaylistCard(playlist: playlists[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}

class _DiscoverMusic extends StatelessWidget {
  const _DiscoverMusic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            style: const TextStyle(
                color: Colors.deepOrange, fontWeight: FontWeight.bold),
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

class _LocalPlaylistMusic extends StatelessWidget {
  const _LocalPlaylistMusic({
    Key? key,
    required OnAudioQuery audioQuery,
  })  : _audioQuery = audioQuery,
        super(key: key);

  final OnAudioQuery _audioQuery;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SongModel>>(
      //default values
      future: _audioQuery.querySongs(
          sortType: null,
          ignoreCase: true,
          uriType: UriType.EXTERNAL,
          orderType: OrderType.ASC_OR_SMALLER),
      builder: (context, item) {
        //loading content indicator
        if (item.data == null) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        // no songs found
        if (item.data!.isEmpty) {
          return const Center(
            child: Text('No songs found in this device'),
          );
        }
        //show songs
        return Padding(
          padding: const EdgeInsets.all(19),
          child: Column(
            children: [
              const SectionHeader(title: 'Local Songs'),
              ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 14),
                physics: const NeverScrollableScrollPhysics(),
                itemCount: item.data!.length,
                itemBuilder: ((context, index) {
                  return SongCardLocal(song: item.data![index]);
                }),
              ),
            ],
          ),
        );
      },
    );
  }
}
