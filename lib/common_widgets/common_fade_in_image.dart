import 'package:flutter/material.dart';
import 'package:laundry/generated/assets.dart';

class CommonFadeInImage extends StatelessWidget {
  final String? image;
  final String? placeHolderImage;
  final BoxFit? fit;
  final BoxFit? placeholderFit;
  final Widget? imageErrorWidget;
  final Widget? placeholderErrorWidget;
  final double? height;
  final double? width;
  const CommonFadeInImage(
      {Key? key,
      required this.image,
      this.placeHolderImage,
      this.fit,
      this.placeholderFit,
      this.imageErrorWidget,
      this.placeholderErrorWidget,
      this.height,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      placeholder: placeHolderImage ?? Assets.imagesBgImage,
      image: image ?? "",
      fit: fit ?? BoxFit.contain,
      height: height ?? double.infinity,
      width: width ?? double.infinity,
      placeholderFit: placeholderFit ?? BoxFit.scaleDown,
      imageErrorBuilder: (_, __, ___) =>
          imageErrorWidget ?? const SizedBox.shrink(),
      placeholderErrorBuilder: (_, __, ___) =>
          placeholderErrorWidget ?? const SizedBox.shrink(),
    );
  }
}
