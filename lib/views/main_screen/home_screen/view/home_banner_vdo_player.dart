import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/common/extensions.dart';
import 'package:laundry/common_widgets/common_functions.dart';
import 'package:laundry/common_widgets/three_bounce.dart';
import 'package:laundry/main.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:laundry/views/main_screen/home_screen/view_model/home_view_model.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key, required this.link});
  final String link;

  @override
  _VideoScreenState createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> with RouteAware {
  // VideoPlayerController? _controller;
  bool isLoading = true; // To track the loading state
  bool isError = false; // To track if an error occurred
  HomeProvider? homeProvider;

  @override
  void initState() {
    super.initState();
    CommonFunctions.afterInit(() {
      homeProvider = context.read<HomeProvider>();
      _initializeCachedVideo();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  Future<void> _initializeCachedVideo() async {
    setState(() {
      isLoading = true;
      isError = false;
    });

    try {
      final file = await DefaultCacheManager().getSingleFile(widget.link);
      homeProvider?.videoController = VideoPlayerController.file(file)
        ..initialize().then((_) {
          setState(() {
            isLoading = false; // Stop loading when video is initialized
          });
          homeProvider?.videoController?.play();
          homeProvider?.videoController?.setLooping(true);
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
    return Stack(
      children: [
        isError
            ? Center(
                child: Image.network(
                  'https://media.istockphoto.com/id/1147544807/vector/thumbnail-image-vector-graphic.jpg?s=612x612&w=0&k=20&c=rnCKVbdxqkjlcs3xH87-9gocETqpspHFXu5dIGB4wuM=',
                  width: 150.w,
                  height: 150.h,
                ),
              )
            : homeProvider?.videoController != null &&
                    homeProvider!.videoController!.value.isInitialized
                ? LayoutBuilder(
                    builder: (context, constraints) {
                      double videoWidth =
                          constraints.maxWidth; // Full screen width
                      double videoHeight = videoWidth /
                          homeProvider!.videoController!.value
                              .aspectRatio; // Same height as the video
                      return SizedBox(
                        width: double.infinity, // Full width of the screen
                        height: context.sw(size: 1.2.h),
                        child: AspectRatio(
                          aspectRatio:
                              homeProvider!.videoController!.value.aspectRatio,
                          child: VideoPlayer(homeProvider!.videoController!),
                        ),
                      );
                    },
                  )
                : Container(),
        if (isLoading)
          Center(
            child: ThreeBounce(
              color: ColorPalette.primaryColor,
              size: 25.r,
            ),
          ),
      ],
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    homeProvider?.videoController?.pause();
    homeProvider?.videoController?.dispose();
    super.dispose();
  }

  @override
  void didPushNext() {
    // Called when navigating to another page
    homeProvider?.videoController?.pause();
  }

  @override
  void didPopNext() {
    // Called when returning to this page
    homeProvider?.videoController?.play();
  }
}
