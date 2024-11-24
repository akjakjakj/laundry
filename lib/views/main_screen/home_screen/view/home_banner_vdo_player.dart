import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common_widgets/three_bounce.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key, required this.link});
  final String link;

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  VideoPlayerController? _controller;
  bool isLoading = true; // To track the loading state
  bool isError = false; // To track if an error occurred

  @override
  void initState() {
    super.initState();
    _initializeCachedVideo();
  }

  Future<void> _initializeCachedVideo() async {
    setState(() {
      isLoading = true;
      isError = false;
    });

    try {
      final file = await DefaultCacheManager().getSingleFile(widget.link);
      _controller = VideoPlayerController.file(file)
        ..initialize().then((_) {
          setState(() {
            isLoading = false; // Stop loading when video is initialized
          });
          _controller?.play();
          _controller?.setLooping(true);
        }).catchError((_) {
          // Handle initialization errors
          setState(() {
            isLoading = false;
            isError = true;
          });
        });
    } catch (error) {
      setState(() {
        isLoading = false;
        isError = true; // Mark as error state if caching fails
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Stack(
        children: [
          Center(
            child: isError
                ? Image.network(
                    'https://media.istockphoto.com/id/1147544807/vector/thumbnail-image-vector-graphic.jpg?s=612x612&w=0&k=20&c=rnCKVbdxqkjlcs3xH87-9gocETqpspHFXu5dIGB4wuM=',
                    width: 150.w,
                    height: 150.h,
                  )
                : _controller != null && _controller!.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller!.value.aspectRatio,
                        child: VideoPlayer(_controller!),
                      )
                    : Container(),
          ),
          if (isLoading)
            Center(
              child: ThreeBounce(
                color: ColorPalette.primaryColor,
                size: 25.r,
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
