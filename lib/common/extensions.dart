import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension Context on BuildContext {
  double sh({double size = 1.0}) {
    return MediaQuery.of(this).size.height * size;
  }

  double sw({double size = 1.0}) {
    return MediaQuery.of(this).size.width * size;
  }

  int cacheSize(double size) {
    return (size * MediaQuery.of(this).devicePixelRatio).round();
  }

  void get rootPop => Navigator.of(this, rootNavigator: true).pop();

  double validateScale({double defaultVal = 0.0}) {
    double value = MediaQuery.of(this).textScaleFactor;
    double pixelRatio = ScreenUtil().pixelRatio ?? 0.0;
    0;
    if (value <= 1.0) {
      defaultVal = defaultVal;
    } else if (value >= 1.3) {
      defaultVal = value - 0.2;
    } else if (value >= 1.1) {
      defaultVal = value - 0.1;
    }
    if (pixelRatio <= 3.0) {
      defaultVal = defaultVal + 0;
    } else if (value >= 3.15) {
      defaultVal = defaultVal + 0.6;
    } else if (value >= 1.1) {
      defaultVal = defaultVal + 0.8;
    }
    return defaultVal;
  }
}

extension WidgetExtension on Widget {
  Widget withBackgroundImage() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bg_image.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: this, // Preserve the child of the original Container
    );
  }
}

extension InkWellExtension on InkWell {
  InkWell removeSplash({Color color = Colors.white}) {
    return InkWell(
      onTap: onTap,
      splashColor: color,
      highlightColor: color,
      child: child,
    );
  }
}

