import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controller/cards_controllers/quran_controller/image_surah_page_controller.dart';

class PageBorder extends StatelessWidget {
  const PageBorder({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    ImageSurahPageControllerImp controller =
    Get.put(ImageSurahPageControllerImp());
    return Container(
      alignment: Alignment.center,
      margin: controller.left
          ? const EdgeInsets.only(left: 5)
          : const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: controller.left
            ? const BorderRadius.only(
            topLeft: Radius.circular(20), bottomLeft: Radius.circular(20))
            : const BorderRadius.only(
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20)),
        color: const Color(0xffafc7c3),
      ),
      child: Container(
        alignment: Alignment.center,
        margin: controller.left
            ? const EdgeInsets.only(left: 5)
            : const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          borderRadius: controller.left
              ? const BorderRadius.only(
              topLeft: Radius.circular(25), bottomLeft: Radius.circular(25))
              : const BorderRadius.only(
              topRight: Radius.circular(25),
              bottomRight: Radius.circular(25)),
          color: const Color(0xffc5e0dd),
        ),
        child: Container(
          alignment: Alignment.center,
          margin: controller.left
              ? const EdgeInsets.only(left: 5)
              : const EdgeInsets.only(right: 5),
          decoration: BoxDecoration(
            borderRadius: controller.left
                ? const BorderRadius.only(
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30))
                : const BorderRadius.only(
                topRight: Radius.circular(30),
                bottomRight: Radius.circular(30)),
            color: const Color(0xfff1fcf8),
          ),
          child: child,
        ),
      ),
    );
  }
}
