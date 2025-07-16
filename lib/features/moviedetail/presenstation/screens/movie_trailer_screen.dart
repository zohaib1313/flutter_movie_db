import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FullScreenTrailerPlayerScreen extends StatefulWidget {
  final String youtubeKey;

  const FullScreenTrailerPlayerScreen({super.key, required this.youtubeKey});

  @override
  State<FullScreenTrailerPlayerScreen> createState() =>
      _FullScreenTrailerPlayerScreenState();
}

class _FullScreenTrailerPlayerScreenState
    extends State<FullScreenTrailerPlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeKey,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        hideControls: false,
        forceHD: true,
        loop: false,
      ),
    );

    // Listen for video end
    _controller.addListener(() {
      if (_controller.value.playerState == PlayerState.ended) {
        Navigator.of(context).pop(); // Auto-close when trailer ends
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _exitPlayer() {
    Navigator.of(context).pop(); // Manual close via "Done" button
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              onReady: () => _controller.play(),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: 16,
            child: ElevatedButton(
              onPressed: _exitPlayer,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black87),
              child: const Text("Done", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}
