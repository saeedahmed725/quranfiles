import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controller/cards_controllers/quran_controller/image_surah_page_controller.dart';
import '../../../../core/constants/appcolor.dart';
import '../../../../core/constants/appimageassets.dart';
import '../../../../data/datasource/static.dart';
import '../../../widgets/audio_page_widget/audio_button_widget.dart';
import '../../../widgets/cardse_screen_widget/quran_page_widget/image_surah_builder.dart';

class QuranImage extends StatelessWidget {
  const QuranImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ImageSurahPageControllerImp controller =
        Get.put(ImageSurahPageControllerImp());
    return Scaffold(
      backgroundColor: const Color(0xff4d4c47),
      body: GetBuilder<ImageSurahPageControllerImp>(builder: (ctx) {
        return SafeArea(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PageView.builder(
                itemCount: 604,
                controller: controller.pageController,
                onPageChanged: (value) => controller.onChange(),
                itemBuilder: (_, int index) {
                  controller.getPageIndex(index + 1);
                  currentSurahIndex = index;
                  controller.fetchVerses(index);
                  return const ImageSurahBuilder();
                },
              ),
              if (controller.showAppBar) ...[
                Container(
                  height: 150,
                  alignment: Alignment.bottomCenter,
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                      color: const Color(0xffeafdfa),
                      boxShadow: const [
                        BoxShadow(color: Colors.grey, blurRadius: 40)
                      ],
                      borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.ayat.length,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            if (index == controller.currentAyaIndex) {
                              return GestureDetector(
                                onTap: () {
                                  controller.isAyaClicked = true;
                                  controller.currentAyaIndex = index;
                                  controller.getAyaAudio();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: CircleAvatar(
                                    backgroundColor:
                                        AppColor.kSecondaryHomeCardColor,
                                    child: Text(
                                        controller.ayat[index].aya.toString(),
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ),
                                ),
                              );
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  controller.isAyaClicked = true;
                                  controller.currentAyaIndex = index;
                                  controller.getAyaAudio();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  child: CircleAvatar(
                                    backgroundColor: AppColor.kPrimaryColor,
                                    child: Text('${controller.ayat[index].aya}',
                                        style: const TextStyle(
                                            color: Colors.white)),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(60.0),
                            child: Image.asset(
                              AppImageAssets.mshary,
                              fit: BoxFit.fill,
                              width: 70,
                              height: 70,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    controller.surahName,
                                    style: TextStyle(
                                        fontFamily: "Quran",
                                        fontSize: 16.sp,
                                        color: Colors.black),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    // "  آية  $surahCount",
                                    '',
                                    style: TextStyle(
                                        fontFamily: "Quran",
                                        fontSize: 12.sp,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                              Text(
                                "مشاري بن راشد العفاسي",
                                style: TextStyle(
                                    fontFamily: "Quran",
                                    fontSize: 12.sp,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                          const Spacer(),
                          GetBuilder<ImageSurahPageControllerImp>(
                              builder: (context) {
                            return AudioButtonWidget(
                              size: 60,
                              icon: controller.isPlayed
                                  ? Icons.pause_circle_filled_outlined
                                  : Icons.play_circle_fill_rounded,
                              iconColor: AppColor.kPrimaryColor,
                              onTap: () => controller.getAyaAudio(),
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                )
              ]
            ],
          ),
        );
      }),
    );
  }
}

// appBar: controller.showAppBar
//     ? AppBar(
//         backgroundColor: AppColor.kPrimaryColor,
//         flexibleSpace: Container(
//           margin: EdgeInsets.only(left: screenWidth * 0.4),
//           child: Image.asset(
//             AppImageAssets.mosquesImage,
//             height: 150,
//             fit: BoxFit.cover,
//           ),
//         ),
//         actions: [
//           IconButtonWidget(
//             onTap: () => showModalBottomSheet(
//                 elevation: 0,
//                 context: context,
//                 backgroundColor: Colors.transparent,
//                 builder: (context) => AudioControllerBottomSheet(
//                       surahName: getSurahNameArabic(surahIndex!),
//                       surahCount: getVerseCount(surahIndex!).toString(),
//                     )),
//             icon: Icons.volume_up_outlined,
//             padding: const EdgeInsets.only(top: 14),
//           ),
//           IconButtonWidget(
//               onTap: () => controller.goToSurahListenPage(),
//               icon: Icons.view_list_rounded,
//               padding:
//                   const EdgeInsets.only(right: 14, top: 14, left: 14)),
//         ],
//         leading: IconButtonWidget(
//             onTap: () => controller.goBackToQuranCardPage(),
//             icon: Icons.arrow_back,
//             padding: const EdgeInsets.only(right: 14,left: 14, top: 14)),
//         centerTitle: true,
//         toolbarHeight: 70.h,
//         title: Text(
//           " سورة ${controller.surahNameArabic!}",
//           style: TextStyle(
//               fontFamily: "Quran",
//               fontSize: 30.sp,
//               color: Colors.white),
//         ),
//       )
//     : AppBar(
//         leading: null,
//         toolbarHeight: 10,
//         backgroundColor: Colors.black,
//       ),
