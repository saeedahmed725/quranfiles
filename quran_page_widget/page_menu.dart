import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quran_kareem/core/constants/appcolor.dart';

import '../../../../controller/cards_controllers/quran_controller/image_surah_page_controller.dart';

menu(BuildContext context, var details) {
  ImageSurahPageControllerImp controller =
  Get.put(ImageSurahPageControllerImp());

  BotToast.showAttachedWidget(
    target: details.globalPosition,
    preferDirection: PreferDirection.topCenter,
    verticalOffset: 15,
    animationDuration: const Duration(microseconds: 700),
    animationReverseDuration: const Duration(microseconds: 700),
    attachedBuilder: (cancel) => Card(
      color: AppColor.kPrimaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: 8.0,
            ),
            Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                  color: Color(0xfff3efdf),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: IconButton(
                icon: const Icon(
                  Icons.bookmark_border,
                  size: 24,
                  color: Color(0x99f5410a),
                ),
                onPressed: () {},
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                  color: Color(0xfff3efdf),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: IconButton(
                icon: const Icon(
                  Icons.copy_outlined,
                  size: 24,
                  color: Color(0x99f5410a),
                ),
                onPressed: () {},
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                  color: Color(0xfff3efdf),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: IconButton(
                icon: const Icon(
                  Icons.play_arrow_outlined,
                  size: 24,
                  color: Color(0x99f5410a),
                ),
                onPressed: () {
                  controller.playAyaPageAudio();
                },
              ),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                  color: Color(0xfff3efdf),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: IconButton(
                icon: const Icon(
                  Icons.share_outlined,
                  size: 23,
                  color: Color(0x99f5410a),
                ),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
