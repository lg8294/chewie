import 'package:chewie/chewie.dart';
import 'package:chewie/src/chewie_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(
    ChewieDemo(),
  );
}

class ChewieDemo extends StatefulWidget {
  ChewieDemo({this.title = 'Chewie Demo'});

  final String title;

  @override
  State<StatefulWidget> createState() {
    return _ChewieDemoState();
  }
}

class _ChewieDemoState extends State<ChewieDemo> {
  TargetPlatform _platform;
  VideoPlayerController _videoPlayerController1;
  VideoPlayerController _videoPlayerController2;
  VideoPlayerController _videoPlayerController0;
  VideoPlayerController _videoPlayerController0_1;
  ChewieController _chewieController;
  VoidCallback _logListener;

  @override
  void initState() {
    super.initState();
    final url =
        "https://hwkjoss-hwkjbucketname.oss-cn-hangzhou.aliyuncs.com/41b3aa604bb64c16a07d07840f0cad66.mp4?Expires=33124232671&OSSAccessKeyId=LTAI4FemYBqHEAdqfwawpHTH&Signature=vAG2FKn4wT9tLz8qI2FefwVLnmg%3D";
    final url1 =
        "http://vfx.mtime.cn/Video/2019/03/21/mp4/190321153853126488.mp4";
    final url2 =
        'http://vfx.mtime.cn/Video/2019/02/04/mp4/190204084208765161.mp4';
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

    _videoPlayerController1 = VideoPlayerController.network(url2);
    _videoPlayerController2 = VideoPlayerController.network(url);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 2,
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
    );

    _logListener = () {
      print(_videoPlayerController1.value);
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
            Container(
              height: 200,
              child: Chewie(
                controller: _chewieController,
              ),
            ),
            if (_videoPlayerController0 != null ||
                _videoPlayerController0_1 != null)
              Row(
                children: <Widget>[
                  if (_videoPlayerController0 != null)
                    Flexible(
                      child: Container(
                        height: 200,
                        child: VideoPlayer(_videoPlayerController0),
                      ),
                    ),
                  if (_videoPlayerController0_1 != null)
                    Flexible(
                      child: Container(
                        height: 200,
                        child: VideoPlayer(_videoPlayerController0_1),
                      ),
                    ),
                ],
              ),
            FlatButton(
              onPressed: () {
                _chewieController.enterFullScreen();
              },
              child: Text('Fullscreen'),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        _chewieController.dispose();
                        _videoPlayerController2.pause();
                        _videoPlayerController2.seekTo(Duration(seconds: 0));
                        _chewieController = ChewieController(
                          videoPlayerController: _videoPlayerController1,
                          // aspectRatio: 3 / 2,
                          autoPlay: true,
                          looping: true,
                          autoInitialize: true,
                        );
                      });
                    },
                    child: Padding(
                      child: Text("Video 1"),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        _chewieController.dispose();
                        _videoPlayerController1.pause();
                        _videoPlayerController1.seekTo(Duration(seconds: 0));
                        _chewieController = ChewieController(
                          videoPlayerController: _videoPlayerController2,
                          // aspectRatio: 3 / 2,
                          autoPlay: true,
                          looping: true,
                          autoInitialize: true,
                        );
                      });
                    },
                    child: Padding(
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
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        _platform = TargetPlatform.android;
                      });
                    },
                    child: Padding(
                      child: Text("Android controls"),
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                    ),
                  ),
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        _platform = TargetPlatform.iOS;
                      });
                    },
                    child: Padding(
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
