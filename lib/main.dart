import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse('https://github.com/Arulthas05');

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: NavigationDrawer(),
        appBar: AppBar(
          title: const Text('Favourites'),
          backgroundColor: Colors.green,
        ),
      );
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: '',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final player = AudioPlayer();
  bool isPlaying = false;
  // Duration duration = Duration.zero;
  // Duration position = Duration.zero;

  // String formatTime(int seconds) {
  //   return '${(Duration(seconds: seconds))}'.split('.')[0].padLeft(8, '0');
  // }

  @override
  void initState() {
    super.initState();

    player.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    // player.onDurationChanged.listen((newDuration) {
    //   setState(() {
    //     duration = newDuration;
    //   });
    // });
    //
    // player.onPositionChanged.listen((newPosition) {
    //   setState(() {
    //     position = newPosition;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Center(
          child: Text(widget.title),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/ThadamFm.jpg"),
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/ThadamFm1.png',
              height: 400,
              width: 400,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 24,
                ),
                CircleAvatar(
                  radius: 25,
                  child: IconButton(
                    icon: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                    ),
                    onPressed: () {
                      if (isPlaying) {
                        player.pause();
                      } else {
                        player.play(
                            UrlSource('https://s4.voscast.com:8933/stream'));
                      }
                    },
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                // CircleAvatar(
                //   radius: 25,
                //   child: IconButton(
                //     icon: const Icon(Icons.stop),
                //     onPressed: () {
                //       player.stop();
                //     },
                //   ),
                // ),
              ],
            ),
            // Slider(
            //   min: 0,
            //   max: duration.inSeconds.toDouble(),
            //   value: position.inSeconds.toDouble(),
            //   onChanged: (value) {
            //     final position = Duration(seconds: value.toInt());
            //     player.seek(position);
            //     player.resume();
            //   },
            // ),
            // Container(
            //   padding: const EdgeInsets.all(20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(formatTime(position.inSeconds)),
            //       Text(formatTime((duration - position).inSeconds)),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
      drawer: const NavigationDrawer(),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Drawer(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              buildHeader(context),
              buildMenuItems(context),
            ],
          ),
        ),
      );

  Widget buildHeader(BuildContext context) => Container(
        color: Colors.blue.shade700,
        padding: EdgeInsets.only(
          top: 24 + MediaQuery.of(context).padding.top,
          bottom: 24,
        ),
        child: Column(
          children: const [
            CircleAvatar(
              radius: 52,
              backgroundImage: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVhrpqzijMh02JGPnFFzDtANMKB5Svo6d_W3iVd6Qt&s'),
            ),
            SizedBox(
              height: 12,
            ),
            Text(
              'Arul',
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
              ),
            ),
          ],
        ),
      );

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // IconButton(
            //   icon: Icon(Icons.facebook),
            //   onPressed: _launchUrl,
            // ),
            ListTile(
              leading: const Icon(Icons.home_outlined),
              title: const Text('Home'),
              onTap: _launchUrl,
              //      () {
              //  Navigator.of(context).pushReplacement(MaterialPageRoute(
              //     builder: (context) => const MyHomePage(
              //       title: 'Audio Player',
              //     ),
              //
              //   ));
              // },
            ),
            ListTile(
              leading: const Icon(Icons.favorite_border),
              title: const Text('Favourties'),
              onTap: () {
                Navigator.pop(context);

                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const FavouritesPage(),
                ));
              },
            ),
            ListTile(
              leading: const Icon(Icons.workspaces_outlined),
              title: const Text('Workflow'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.update),
              title: const Text('Updates'),
              onTap: () {},
            ),
          ],
        ),
      );
}

Future<void> _launchUrl() async {
  if (!await launchUrl(_url)) {
    throw Exception('$_url');
  }
}
