import 'package:flutter/material.dart';
import 'package:al_quran/configs/app_theme.dart';
import 'package:al_quran/configs/app_typography.dart';

class CustomAppBar extends StatelessWidget {
  final String? title;

  const CustomAppBar({Key? key, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const BackButton(),
        Text(
          title!,
          style: AppText.h3b!.copyWith(
            color:
                AppTheme.isDark(context) ? Colors.white : AppTheme.c!.textSub,
          ),
        )
      ],
    );
  }
}
