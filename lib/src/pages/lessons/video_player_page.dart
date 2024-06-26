import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:guitar_mentor/src/helpers/theme_colors.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'comments_section.dart';

class VideoPlayerPage extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerPage({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  YoutubePlayerController? _controller;
  String? _videoId;

  @override
  void initState() {
    super.initState();
    _videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);

    if (_videoId != null) {
      _controller = YoutubePlayerController(
        initialVideoId: _videoId!,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      )..addListener(listener);
    } else {
      // Handle invalid URL or extraction failure
      print("Error: Invalid YouTube URL");
    }
  }

  void listener() {
    if (_controller?.value.errorCode != null) {
      print(_controller?.value.errorCode);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller!,
        showVideoProgressIndicator: true,
        onReady: () {
          print('Player is ready.');
        },
        onEnded: (data) {
          _controller!
            ..load(_videoId!)
            ..play();
        },
      ),
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Video Player'),
            backgroundColor: ThemeColors.primaryColor,
          ),
          body: Column(
            children: [
              player,
              Expanded(
                child: CommentsSection(), // Agrega la sección de comentarios aquí
              ),
            ],
          ),
        );
      },
    );
  }
}

