import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:laundry/utils/color_palette.dart';
import 'package:shimmer/shimmer.dart';

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

extension ListExtension on List? {
  bool get notEmpty => (this ?? []).isNotEmpty;
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

  Widget addShimmer({Color? baseColor, Color? highlightColor}) {
    return Shimmer.fromColors(
      baseColor: ColorPalette.shimmerBaseColor,
      highlightColor: ColorPalette.shimmerHighlightColor,
      child: this,
    );
  }

  Widget translateWidgetVertically({double value = 0}) {
    return Transform.translate(
      offset: Offset(0.0, value),
      child: this,
    );
  }

  Widget translateWidgetHorizontally({double value = 0}) {
    return Transform.translate(
      offset: Offset(value, 0.0),
      child: this,
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

extension TextExtension on Text {
  Text avoidOverFlow({int maxLine = 1}) {
    return Text(
      (data ?? '').trim().replaceAll('', '\u200B'),
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
    );
  }

  Text addEllipsis({int maxLine = 1}) {
    return Text(
      (data ?? '').trim(),
      style: style,
      strutStyle: strutStyle,
      maxLines: maxLine,
      overflow: TextOverflow.ellipsis,
    );
  }
}
