import 'package:poke_radar/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poke_radar/features/shared/shared.dart';

class ImageManager {
  static final ImageManager _instance = ImageManager._internal();

  ImageManager._internal();

  factory ImageManager() => _instance;

  final String avatar = '$baseImagePath/avatar.png';
  final String searchIcon = '$baseImagePath/search.svg';
  final String fillHeartIcon = '$baseImagePath/fill_heart.svg';
  final String outlinedHeartIcon = '$baseImagePath/outlined_heart.svg';

  Widget getImage(String path,
      {BoxFit fit = BoxFit.cover, double? width, double? height}) {
    return Image.asset(
      path,
      fit: fit,
      width: width,
      height: height,
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
        return const Icon(Icons.error, color: Colors.red);
      },
    );
  }

  Widget getSvgImage(
    String path, {
    BoxFit fit = BoxFit.cover,
    double? width,
    double? height,
    Color? color,
  }) {
    return SvgPicture.asset(
      path,
      fit: fit,
      width: width,
      height: height,
      colorFilter:
          color == null ? null : ColorFilter.mode(color, BlendMode.srcIn),
      placeholderBuilder: (BuildContext context) => const CustomLoading(),
    );
  }
}
