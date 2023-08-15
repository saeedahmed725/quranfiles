import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_kareem/view/widgets/cardse_screen_widget/quran_page_widget/page_border.dart';
import 'package:quran_kareem/view/widgets/cardse_screen_widget/quran_page_widget/quran_page_view.dart';
import 'package:quran_kareem/view/widgets/cardse_screen_widget/quran_page_widget/verse_highlight_painter.dart';
import '../../../../controller/cards_controllers/quran_controller/image_surah_page_controller.dart';

class ImageSurahBuilder extends StatelessWidget {
  const ImageSurahBuilder({
    super.key,
  });

  double calculateVerticalMargin(BoxConstraints constraints) {
    double screenSizeAverage =
        (constraints.maxWidth + constraints.maxHeight) / 2;
    return screenSizeAverage * 0.035;
  }

  @override
  Widget build(BuildContext context) {
    ImageSurahPageControllerImp controller =
        Get.put(ImageSurahPageControllerImp());
    return PageBorder(
      child: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
          onTap: () => controller.doubleTabShowAppBar(),
          ),
          SizedBox(
            height: 570,
            child: GestureDetector(
              onDoubleTapDown: (details) {
                controller.getTappedVerse(context, details);
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const QuranPageView(),
                  LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints innerConstraints) {
                      return Container(
                        margin: EdgeInsets.symmetric(
                          vertical:
                              min(calculateVerticalMargin(innerConstraints), 6),
                          horizontal: 16.0,
                        ),
                        child: AspectRatio(
                          aspectRatio: 5.7 / 9,
                          child: Transform.scale(
                            scale: 1.0,
                            child: GetBuilder<ImageSurahPageControllerImp>(
                                builder: (cxt) {
                              return CustomPaint(
                                foregroundPainter: VerseHighlightPainter(
                                  verses: controller.versesPage ?? [],
                                  selectedVerses: controller.selectedVerses!,
                                ),
                              );
                            }),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
