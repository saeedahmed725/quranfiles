import 'package:flutter/material.dart';
import '../../../../core/constants/app_json.dart';

class QuranPageView extends StatelessWidget {
  const QuranPageView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Image.asset(
          AppJsonAndImage.surahPageNumberPath!,
          height: screenHeight,
          width: screenWidth,
          fit: BoxFit.contain,
        ),
        Image.asset(
          AppJsonAndImage.surahPagePath!,
          height: screenHeight,
          width: screenWidth,
          fit: BoxFit.contain,
        ),
      ],
    );
  }
}
