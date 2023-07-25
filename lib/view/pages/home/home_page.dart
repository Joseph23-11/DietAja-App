import 'package:carousel_slider/carousel_slider.dart';
import 'package:diet_app/controllers/breakfast_controller.dart';
import 'package:diet_app/controllers/daily_diet_controller.dart';
import 'package:diet_app/controllers/dinner_controller.dart';
import 'package:diet_app/controllers/home_page_controller.dart';
import 'package:diet_app/controllers/lunch_controller.dart';
import 'package:diet_app/controllers/snack_controller.dart';
import 'package:diet_app/controllers/sport_daily_controller.dart';
import 'package:diet_app/controllers/target_controller.dart';
import 'package:diet_app/controllers/user_controller.dart';
import 'package:diet_app/models/makanan_model.dart';
import 'package:diet_app/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../controllers/makanan_controller.dart';
import '../../../controllers/water_contoller.dart';
import '../../../models/chart_data.dart';
import '../../widgets/button.dart';
import '../components/berat_badan_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
  bool get onGlassTap => true;
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  CarouselController controller = CarouselController();
  double opacity = 0.0;

  final postDateFormat = DateFormat("yyyy-MM-dd");
  final List<Color> palletChart = [purpleColor, greyF7];

  final ValueNotifier<String> _valPostDate = ValueNotifier("");

  @override
  void initState() {
    waterController.loadGlassSelection();

    super.initState();
  }

  @override
  void dispose() {
    homePageController.valDate.removeListener(_onDateChanged);
    _currentPage.dispose();
    super.dispose();
  }

  void _onDateChanged() {
    waterController.resetWaterData();
  }

  final ValueNotifier<int> _currentPage = ValueNotifier(0);
  final userController = Get.find<UserController>();
  final homePageController = Get.find<HomePageController>();
  final targetController = Get.find<TargetController>();
  final breakfastController = Get.find<BreakfastController>();
  final lunchController = Get.find<LunchController>();
  final dinnerController = Get.find<DinnerController>();
  final snackController = Get.find<SnackController>();
  final sportDailyController = Get.find<SportDailyController>();
  final waterController = Get.put(WaterController());
  final dailyDietController = Get.find<DailyDietController>();

  @override
  Widget build(BuildContext context) {
    Widget buildCalender() {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hallo,',
                  style: greyTextStyle.copyWith(
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.keyboard_arrow_left_rounded,
                      color: greyColor,
                    ),
                    InkWell(
                      onTap: () async {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1945),
                          lastDate: DateTime(3000),
                          builder: (BuildContext context, Widget? child) {
                            return Theme(
                              data: ThemeData.light().copyWith(
                                colorScheme: ColorScheme.light(
                                  primary: purpleColor,
                                ),
                                dialogBackgroundColor: whiteColor,
                              ),
                              child: child!,
                            );
                          },
                        ).then((date) {
                          if (date != null) {
                            setState(() {
                              homePageController.valDate.value =
                                  homePageController.dateFormat.format(date);
                              print(
                                  'tanggal : ${homePageController.valDate.value}');
                              _valPostDate.value = postDateFormat.format(date);
                              dailyDietController.postSearchingDailyDietByDate(
                                  _valPostDate.value.toString());
                            });
                          } else {
                            // Ketika pemilihan tanggal dibatalkan
                          }
                        });
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/cake.svg"),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: ValueListenableBuilder<String>(
                              valueListenable: homePageController.valDate,
                              builder: (_, newDate, __) {
                                return Text(
                                  newDate,
                                  style: greyTextStyle.copyWith(
                                    fontSize: 16,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right_rounded,
                      color: greyColor,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            userController.obx(
              (data) => Text(
                data!.username!,
                style: blackTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: semiBold,
                ),
              ),
            ),
          ],
        ),
      );
    }

    // section
    Widget buildCard() {
      return Obx(
        () => dailyDietController.isToday.value
            ? Container(
                width: double.infinity,
                height: 207,
                margin: const EdgeInsets.only(
                  top: 30,
                ),
                padding: EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/img_bg_card.png',
                    ),
                  ),
                ),
                child: targetController.obx(
                  (data) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => (targetController.kalori.value +
                                        sportDailyController.sport.value -
                                        (breakfastController.breakfast.value +
                                            lunchController.lunch.value +
                                            dinnerController.dinner.value +
                                            snackController.snack.value)) >=
                                    0
                                ? Text(
                                    'Makanan',
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: medium,
                                    ),
                                  )
                                : Text(
                                    'Makanan Over ${(targetController.kalori.value + sportDailyController.sport.value - (breakfastController.breakfast.value + lunchController.lunch.value + dinnerController.dinner.value + snackController.snack.value))} kcal',
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: medium,
                                    ),
                                  ),
                          ),
                          Text(
                            'Sisa',
                            style: whiteTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: medium,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Row(
                        children: [
                          Text(
                            (breakfastController.breakfast.value +
                                    lunchController.lunch.value +
                                    dinnerController.dinner.value +
                                    snackController.snack.value)
                                .toString(),
                            style: whiteTextStyle.copyWith(
                              fontSize: 32,
                              fontWeight: semiBold,
                            ),
                          ),
                          const SizedBox(
                            width: 1,
                          ),
                          Expanded(
                            child: Text(
                              'kcal',
                              style: whiteTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: regular,
                              ),
                            ),
                          ),
                          Obx(
                            () => (targetController.kalori.value +
                                        sportDailyController.sport.value -
                                        (breakfastController.breakfast.value +
                                            lunchController.lunch.value +
                                            dinnerController.dinner.value +
                                            snackController.snack.value)) >=
                                    0
                                ? Text(
                                    (targetController.kalori.value +
                                            sportDailyController.sport.value -
                                            (breakfastController
                                                    .breakfast.value +
                                                lunchController.lunch.value +
                                                dinnerController.dinner.value +
                                                snackController.snack.value))
                                        .toString(),
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 32,
                                      fontWeight: semiBold,
                                    ),
                                  )
                                : Text(
                                    '0',
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 32,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(55),
                        child: Obx(() {
                          final double progressValue =
                              (breakfastController.breakfast.value +
                                      lunchController.lunch.value +
                                      dinnerController.dinner.value +
                                      snackController.snack.value) /
                                  (targetController.kalori.value +
                                      sportDailyController.sport.value);
                          return LinearProgressIndicator(
                            value: dailyDietController.isToday.value
                                ? progressValue
                                : 0,
                            minHeight: 5,
                            color: lightBackgroundColor,
                            backgroundColor: purpleDarkColor,
                          );
                        }),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Visibility(
                            visible: sportDailyController.sport.value != 0,
                            child: Image.asset(
                              'assets/ic_dumbell.png',
                              width: 25,
                              height: 20,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Daily Goal',
                            style: whiteTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: medium,
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '${targetController.kalori.value}',
                                  style: whiteTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: medium,
                                  ),
                                ),
                                const SizedBox(
                                  width: 9,
                                ),
                                Obx(
                                  () => sportDailyController.sport.value != 0
                                      ? Text(
                                          '+${sportDailyController.sport.value}',
                                          style: whiteTextStyle.copyWith(
                                            fontSize: 14,
                                            fontWeight: medium,
                                          ),
                                        )
                                      : SizedBox(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: Stack(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: LinearProgressIndicator(
                                    value: 0.8,
                                    minHeight: 4,
                                    backgroundColor: Color(0xff7E91FF),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xff7E91FF)),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  bottom: 0,
                                  child: FractionallySizedBox(
                                    heightFactor: 3,
                                    child: Icon(
                                      Icons.circle,
                                      color: purpleDarkColor,
                                      size: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Obx(
                            () => sportDailyController.sport.value != 0
                                ? Expanded(
                                    flex: 1,
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: LinearProgressIndicator(
                                            value: 0.2,
                                            minHeight: 4,
                                            backgroundColor: Color(0xff7E91FF),
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Color(0xff7E91FF)),
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          bottom: 0,
                                          child: FractionallySizedBox(
                                            heightFactor: 3,
                                            child: Icon(
                                              Icons.circle,
                                              color: purpleDarkColor,
                                              size: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : SizedBox(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : Container(
                width: double.infinity,
                height: 207,
                margin: const EdgeInsets.only(
                  top: 30,
                ),
                padding: EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/img_bg_card.png',
                    ),
                  ),
                ),
                child: dailyDietController.obx(
                  (data) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => (targetController.kalori.value +
                                        data!.totalKaloriDailySport!.toInt() -
                                        (data.totalKaloriBreakfast!.toInt() +
                                            data.totalKaloriLunch!.toInt() +
                                            data.totalKaloriDinner!.toInt() +
                                            data.totalKaloriSnack!.toInt())) >=
                                    0
                                ? Text(
                                    'Makanan',
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: medium,
                                    ),
                                  )
                                : Text(
                                    'Makanan Over ${(targetController.kalori.value + data.totalKaloriDailySport!.toInt() - (data.totalKaloriBreakfast!.toInt() + data.totalKaloriLunch!.toInt() + data.totalKaloriDinner!.toInt() + data.totalKaloriSnack!.toInt()))} kcal',
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 16,
                                      fontWeight: medium,
                                    ),
                                  ),
                          ),
                          Text(
                            'Sisa',
                            style: whiteTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: medium,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 2,
                      ),
                      Row(
                        children: [
                          Text(
                            (data!.totalKaloriBreakfast!.toInt() +
                                    data.totalKaloriLunch!.toInt() +
                                    data.totalKaloriDinner!.toInt() +
                                    data.totalKaloriSnack!.toInt())
                                .toString(),
                            style: whiteTextStyle.copyWith(
                              fontSize: 32,
                              fontWeight: semiBold,
                            ),
                          ),
                          const SizedBox(
                            width: 1,
                          ),
                          Expanded(
                            child: Text(
                              'kcal',
                              style: whiteTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: regular,
                              ),
                            ),
                          ),
                          Obx(
                            () => (targetController.kalori.value +
                                        data.totalKaloriDailySport!.toInt() -
                                        (data.totalKaloriBreakfast!.toInt() +
                                            data.totalKaloriLunch!.toInt() +
                                            data.totalKaloriDinner!.toInt() +
                                            data.totalKaloriSnack!.toInt())) >=
                                    0
                                ? Text(
                                    (targetController.kalori.value +
                                            data.totalKaloriDailySport!
                                                .toInt() -
                                            (data.totalKaloriBreakfast!.toInt() +
                                                data.totalKaloriLunch!.toInt() +
                                                data.totalKaloriDinner!
                                                    .toInt() +
                                                data.totalKaloriSnack!.toInt()))
                                        .toString(),
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 32,
                                      fontWeight: semiBold,
                                    ),
                                  )
                                : Text(
                                    '0',
                                    style: whiteTextStyle.copyWith(
                                      fontSize: 32,
                                      fontWeight: semiBold,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 26,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(55),
                        child: Obx(() {
                          final double progressValue =
                              (breakfastController.breakfast.value +
                                      lunchController.lunch.value +
                                      dinnerController.dinner.value +
                                      snackController.snack.value) /
                                  (targetController.kalori.value +
                                      sportDailyController.sport.value);
                          return LinearProgressIndicator(
                            value: dailyDietController.isToday.value
                                ? progressValue
                                : 0,
                            minHeight: 5,
                            color: lightBackgroundColor,
                            backgroundColor: purpleDarkColor,
                          );
                        }),
                      ),
                      const SizedBox(
                        height: 1,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Visibility(
                            visible: sportDailyController.sport.value != 0,
                            child: Image.asset(
                              'assets/ic_dumbell.png',
                              width: 25,
                              height: 20,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            'Daily Goal',
                            style: whiteTextStyle.copyWith(
                              fontSize: 14,
                              fontWeight: medium,
                            ),
                          ),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '${targetController.kalori.value}',
                                  style: whiteTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: medium,
                                  ),
                                ),
                                const SizedBox(
                                  width: 9,
                                ),
                                Obx(
                                  () => sportDailyController.sport.value != 0
                                      ? Text(
                                          '+${sportDailyController.sport.value}',
                                          style: whiteTextStyle.copyWith(
                                            fontSize: 14,
                                            fontWeight: medium,
                                          ),
                                        )
                                      : SizedBox(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 7,
                            child: Stack(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: LinearProgressIndicator(
                                    value: 0.8,
                                    minHeight: 4,
                                    backgroundColor: Color(0xff7E91FF),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xff7E91FF)),
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  bottom: 0,
                                  child: FractionallySizedBox(
                                    heightFactor: 3,
                                    child: Icon(
                                      Icons.circle,
                                      color: purpleDarkColor,
                                      size: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Obx(
                            () => sportDailyController.sport.value != 0
                                ? Expanded(
                                    flex: 1,
                                    child: Stack(
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: LinearProgressIndicator(
                                            value: 0.2,
                                            minHeight: 4,
                                            backgroundColor: Color(0xff7E91FF),
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Color(0xff7E91FF)),
                                          ),
                                        ),
                                        Positioned(
                                          right: 0,
                                          top: 0,
                                          bottom: 0,
                                          child: FractionallySizedBox(
                                            heightFactor: 3,
                                            child: Icon(
                                              Icons.circle,
                                              color: purpleDarkColor,
                                              size: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : SizedBox(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      );
    }

    Widget microCard(context) {
      return Obx(() => dailyDietController.isToday.value
          ? Container(
              width: double.infinity,
              height: 207,
              margin: const EdgeInsets.only(
                top: 24,
              ),
              padding: EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: whiteColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nutrisi',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  Obx(
                    () => Row(
                      children: [
                        chart(
                          context,
                          [
                            (breakfastController.breakfastKarbo.value +
                                        lunchController.lunchKarbo.value +
                                        dinnerController.dinnerKarbo.value +
                                        snackController.snackKarbo.value) <
                                    targetController.karbo.value
                                ? ChartData(
                                    'Karbohidrat1',
                                    (((breakfastController
                                                    .breakfastKarbo.value +
                                                lunchController
                                                    .lunchKarbo.value +
                                                dinnerController
                                                    .dinnerKarbo.value +
                                                snackController
                                                    .snackKarbo.value) /
                                            targetController.karbo.value) *
                                        100))
                                : ChartData(
                                    'Karbohidrat1',
                                    100,
                                  ),
                            (breakfastController.breakfastKarbo.value +
                                        lunchController.lunchKarbo.value +
                                        dinnerController.dinnerKarbo.value +
                                        snackController.snackKarbo.value) <
                                    targetController.karbo.value
                                ? ChartData(
                                    'Karbohidrat2',
                                    (100 -
                                        ((breakfastController
                                                        .breakfastKarbo.value +
                                                    lunchController
                                                        .lunchKarbo.value +
                                                    dinnerController
                                                        .dinnerKarbo.value +
                                                    snackController
                                                        .snackKarbo.value) /
                                                targetController.karbo.value) *
                                            100))
                                : ChartData('Karbohidrat2', 0)
                          ],
                          "${breakfastController.breakfastKarbo.value + lunchController.lunchKarbo.value + dinnerController.dinnerKarbo.value + snackController.snackKarbo.value}",
                          "/ ${targetController.karbo.value} g",
                          "Karbohidrat",
                        ),
                        chart(
                          context,
                          [
                            (breakfastController.breakfastProtein.value +
                                        lunchController.lunchProtein.value +
                                        dinnerController.dinnerProtein.value +
                                        snackController.snackProtein.value) <
                                    targetController.protein.value
                                ? ChartData(
                                    'Protein',
                                    (((breakfastController
                                                    .breakfastProtein.value +
                                                lunchController
                                                    .lunchProtein.value +
                                                dinnerController
                                                    .dinnerProtein.value +
                                                snackController
                                                    .snackProtein.value) /
                                            targetController.protein.value) *
                                        100))
                                : ChartData(
                                    'Protein',
                                    100,
                                  ),
                            (breakfastController.breakfastProtein.value +
                                        lunchController.lunchProtein.value +
                                        dinnerController.dinnerProtein.value +
                                        snackController.snackProtein.value) <
                                    targetController.protein.value
                                ? ChartData(
                                    'Protein2',
                                    (100 -
                                        ((breakfastController.breakfastProtein
                                                        .value +
                                                    lunchController
                                                        .lunchProtein.value +
                                                    dinnerController
                                                        .dinnerProtein.value +
                                                    snackController
                                                        .snackProtein.value) /
                                                targetController
                                                    .protein.value) *
                                            100))
                                : ChartData('Protein2', 0),
                          ],
                          "${breakfastController.breakfastProtein.value + lunchController.lunchProtein.value + dinnerController.dinnerProtein.value + snackController.snackProtein.value}",
                          "/ ${targetController.protein.value} g",
                          "Protein",
                        ),
                        chart(
                          context,
                          [
                            (breakfastController.breakfastLemak.value +
                                        lunchController.lunchLemak.value +
                                        dinnerController.dinnerLemak.value +
                                        snackController.snackLemak.value) <
                                    targetController.lemak.value
                                ? ChartData(
                                    'Lemak',
                                    (((breakfastController
                                                    .breakfastLemak.value +
                                                lunchController
                                                    .lunchLemak.value +
                                                dinnerController
                                                    .dinnerLemak.value +
                                                snackController
                                                    .snackLemak.value) /
                                            targetController.lemak.value) *
                                        100))
                                : ChartData('Lemak', 100),
                            (breakfastController.breakfastLemak.value +
                                        lunchController.lunchLemak.value +
                                        dinnerController.dinnerLemak.value +
                                        snackController.snackLemak.value) <
                                    targetController.lemak.value
                                ? ChartData(
                                    'Lemak2',
                                    (100 -
                                        ((breakfastController
                                                        .breakfastLemak.value +
                                                    lunchController
                                                        .lunchLemak.value +
                                                    dinnerController
                                                        .dinnerLemak.value +
                                                    snackController
                                                        .snackLemak.value) /
                                                targetController.lemak.value) *
                                            100))
                                : ChartData(
                                    'Lemak2',
                                    0,
                                  ),
                          ],
                          "${breakfastController.breakfastLemak.value + lunchController.lunchLemak.value + dinnerController.dinnerLemak.value + snackController.snackLemak.value}",
                          "/ ${targetController.lemak.value} g",
                          "Lemak",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : Container(
              width: double.infinity,
              height: 207,
              margin: const EdgeInsets.only(
                top: 24,
              ),
              padding: EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: whiteColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nutrisi',
                    style: blackTextStyle.copyWith(
                      fontSize: 16,
                      fontWeight: semiBold,
                    ),
                  ),
                  Obx(
                    () => Row(
                      children: [
                        chart(
                          context,
                          [
                            (dailyDietController.breakfastKarbo.value +
                                        dailyDietController.lunchKarbo.value +
                                        dailyDietController.dinnerKarbo.value +
                                        dailyDietController.snackKarbo.value) <
                                    targetController.karbo.value
                                ? ChartData(
                                    'Karbohidrat1',
                                    (((dailyDietController
                                                    .breakfastKarbo.value +
                                                dailyDietController
                                                    .lunchKarbo.value +
                                                dailyDietController
                                                    .dinnerKarbo.value +
                                                dailyDietController
                                                    .snackKarbo.value) /
                                            targetController.karbo.value) *
                                        100))
                                : ChartData(
                                    'Karbohidrat1',
                                    100,
                                  ),
                            (dailyDietController.breakfastKarbo.value +
                                        dailyDietController.lunchKarbo.value +
                                        dailyDietController.dinnerKarbo.value +
                                        dailyDietController.snackKarbo.value) <
                                    targetController.karbo.value
                                ? ChartData(
                                    'Karbohidrat2',
                                    (100 -
                                        ((dailyDietController
                                                        .breakfastKarbo.value +
                                                    dailyDietController
                                                        .lunchKarbo.value +
                                                    dailyDietController
                                                        .dinnerKarbo.value +
                                                    dailyDietController
                                                        .snackKarbo.value) /
                                                targetController.karbo.value) *
                                            100))
                                : ChartData(
                                    'Karbohidrat1',
                                    0,
                                  ),
                          ],
                          "${dailyDietController.breakfastKarbo.value + dailyDietController.lunchKarbo.value + dailyDietController.dinnerKarbo.value + dailyDietController.snackKarbo.value}",
                          "/ ${targetController.karbo.value} g",
                          "Karbohidrat",
                        ),
                        chart(
                          context,
                          [
                            (dailyDietController.breakfastProtein.value +
                                        dailyDietController.lunchProtein.value +
                                        dailyDietController
                                            .dinnerProtein.value +
                                        dailyDietController
                                            .snackProtein.value) <
                                    targetController.protein.value
                                ? ChartData(
                                    'Protein',
                                    (((dailyDietController
                                                    .breakfastProtein.value +
                                                dailyDietController
                                                    .lunchProtein.value +
                                                dailyDietController
                                                    .dinnerProtein.value +
                                                dailyDietController
                                                    .snackProtein.value) /
                                            targetController.protein.value) *
                                        100))
                                : ChartData(
                                    'Protein',
                                    100,
                                  ),
                            (dailyDietController.breakfastProtein.value +
                                        dailyDietController.lunchProtein.value +
                                        dailyDietController
                                            .dinnerProtein.value +
                                        dailyDietController
                                            .snackProtein.value) <
                                    targetController.protein.value
                                ? ChartData(
                                    'Protein2',
                                    (100 -
                                        ((dailyDietController.breakfastProtein
                                                        .value +
                                                    dailyDietController
                                                        .lunchProtein.value +
                                                    dailyDietController
                                                        .dinnerProtein.value +
                                                    dailyDietController
                                                        .snackProtein.value) /
                                                targetController
                                                    .protein.value) *
                                            100))
                                : ChartData('Protein2', 0),
                          ],
                          "${dailyDietController.breakfastProtein.value + dailyDietController.lunchProtein.value + dailyDietController.dinnerProtein.value + dailyDietController.snackProtein.value}",
                          "/ ${targetController.protein.value} g",
                          "Protein",
                        ),
                        chart(
                          context,
                          [
                            (dailyDietController.breakfastLemak.value +
                                        dailyDietController.lunchLemak.value +
                                        dailyDietController.dinnerLemak.value +
                                        dailyDietController.snackLemak.value) <
                                    targetController.lemak.value
                                ? ChartData(
                                    'Lemak',
                                    (((dailyDietController
                                                    .breakfastLemak.value +
                                                dailyDietController
                                                    .lunchLemak.value +
                                                dailyDietController
                                                    .dinnerLemak.value +
                                                dailyDietController
                                                    .snackLemak.value) /
                                            targetController.lemak.value) *
                                        100))
                                : ChartData(
                                    'Lemak',
                                    100,
                                  ),
                            (dailyDietController.breakfastLemak.value +
                                        dailyDietController.lunchLemak.value +
                                        dailyDietController.dinnerLemak.value +
                                        dailyDietController.snackLemak.value) <
                                    targetController.lemak.value
                                ? ChartData(
                                    'Lemak2',
                                    (100 -
                                        ((dailyDietController
                                                        .breakfastLemak.value +
                                                    dailyDietController
                                                        .lunchLemak.value +
                                                    dailyDietController
                                                        .dinnerLemak.value +
                                                    dailyDietController
                                                        .snackLemak.value) /
                                                targetController.lemak.value) *
                                            100))
                                : ChartData('Lemak2', 0),
                          ],
                          "${dailyDietController.breakfastLemak.value + dailyDietController.lunchLemak.value + dailyDietController.dinnerLemak.value + dailyDietController.snackLemak.value}",
                          "/ ${targetController.lemak.value} g",
                          "Lemak",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ));
    }

    Widget sarapanCard() {
      return Obx(() => dailyDietController.isToday.value
          ? breakfastController.obx(
              (data) => Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                  top: 24,
                ),
                padding: EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sarapan',
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                        Obx(
                          () => Text(
                            '${breakfastController.breakfast.value} / ${targetController.batasBreakfast.value} kcal ',
                            style: blackTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: medium,
                            ),
                          ),
                        ),
                      ],
                    ),
                    data!.isNotEmpty
                        ? SizedBox(
                            height: breakfastController.heightBreakfast.value
                                .toDouble(),
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    separatorBuilder: (context, index) {
                                      return Divider(
                                        color: greyColor,
                                      );
                                    },
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder:
                                                (BuildContext thisContext) {
                                              final makananModel = MakananModel(
                                                namaMakanan:
                                                    data[index].namaMakanan,
                                                ukuran:
                                                    '${data[index].porsiMakanan}',
                                                beratMakanan: 100,
                                                kalori: data[index].kalori,
                                                karbohidrat:
                                                    data[index].karbohidrat,
                                                protein: data[index].protein,
                                                lemak: data[index].lemak,
                                              );

                                              return dialogPorsi(
                                                makananModel,
                                                context,
                                                data[index].id!,
                                                1,
                                              );
                                            },
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${data[index].namaMakanan}',
                                                    style:
                                                        blackTextStyle.copyWith(
                                                      fontSize: 16,
                                                      fontWeight: semiBold,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            thisContext) {
                                                          return dialogDelete(
                                                            () async {
                                                              breakfastController
                                                                  .delBreakfast(
                                                                      data[index]
                                                                          .id!,
                                                                      context);
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Icon(
                                                      Icons.close_rounded,
                                                      color: greyColor,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${data[index].porsiMakanan}, • 100 g',
                                                    style:
                                                        greyTextStyle.copyWith(
                                                      fontSize: 10,
                                                      fontWeight: medium,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${data[index].kalori} kcal',
                                                    style:
                                                        greyTextStyle.copyWith(
                                                      fontSize: 10,
                                                      fontWeight: medium,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Text(
                            'Anda belum memasukkan makanan',
                            style: greyTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: medium,
                            ),
                          ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(
                          'assets/ic_sarapan.png',
                          width: 70,
                          height: 50,
                        ),
                        Column(
                          children: [
                            CustomTambahButton(
                              title: '+ Tambah',
                              onTap: () {
                                Get.toNamed(
                                  '/makanan-page',
                                  arguments: 'breakfasts',
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : dailyDietController.obx(
              (data) => Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                  top: 24,
                ),
                padding: EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sarapan',
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                        Obx(
                          () => Text(
                            '${data!.totalKaloriBreakfast} / ${targetController.batasBreakfast.value} kcal ',
                            style: blackTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: medium,
                            ),
                          ),
                        ),
                      ],
                    ),
                    data!.breakfasts!.isNotEmpty
                        ? SizedBox(
                            height: dailyDietController.heightBreakfast.value
                                .toDouble(),
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    separatorBuilder: (context, index) {
                                      return Divider(
                                        color: greyColor,
                                      );
                                    },
                                    itemCount: data.breakfasts!.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${data.breakfasts![index].namaMakanan}',
                                                  style:
                                                      blackTextStyle.copyWith(
                                                    fontSize: 16,
                                                    fontWeight: semiBold,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {},
                                                  child: Icon(
                                                    Icons.close_rounded,
                                                    color: greyColor,
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${data.breakfasts![index].porsiMakanan}, • 100 g',
                                                  style: greyTextStyle.copyWith(
                                                    fontSize: 10,
                                                    fontWeight: medium,
                                                  ),
                                                ),
                                                Text(
                                                  '${data.breakfasts![index].kalori} kcal',
                                                  style: greyTextStyle.copyWith(
                                                    fontSize: 10,
                                                    fontWeight: medium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Text(
                            'Anda belum memasukkan makanan',
                            style: greyTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: medium,
                            ),
                          ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(
                          'assets/ic_sarapan.png',
                          width: 70,
                          height: 50,
                        ),
                        Column(
                          children: [
                            CustomTambahButton(
                              title: '+ Tambah',
                              onTap: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
    }

    Widget makanSiangCard() {
      return Obx(
        () => dailyDietController.isToday.value
            ? lunchController.obx(
                (data) => Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                    top: 24,
                  ),
                  padding: EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Makan Siang',
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ),
                          ),
                          Obx(
                            () => Text(
                              '${lunchController.lunch.value} / ${targetController.batasLunch.value} kcal ',
                              style: blackTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: medium,
                              ),
                            ),
                          ),
                        ],
                      ),
                      data!.isNotEmpty
                          ? SizedBox(
                              height:
                                  lunchController.heightLunch.value.toDouble(),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.separated(
                                      physics: NeverScrollableScrollPhysics(),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      separatorBuilder: (context, index) {
                                        return Divider(
                                          color: greyColor,
                                        );
                                      },
                                      itemCount: data.length,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder:
                                                  (BuildContext thisContext) {
                                                final makananModel =
                                                    MakananModel(
                                                  namaMakanan:
                                                      data[index].namaMakanan,
                                                  ukuran:
                                                      '${data[index].porsiMakanan}',
                                                  beratMakanan: 100,
                                                  kalori: data[index].kalori,
                                                  karbohidrat:
                                                      data[index].karbohidrat,
                                                  protein: data[index].protein,
                                                  lemak: data[index].lemak,
                                                );

                                                return dialogPorsi(
                                                  makananModel,
                                                  context,
                                                  data[index].id!,
                                                  2,
                                                );
                                              },
                                            );
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      '${data[index].namaMakanan}',
                                                      style: blackTextStyle
                                                          .copyWith(
                                                        fontSize: 16,
                                                        fontWeight: semiBold,
                                                      ),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              thisContext) {
                                                            return dialogDelete(
                                                              () async {
                                                                await lunchController
                                                                    .delLunch(
                                                                        data[index]
                                                                            .id!,
                                                                        context);
                                                              },
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Icon(
                                                        Icons.close_rounded,
                                                        color: greyColor,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 8,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      '${data[index].porsiMakanan}, • 100 g',
                                                      style: greyTextStyle
                                                          .copyWith(
                                                        fontSize: 10,
                                                        fontWeight: medium,
                                                      ),
                                                    ),
                                                    Text(
                                                      '${data[index].kalori} kcal',
                                                      style: greyTextStyle
                                                          .copyWith(
                                                        fontSize: 10,
                                                        fontWeight: medium,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Text(
                              'Anda belum memasukkan makanan',
                              style: greyTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: medium,
                              ),
                            ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset(
                            'assets/ic_makan_siang.png',
                            width: 70,
                            height: 50,
                          ),
                          Column(
                            children: [
                              CustomTambahButton(
                                title: '+ Tambah',
                                onTap: () {
                                  Get.toNamed(
                                    '/makanan-page',
                                    arguments: 'lunches',
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : dailyDietController.obx(
                (data) => Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                    top: 24,
                  ),
                  padding: EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Makan Siang',
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ),
                          ),
                          Obx(
                            () => Text(
                              '${data!.totalKaloriLunch} / ${targetController.batasLunch.value} kcal ',
                              style: blackTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: medium,
                              ),
                            ),
                          ),
                        ],
                      ),
                      data!.lunches!.isNotEmpty
                          ? SizedBox(
                              height: dailyDietController.heightLunch.value
                                  .toDouble(),
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ListView.separated(
                                      physics: NeverScrollableScrollPhysics(),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 4.0),
                                      separatorBuilder: (context, index) {
                                        return Divider(
                                          color: greyColor,
                                        );
                                      },
                                      itemCount: data.lunches!.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${data.lunches![index].namaMakanan}',
                                                    style:
                                                        blackTextStyle.copyWith(
                                                      fontSize: 16,
                                                      fontWeight: semiBold,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {},
                                                    child: Icon(
                                                      Icons.close_rounded,
                                                      color: greyColor,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${data.lunches![index].porsiMakanan}, • 100 g',
                                                    style:
                                                        greyTextStyle.copyWith(
                                                      fontSize: 10,
                                                      fontWeight: medium,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${data.lunches![index].kalori} kcal',
                                                    style:
                                                        greyTextStyle.copyWith(
                                                      fontSize: 10,
                                                      fontWeight: medium,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Text(
                              'Anda belum memasukkan makanan',
                              style: greyTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: medium,
                              ),
                            ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset(
                            'assets/ic_makan_siang.png',
                            width: 70,
                            height: 50,
                          ),
                          Column(
                            children: [
                              CustomTambahButton(
                                title: '+ Tambah',
                                onTap: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      );
    }

    Widget makanMalamCard() {
      return Obx(() => dailyDietController.isToday.value
          ? dinnerController.obx(
              (data) => Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                  top: 24,
                ),
                padding: EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Makan Malam',
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                        Obx(
                          () => Text(
                            '${dinnerController.dinner.value} / ${targetController.batasDinner.value} kcal ',
                            style: blackTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: medium,
                            ),
                          ),
                        ),
                      ],
                    ),
                    data!.isNotEmpty
                        ? SizedBox(
                            height:
                                dinnerController.heightDinner.value.toDouble(),
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    separatorBuilder: (context, index) {
                                      return Divider(
                                        color: greyColor,
                                      );
                                    },
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder:
                                                (BuildContext thisContext) {
                                              final makananModel = MakananModel(
                                                namaMakanan:
                                                    data[index].namaMakanan,
                                                ukuran:
                                                    '${data[index].porsiMakanan}',
                                                beratMakanan: 100,
                                                kalori: data[index].kalori,
                                                karbohidrat:
                                                    data[index].karbohidrat,
                                                protein: data[index].protein,
                                                lemak: data[index].lemak,
                                              );

                                              return dialogPorsi(
                                                makananModel,
                                                context,
                                                data[index].id!,
                                                3,
                                              );
                                            },
                                          );
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${data[index].namaMakanan}',
                                                    style:
                                                        blackTextStyle.copyWith(
                                                      fontSize: 16,
                                                      fontWeight: semiBold,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            thisContext) {
                                                          return dialogDelete(
                                                            () {
                                                              dinnerController
                                                                  .delDinner(
                                                                      data[index]
                                                                          .id!,
                                                                      context);
                                                            },
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Icon(
                                                      Icons.close_rounded,
                                                      color: greyColor,
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    '${data[index].porsiMakanan}, • 100 g',
                                                    style:
                                                        greyTextStyle.copyWith(
                                                      fontSize: 10,
                                                      fontWeight: medium,
                                                    ),
                                                  ),
                                                  Text(
                                                    '${data[index].kalori} kcal',
                                                    style:
                                                        greyTextStyle.copyWith(
                                                      fontSize: 10,
                                                      fontWeight: medium,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Text(
                            'Anda belum memasukkan makanan',
                            style: greyTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: medium,
                            ),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(
                          'assets/ic_makan_malam.png',
                          width: 70,
                          height: 50,
                        ),
                        Column(
                          children: [
                            CustomTambahButton(
                              title: '+ Tambah',
                              onTap: () {
                                Get.toNamed(
                                  '/makanan-page',
                                  arguments: 'dinners',
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : dailyDietController.obx(
              (data) => Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                  top: 24,
                ),
                padding: EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Makan Malam',
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                        Obx(
                          () => Text(
                            '${data!.totalKaloriDinner} / ${targetController.batasDinner.value} kcal ',
                            style: blackTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: medium,
                            ),
                          ),
                        ),
                      ],
                    ),
                    data!.dinners!.isNotEmpty
                        ? SizedBox(
                            height: dailyDietController.heightDinner.value
                                .toDouble(),
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    separatorBuilder: (context, index) {
                                      return Divider(
                                        color: greyColor,
                                      );
                                    },
                                    itemCount: data.dinners!.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${data.dinners![index].namaMakanan}',
                                                  style:
                                                      blackTextStyle.copyWith(
                                                    fontSize: 16,
                                                    fontWeight: semiBold,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {},
                                                  child: Icon(
                                                    Icons.close_rounded,
                                                    color: greyColor,
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${data.dinners![index].porsiMakanan}, • 100 g',
                                                  style: greyTextStyle.copyWith(
                                                    fontSize: 10,
                                                    fontWeight: medium,
                                                  ),
                                                ),
                                                Text(
                                                  '${data.dinners![index].kalori} kcal',
                                                  style: greyTextStyle.copyWith(
                                                    fontSize: 10,
                                                    fontWeight: medium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Text(
                            'Anda belum memasukkan makanan',
                            style: greyTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: medium,
                            ),
                          ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(
                          'assets/ic_makan_malam.png',
                          width: 70,
                          height: 50,
                        ),
                        Column(
                          children: [
                            CustomTambahButton(
                              title: '+ Tambah',
                              onTap: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
    }

    Widget snackCard() {
      return Obx(
        () => dailyDietController.isToday.value
            ? snackController.obx(
                (data) => Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                    top: 24,
                  ),
                  padding: EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Snack',
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ),
                          ),
                          Obx(
                            () => Text(
                              '${snackController.snack.value} / ${targetController.batasSnack.value} kcal ',
                              style: blackTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: medium,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (data!.isNotEmpty)
                        SizedBox(
                          height: snackController.heightSnack.value.toDouble(),
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4.0,
                                  ),
                                  separatorBuilder: (context, index) {
                                    return Divider(
                                      color: greyColor,
                                    );
                                  },
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext thisContext) {
                                            final makananModel = MakananModel(
                                              namaMakanan:
                                                  data[index].namaMakanan,
                                              ukuran:
                                                  '${data[index].porsiMakanan}',
                                              beratMakanan: 100,
                                              kalori: data[index].kalori,
                                              karbohidrat:
                                                  data[index].karbohidrat,
                                              protein: data[index].protein,
                                              lemak: data[index].lemak,
                                            );

                                            return dialogPorsi(
                                              makananModel,
                                              context,
                                              data[index].id!,
                                              4,
                                            );
                                          },
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    '${data[index].namaMakanan}',
                                                    style:
                                                        blackTextStyle.copyWith(
                                                      fontSize: 16,
                                                      fontWeight: semiBold,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          thisContext) {
                                                        return dialogDelete(
                                                          () {
                                                            snackController
                                                                .delSnack(
                                                              data[index].id!,
                                                              context,
                                                            );
                                                          },
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Icon(
                                                    Icons.close_rounded,
                                                    color: greyColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${data[index].porsiMakanan}, • 100 g',
                                                  style: greyTextStyle.copyWith(
                                                    fontSize: 10,
                                                    fontWeight: medium,
                                                  ),
                                                ),
                                                Text(
                                                  '${data[index].kalori} kcal',
                                                  style: greyTextStyle.copyWith(
                                                    fontSize: 10,
                                                    fontWeight: medium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        Text(
                          'Anda belum memasukkan makanan',
                          style: greyTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: medium,
                          ),
                        ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset(
                            'assets/ic_snack.png',
                            width: 70,
                            height: 50,
                          ),
                          Column(
                            children: [
                              CustomTambahButton(
                                title: '+ Tambah',
                                onTap: () {
                                  Get.toNamed(
                                    '/makanan-page',
                                    arguments: 'snacks',
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            : dailyDietController.obx(
                (data) => Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                    top: 24,
                  ),
                  padding: EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Snack',
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ),
                          ),
                          Obx(
                            () => Text(
                              '${snackController.snack.value} / ${targetController.batasSnack.value} kcal ',
                              style: blackTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: medium,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (data!.snacks!.isNotEmpty)
                        SizedBox(
                          height:
                              dailyDietController.heightSnack.value.toDouble(),
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4.0,
                                  ),
                                  separatorBuilder: (context, index) {
                                    return Divider(
                                      color: greyColor,
                                    );
                                  },
                                  itemCount: data.snacks!.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                          '/makanan-page',
                                          arguments: 'snacks',
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 8.0,
                                        ),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${data.snacks![index].namaMakanan}',
                                                  style:
                                                      blackTextStyle.copyWith(
                                                    fontSize: 16,
                                                    fontWeight: semiBold,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {},
                                                  child: Icon(
                                                    Icons.close_rounded,
                                                    color: greyColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${data.snacks![index].porsiMakanan}, • 100 g',
                                                  style: greyTextStyle.copyWith(
                                                    fontSize: 10,
                                                    fontWeight: medium,
                                                  ),
                                                ),
                                                Text(
                                                  '${data.snacks![index].kalori} kcal',
                                                  style: greyTextStyle.copyWith(
                                                    fontSize: 10,
                                                    fontWeight: medium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      else
                        Text(
                          'Anda belum memasukkan makanan',
                          style: greyTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: medium,
                          ),
                        ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Image.asset(
                            'assets/ic_snack.png',
                            width: 70,
                            height: 50,
                          ),
                          Column(
                            children: [
                              CustomTambahButton(
                                title: '+ Tambah',
                                onTap: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      );
    }

    Widget aktifitasCard() {
      return Obx(() => dailyDietController.isToday.value
          ? sportDailyController.obx(
              (data) => Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                  top: 24,
                ),
                padding: EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Aktivitas',
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                        Obx(
                          () => Text(
                            '${sportDailyController.sport.value} kcal ',
                            style: blackTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: medium,
                            ),
                          ),
                        ),
                      ],
                    ),
                    data!.isNotEmpty
                        ? SizedBox(
                            height: sportDailyController.heightSport.value
                                .toDouble(),
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    separatorBuilder: (context, index) {
                                      return Divider(
                                        color: greyColor,
                                      );
                                    },
                                    itemCount: data.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    '${data[index].namaOlahraga}',
                                                    style:
                                                        blackTextStyle.copyWith(
                                                      fontSize: 16,
                                                      fontWeight: semiBold,
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          thisContext) {
                                                        return dialogDelete(
                                                          () {
                                                            sportDailyController
                                                                .delSport(
                                                                    data[index]
                                                                        .id!,
                                                                    context);
                                                          },
                                                        );
                                                      },
                                                    );
                                                  },
                                                  child: Icon(
                                                    Icons.close_rounded,
                                                    color: greyColor,
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${data[index].durasi}',
                                                  style: greyTextStyle.copyWith(
                                                    fontSize: 10,
                                                    fontWeight: medium,
                                                  ),
                                                ),
                                                Text(
                                                  '${data[index].kalori} kcal',
                                                  style: greyTextStyle.copyWith(
                                                    fontSize: 10,
                                                    fontWeight: medium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Text(
                            'Anda belum memasukkan aktivitas',
                            style: greyTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: medium,
                            ),
                          ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(
                          'assets/ic_aktifitas.png',
                          width: 50,
                          height: 30,
                        ),
                        Column(
                          children: [
                            CustomTambahButton(
                                title: '+ Tambah',
                                onTap: () {
                                  Get.toNamed('/aktifitas');
                                }),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : dailyDietController.obx(
              (data) => Container(
                width: double.infinity,
                margin: const EdgeInsets.only(
                  top: 24,
                ),
                padding: EdgeInsets.all(22),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Aktifitas',
                          style: blackTextStyle.copyWith(
                            fontSize: 16,
                            fontWeight: semiBold,
                          ),
                        ),
                        Text(
                          '${data!.totalKaloriDailySport} kcal ',
                          style: blackTextStyle.copyWith(
                            fontSize: 12,
                            fontWeight: medium,
                          ),
                        ),
                      ],
                    ),
                    data.dailySports!.isNotEmpty
                        ? SizedBox(
                            height: dailyDietController.heightSport.value
                                .toDouble(),
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.separated(
                                    physics: NeverScrollableScrollPhysics(),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 4.0),
                                    separatorBuilder: (context, index) {
                                      return Divider(
                                        color: greyColor,
                                      );
                                    },
                                    itemCount: data.dailySports!.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${data.dailySports![index].namaOlahraga}',
                                                  style:
                                                      blackTextStyle.copyWith(
                                                    fontSize: 16,
                                                    fontWeight: semiBold,
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {},
                                                  child: Icon(
                                                    Icons.close_rounded,
                                                    color: greyColor,
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '${data.dailySports![index].durasi}',
                                                  style: greyTextStyle.copyWith(
                                                    fontSize: 10,
                                                    fontWeight: medium,
                                                  ),
                                                ),
                                                Text(
                                                  '${data.dailySports![index].kalori} kcal',
                                                  style: greyTextStyle.copyWith(
                                                    fontSize: 10,
                                                    fontWeight: medium,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Text(
                            'Anda belum memasukkan aktivitas',
                            style: greyTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: medium,
                            ),
                          ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Image.asset(
                          'assets/ic_aktifitas.png',
                          width: 50,
                          height: 30,
                        ),
                        Column(
                          children: [
                            CustomTambahButton(
                              title: '+ Tambah',
                              onTap: () {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ));
    }

    Widget waterCard() {
      Widget singleGlass(WaterController controller, int index) {
        return Obx(
          () => GestureDetector(
            onTap: () {
              controller.toggleSelected(index);
              controller.saveGlassSelection();
            },
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Stack(
                children: [
                  Image.asset(
                    controller.valAir[index].isSelected
                        ? 'assets/ic_water_terisi.png'
                        : 'assets/ic_water_kosong.png',
                    width: 30,
                  ),
                  if (controller.valAir[index].isSelected)
                    Positioned(
                      top: -3,
                      left: 15,
                      child: Container(
                        width: 12,
                        height: 15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: purpleColor,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.check_circle,
                            color: whiteColor,
                            size: 10,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      }

      return GetBuilder<WaterController>(
        init: WaterController(),
        builder: (controller) {
          DateTime selectedDate = homePageController.dateFormat
              .parse(homePageController.valDate.value);

          bool isEmptyWaterCard = selectedDate.isAfter(DateTime.now());

          return Container(
            width: double.infinity,
            height: 207,
            margin: const EdgeInsets.only(
              top: 24,
            ),
            padding: EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: purpleColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Air Putih',
                      style: whiteTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                    ),
                    Obx(
                      () => Text(
                        '${(200 * controller.valAir.where((air) => air.isSelected).length / 1000).toStringAsFixed(1)}L / 2 L',
                        style: whiteTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 28,
                ),
                isEmptyWaterCard
                    ? Container()
                    : CarouselSlider(
                        items: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(
                              8,
                              (index) => GestureDetector(
                                onTap: () {
                                  controller.toggleSelected(index);
                                  controller.saveGlassSelection();
                                },
                                child: singleGlass(controller, index),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(
                              8,
                              (index) => GestureDetector(
                                onTap: () {
                                  controller.toggleSelected(index + 8);
                                  controller.saveGlassSelection();
                                },
                                child: singleGlass(controller, index + 8),
                              ),
                            ),
                          ),
                        ],
                        options: CarouselOptions(
                          viewportFraction: 1,
                          enableInfiniteScroll: false,
                          height: 60,
                          onPageChanged: (index, reason) {
                            if (reason == CarouselPageChangedReason.manual) {
                              controller.updateCarouselIndex(index);
                            }
                          },
                        ),
                      ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.only(
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: controller.currentIndex.value == 0
                            ? lightBackgroundColor
                            : Color(0xff7E91FF),
                      ),
                    ),
                    Container(
                      width: 8,
                      height: 8,
                      margin: const EdgeInsets.only(
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: controller.currentIndex.value == 1
                            ? lightBackgroundColor
                            : Color(0xff7E91FF),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
    }

    Widget beratBadanCard() {
      return Container(
        width: double.infinity,
        height: 137,
        margin: const EdgeInsets.only(
          top: 24,
        ),
        padding: EdgeInsets.all(22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: whiteColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Berat badan (kg)',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Image.asset(
                  'assets/ic_berat badan.png',
                  width: 50,
                  height: 50,
                ),
                Column(
                  children: [
                    CustomTambahButton(
                      title: '+ Tambah',
                      onTap: () {
                        Get.toNamed('/berat-badan-page');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget kosongCard() {
      return Container(
        width: double.infinity,
        height: 0.1,
        margin: const EdgeInsets.only(
          top: 24,
        ),
        padding: EdgeInsets.all(22),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: lightBackgroundColor,
        ),
      );
    }

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 2),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: true,
              snap: false,
              flexibleSpace: buildCalender(),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  buildCard(),
                  microCard(context),
                  sarapanCard(),
                  makanSiangCard(),
                  makanMalamCard(),
                  snackCard(),
                  aktifitasCard(),
                  waterCard(),
                  beratBadanCard(),
                  kosongCard(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget chart(context, List<ChartData> chartData, text1, text2, title) {
    return Expanded(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 8,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text1,
                      style: blackTextStyle.copyWith(
                          fontSize: 12, fontWeight: semiBold),
                    ),
                    Text(
                      text2,
                      style: greyTextStyle.copyWith(
                          fontSize: 8, fontWeight: regular),
                    ),
                  ],
                ),
                SfCircularChart(
                  palette: palletChart,
                  series: <CircularSeries>[
                    if (chartData.isNotEmpty)
                      DoughnutSeries<ChartData, String>(
                        dataSource: chartData,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) {
                          final double? yValue = data.y;
                          if (yValue != null) {
                            return yValue;
                          }
                          return 0.0; // Mengembalikan nilai default jika yValue adalah null
                        },
                        innerRadius: '80%',
                        cornerStyle: CornerStyle.bothCurve,
                        emptyPointSettings: EmptyPointSettings(
                          mode: EmptyPointMode.drop,
                        ),
                      )
                  ],
                )
              ],
            ),
          ),
          Text(
            title,
            style: blackTextStyle.copyWith(fontSize: 12, fontWeight: medium),
          ),
        ],
      ),
    );
  }

  Widget dialogDelete(Function onYes) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Wrap(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Peringatan penghapusan data',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: Text(
                    "Yakin anda menghapus data ini?",
                    style: blackTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomConfirmButton(
                      title: 'Tidak',
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    const SizedBox(
                      width: 22,
                    ),
                    CustomCorrectButton(
                      title: 'Yakin',
                      onPressed: () {
                        onYes();
                        Get.back();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget dialogPorsi(MakananModel model, context, int id, int makanan) {
    final controller = Get.find<MakananController>();
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              model.namaMakanan!,
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '${model.ukuran}, • ${model.beratMakanan} g',
              style: greyTextStyle.copyWith(
                fontSize: 10,
                fontWeight: medium,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() {
                  return detailPopup("Kalori", "${model.kalori}", "kcal",
                      controller.valPorsi.value);
                }),
                Obx(() {
                  return detailPopup("Karbohidrat", "${model.karbohidrat}", "g",
                      controller.valPorsi.value);
                }),
                Obx(() {
                  return detailPopup("Protein", "${model.protein}", "g",
                      controller.valPorsi.value);
                }),
                Obx(() {
                  return detailPopup("Lemak", "${model.lemak}", "g",
                      controller.valPorsi.value);
                }),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Porsi makanan",
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      if (controller.valPorsi.value > 0.25) {
                        controller.valPorsi.value -= 0.25;
                        controller.porsiTextController.text =
                            controller.valPorsi.value.toStringAsFixed(2);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 17,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: lightBackgroundColor,
                      ),
                      child: SvgPicture.asset("assets/minus_purple.svg"),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 40,
                    child: TextFormField(
                      controller: controller.porsiTextController,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        DotCommaTextInputFormatter(),
                      ],
                      onChanged: (value) {
                        if (value.isEmpty) {
                          // Handle empty value case
                          controller.valPorsi.value = 0.0;
                        } else {
                          final parsedValue = double.tryParse(value);
                          if (parsedValue != null && parsedValue >= 0.25) {
                            controller.valPorsi.value = parsedValue;
                          } else {
                            controller.valPorsi.value = 0.25;
                          }
                        }
                      },
                      style: blackTextStyle.copyWith(
                        fontSize: 16,
                        fontWeight: semiBold,
                      ),
                      textAlign: TextAlign.center,
                      cursorColor: purpleColor,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: purpleColor,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      if (controller.valPorsi.value >= 0.25) {
                        controller.valPorsi.value += 0.25;
                        controller.porsiTextController.text =
                            controller.valPorsi.value.toStringAsFixed(2);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 7,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: lightBackgroundColor,
                      ),
                      child: SvgPicture.asset("assets/plus_purple.svg"),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Text(
                    "Cancel",
                    style: purpleTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                InkWell(
                  onTap: () async {
                    switch (makanan) {
                      case 1:
                        breakfastController.putBreakfast(
                          id,
                          controller.valPorsi.value,
                          context,
                        );
                        break;
                      case 2:
                        lunchController.putLunch(
                          id,
                          controller.valPorsi.value,
                          context,
                        );
                        break;
                      case 3:
                        dinnerController.putDinner(
                          id,
                          controller.valPorsi.value,
                          context,
                        );
                        break;
                      case 4:
                        snackController.putSnack(
                          id,
                          controller.valPorsi.value,
                          context,
                        );
                        break;
                      default:
                    }
                    Get.back(); // Menutup dialog setelah mengubah porsi
                  },
                  child: Text(
                    "Update",
                    style: purpleTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget detailPopup(title, value, unit, double valPorsi) {
    final double result = double.parse(value) * valPorsi;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: blackTextStyle.copyWith(
            fontSize: 12,
            fontWeight: medium,
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text.rich(
          TextSpan(
            text: result.toStringAsFixed(2),
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
            children: [
              TextSpan(
                text: " $unit",
                style: greyTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: semiBold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
