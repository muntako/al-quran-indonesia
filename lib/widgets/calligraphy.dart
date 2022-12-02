import 'package:al_quran/configs/app_dimensions.dart';
import 'package:al_quran/utils/assets.dart';
import 'package:flutter/material.dart';

class Calligraphy extends StatelessWidget {
  const Calligraphy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      StaticAssets.gradLogo,
      height: AppDimensions.normalize(75),
    );
  }
}
