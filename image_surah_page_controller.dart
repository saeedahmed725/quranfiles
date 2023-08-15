import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../core/constants/app_json.dart';
import '../../../core/constants/approutes.dart';
import '../../../core/services/services.dart';
import '../../../data/database/verseDBHelper.dart';
import '../../../data/model/surha_model.dart';
import '../../../data/model/verse_page_model/verse_page_model.dart';
import '../../../data/quran/quran.dart';
import '../../../view/widgets/cardse_screen_widget/quran_page_widget/page_menu.dart';

abstract class ImageSurahPageController extends GetxController {
  getCurrentSurahPage();

  doubleTabShowAppBar();

  goToSurahListenPage();

  goBackToQuranCardPage();
}

class ImageSurahPageControllerImp extends ImageSurahPageController {
  late AppJsonAndImage appJsonAndImage;
  List<int>? surahPages;
  String? surahNameArabic;
  bool showAppBar = false;
  bool isFirst = true;
  bool left = true;
  int verseNumber = 0;
  bool? fabIsClicked = false;
  List<SurahVerseModel>? verses;
  bool ayaFromJuzIsClicked = false;
  PageController pageController = PageController();
  MyServices myServices = Get.find();
  int currentPageIndex = 0;
  int currentAyaIndex = 0;
  List<PageDataModel> ayat = [];
  int surah = 1;
  bool isPlayed = false;
  bool isAyaClicked = false;
  String surahName = '';
  List<Verse>? versesPage;
  List<bool>? selectedVerses;
  final GlobalKey imageKey = GlobalKey();
  final GlobalKey gestureDetectorKey = GlobalKey();


  getAyaAudio() async {
    if (isAyaClicked) {
      playAyaAudio();
    } else {
      await Fluttertoast.showToast(
          msg: "أختر آية للتشغيل".tr,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 12.0.sp);
    }
  }

  Future playAyaPageAudio() async {
    myServices.audioPlayer.stop();
    isPlayed = true;
    update();
    surahName = getSurahNameArabic(ayat[currentAyaIndex].surah);
    final Audio audio = Audio.network(getAudioURLByVerse(
        ayat[currentAyaIndex].surah,versesPage![currentAyaIndex].ayahNumber));
    myServices.audioPlayer.open(audio);
    myServices.audioPlayer.playlistAudioFinished.listen((Playing playing) {
      isPlayed = false;
      update();
    });
  }
  Future playAyaAudio() async {
    myServices.audioPlayer.stop();
    isPlayed = true;
    update();
    surahName = getSurahNameArabic(ayat[currentAyaIndex].surah);
    final Audio audio = Audio.network(getAudioURLByVerse(
        ayat[currentAyaIndex].surah, ayat[currentAyaIndex].aya));
    myServices.audioPlayer.open(audio);
    myServices.audioPlayer.playlistAudioFinished.listen((Playing playing) {
      isPlayed = false;
      update();
    });
  }

  getPageIndex(int index) {
    currentPageIndex = index;
    getCurrentSurahPage();
    getPageAyatData();
  }

  getPageAyatData() {
    ayat.clear();
    List<Map<String, int>> pageData =
        getPageData(currentPageIndex) as List<Map<String, int>>;
    for (int surahNum = 0; surahNum < pageData.length; surahNum++) {
      int ayaStart = pageData[surahNum]['start'] as int;
      int ayaEnd = pageData[surahNum]['end'] as int;
      surah = pageData[surahNum]['surah'] as int;
      for (int aya = ayaStart; aya <= ayaEnd; aya++) {
        ayat.add(PageDataModel(surah: surah, aya: aya));
      }
    }
  }

  @override
  getCurrentSurahPage() async {
    if (currentPageIndex % 2 == 0) {
      left = true;
    } else {
      left = false;
    }
    try {
      appJsonAndImage.getImageFileName(surahPageNumber: currentPageIndex);
      getSurahPosition();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  getSurahPosition() {
    int surahPageNumber = (surahPages![0] - 1);
    if (isFirst) {
      fetchVerses(surahPageNumber);
      pageController.animateToPage(surahPageNumber,
          duration: const Duration(milliseconds: 1), curve: Curves.easeInOut);
      isFirst = false;
      debugPrint(surahPageNumber.toString());
    }
  }



  @override
  goBackToQuranCardPage() {
    isFirst = true;
    Get.back();
  }

  @override
  doubleTabShowAppBar() {
    showAppBar = !showAppBar;
    update();
  }

  @override
  goToSurahListenPage() {
    myServices.sharedPreferences.setBool("isImagePageView", false);
    Get.offNamed(AppRoutes.surahPage, arguments: {
      "surahPages": surahPages,
      "surahNameArabic": surahNameArabic,
      "ayaFromJuzIsClicked": ayaFromJuzIsClicked,
      "verseNumber": verseNumber,
      "fabIsClicked": fabIsClicked
    });
  }

  getTappedVerse( BuildContext context,TapDownDetails details) {
    final Offset localTouchPosition = details.localPosition;
    final double x = localTouchPosition.dx;
    final double y = localTouchPosition.dy;
    Offset adjustedPosition = Offset(x, y);
    int tappedVerseIndex;
    tappedVerseIndex = findTappedVerse(adjustedPosition, context);

    if (tappedVerseIndex != -1) {
      currentAyaIndex = tappedVerseIndex;
      for (int s = 0; s < selectedVerses!.length; s++) {
        tappedVerseIndex == s
            ? selectedVerses![s] = !selectedVerses![s]
            : selectedVerses![s] = false;
        debugPrint(selectedVerses.toString());
      }
      menu(context, details);
    }
    debugPrint('x' * 70);
     debugPrint(selectedVerses.toString());
    debugPrint('x $x');
    debugPrint('y $y');
    update();
  }

  onChange(){
    showAppBar = false;
    update();
  }

  Future<void> fetchVerses(int currentPageIndex) async {
    final data = await DBHelper().getVersesForCurrentPage(currentPageIndex + 1);
    versesPage = data.map((v) => Verse.fromJson(v)).toList();
    selectedVerses =
        List.generate(versesPage!.length, (index) => false);
  }

  int findTappedVerse(Offset localPosition, BuildContext context) {
    double scaleFactor = MediaQuery.of(context).size.width / 1260;
    double padding = 70.0;

    for (int i = 0; i < versesPage!.length; i++) {
      if (localPosition.dx >= (versesPage![i].minX - padding) * scaleFactor &&
          localPosition.dx <= (versesPage![i].maxX + padding) * scaleFactor &&
          localPosition.dy >= (versesPage![i].minY - padding) * scaleFactor &&
          localPosition.dy <= (versesPage![i].maxY + padding) * scaleFactor) {
        return i;
      }
    }
    return -1;
  }

  @override
  void onInit() {
    surahPages = Get.arguments["surahPages"];
    surahNameArabic = Get.arguments["surahNameArabic"];
    ayaFromJuzIsClicked = Get.arguments["ayaFromJuzIsClicked"];
    verseNumber = Get.arguments["verseNumber"];
    surahNameArabic = Get.arguments["surahNameArabic"];
    fabIsClicked = Get.arguments["fabIsClicked"];
    appJsonAndImage = AppJsonAndImage();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.onInit();
  }

  @override
  void onClose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.onClose();
  }
}
