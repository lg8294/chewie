import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class MyDemo extends StatefulWidget {
  const MyDemo({Key? key, this.title = 'My Demo'}) : super(key: key);

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _MyDemoState();
  }
}

class _MyDemoState extends State<MyDemo> {
  TargetPlatform? _platform;
  late VideoPlayerController _videoPlayerController1;
  late VideoPlayerController _videoPlayerController2;
  VideoPlayerController? _videoPlayerController0;
  VideoPlayerController? _videoPlayerController0_1;
  late ChewieController _chewieController;
  late VoidCallback _logListener;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    const url = "https://www.w3schools.com/html/movie.mp4";
    const url1 = "https://media.w3.org/2010/05/sintel/trailer.mp4";
    const url2 = 'https://media.w3.org/2010/05/sintel/trailer.mp4';
    // _videoPlayerController0 = VideoPlayerController.network(url);
    // _videoPlayerController0.initialize().then((value) {
    //   _videoPlayerController0.setLooping(true);
    //   _videoPlayerController0.play();
    // });
    //
    // _videoPlayerController0_1 = VideoPlayerController.network(url2);
    // _videoPlayerController0_1.initialize().then((value) {
    //   _videoPlayerController0_1.setLooping(true);
    //   _videoPlayerController0_1.play();
    // });

    _videoPlayerController1 = VideoPlayerController.networkUrl(Uri.parse(url2));
    _videoPlayerController2 = VideoPlayerController.networkUrl(Uri.parse(url));
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      // aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
      // Try playing around with some of these other options:

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      autoInitialize: true,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
    );

    _logListener = () {
      if (kDebugMode) {
        print(_videoPlayerController1.value);
      }
    };
    _videoPlayerController1.addListener(_logListener);
    _videoPlayerController2.addListener(_logListener);
    _videoPlayerController0?.addListener(_logListener);
    _videoPlayerController0_1?.addListener(_logListener);
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
    _videoPlayerController0?.dispose();
    _videoPlayerController0_1?.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: widget.title,
      theme: ThemeData.light().copyWith(
        platform: _platform ?? Theme.of(context).platform,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Center(
                child: Chewie(
                  controller: _chewieController,
                ),
              ),
            ),
            if (_videoPlayerController0 != null ||
                _videoPlayerController0_1 != null)
              Row(
                children: <Widget>[
                  if (_videoPlayerController0 != null)
                    Flexible(
                      child: SizedBox(
                        height: 200,
                        child: VideoPlayer(_videoPlayerController0!),
                      ),
                    ),
                  if (_videoPlayerController0_1 != null)
                    Flexible(
                      child: SizedBox(
                        height: 200,
                        child: VideoPlayer(_videoPlayerController0_1!),
                      ),
                    ),
                ],
              ),
            TextButton(
              onPressed: () {
                _chewieController.enterFullScreen();
              },
              child: const Text('Fullscreen'),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _chewieController.dispose();
                        _videoPlayerController2.pause();
                        _videoPlayerController2.seekTo(Duration.zero);
                        _chewieController = ChewieController(
                          videoPlayerController: _videoPlayerController1,
                          // aspectRatio: 3 / 2,
                          autoPlay: true,
                          looping: true,
                          autoInitialize: true,
                        );
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text("Video 1"),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _chewieController.dispose();
                        _videoPlayerController1.pause();
                        _videoPlayerController1.seekTo(Duration.zero);
                        _chewieController = ChewieController(
                          videoPlayerController: _videoPlayerController2,
                          // aspectRatio: 3 / 2,
                          autoPlay: true,
                          looping: true,
                          autoInitialize: true,
                        );
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text("Error Video"),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _platform = TargetPlatform.android;
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text("Android controls"),
                    ),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        _platform = TargetPlatform.iOS;
                      });
                    },
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text("iOS controls"),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
