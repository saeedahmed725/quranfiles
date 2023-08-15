import 'package:flutter/material.dart';
import '../../../../core/constants/appcolor.dart';
import '../../../../data/model/verse_page_model/verse_page_model.dart';

class VerseHighlightPainter extends CustomPainter {
  final List<Verse> verses;
  final List<bool> selectedVerses;

  VerseHighlightPainter({required this.verses, required this.selectedVerses});

  @override
  void paint(Canvas canvas, Size size) {
    double scaleFactor = size.width / 1260;
    double padding = 0.0;
    double borderRadius = 4.0;
    for (int index = 0; index < selectedVerses.length; index++) {
      if (!selectedVerses[index]) continue;
      List<Verse> verseParts = verses
          .where((v) =>
      v.ayahNumber == verses[index].ayahNumber &&
          v.suraNumber == verses[index].suraNumber).toList();
      for (Verse verse in verseParts) {
        debugPrint(verse.ayahNumber.toString());
        Rect rect = Rect.fromLTRB(
          (verse.minX - padding) * scaleFactor,
          (verse.minY - padding) * scaleFactor,
          (verse.maxX + padding) * scaleFactor,
          (verse.maxY + padding) * scaleFactor,
        );
        RRect roundedRect =
        RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));
        Paint paint = Paint()..color = AppColor.kPrimaryColor.withOpacity(0.3);
        canvas.drawRRect(roundedRect, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}