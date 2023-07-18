import 'package:diet_app/controllers/breakfast_controller.dart';
import 'package:diet_app/controllers/dinner_controller.dart';
import 'package:diet_app/controllers/lunch_controller.dart';
import 'package:diet_app/controllers/snack_controller.dart';
import 'package:diet_app/controllers/target_controller.dart';
import 'package:diet_app/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:get/get.dart';

import '../../../controllers/daily_diet_controller.dart';
import '../../../models/chart_data.dart';

class NutrisiPage extends StatefulWidget {
  const NutrisiPage({super.key});

  @override
  State<NutrisiPage> createState() => _NutrisiPageState();
}

class _NutrisiPageState extends State<NutrisiPage> {
  final targetController = Get.find<TargetController>();
  final breakfastController = Get.find<BreakfastController>();
  final lunchController = Get.find<LunchController>();
  final dinnerController = Get.find<DinnerController>();
  final snackController = Get.find<SnackController>();
  final dailyDietController = Get.find<DailyDietController>();

  @override
  Widget build(BuildContext context) {
    final List<Color> palletChart = [pink, redColor, purpleColor];
    final List<Color> palletChartKalori = [
      redColor,
      blueColor,
      purpleColor,
      purpleDarkColor
    ];

    return Scaffold(
      backgroundColor: lightBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Nutrisi",
          style: blackTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Obx(() => dailyDietController.isToday.value
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: whiteColor),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Makronutrisi",
                            style: blackTextStyle.copyWith(
                                fontSize: 16, fontWeight: semiBold),
                          ),
                          Obx(
                            () => Row(
                              children: [
                                makronutrisi(
                                  context,
                                  palletChart,
                                  [
                                    ChartData(
                                      'Karbohidrat',
                                      (((breakfastController.breakfastKarbo.value +
                                                  lunchController
                                                      .lunchKarbo.value +
                                                  dinnerController
                                                      .dinnerKarbo.value +
                                                  snackController
                                                      .snackKarbo.value) /
                                              (breakfastController
                                                      .breakfastKarbo.value +
                                                  lunchController
                                                      .lunchKarbo.value +
                                                  dinnerController
                                                      .dinnerKarbo.value +
                                                  snackController
                                                      .snackKarbo.value +
                                                  breakfastController
                                                      .breakfastProtein.value +
                                                  lunchController
                                                      .lunchProtein.value +
                                                  dinnerController
                                                      .dinnerProtein.value +
                                                  snackController
                                                      .snackProtein.value +
                                                  breakfastController
                                                      .breakfastLemak.value +
                                                  lunchController
                                                      .lunchLemak.value +
                                                  dinnerController
                                                      .dinnerLemak.value +
                                                  snackController
                                                      .snackLemak.value +
                                                  1)) *
                                          100),
                                    ),
                                    ChartData(
                                      'Protein',
                                      (((breakfastController.breakfastProtein.value +
                                                  lunchController
                                                      .lunchProtein.value +
                                                  dinnerController
                                                      .dinnerProtein.value +
                                                  snackController
                                                      .snackProtein.value) /
                                              (breakfastController
                                                      .breakfastKarbo.value +
                                                  lunchController
                                                      .lunchKarbo.value +
                                                  dinnerController
                                                      .dinnerKarbo.value +
                                                  snackController
                                                      .snackKarbo.value +
                                                  breakfastController
                                                      .breakfastProtein.value +
                                                  lunchController
                                                      .lunchProtein.value +
                                                  dinnerController
                                                      .dinnerProtein.value +
                                                  snackController
                                                      .snackProtein.value +
                                                  breakfastController
                                                      .breakfastLemak.value +
                                                  lunchController
                                                      .lunchLemak.value +
                                                  dinnerController
                                                      .dinnerLemak.value +
                                                  snackController
                                                      .snackLemak.value +
                                                  1)) *
                                          100),
                                    ),
                                    ChartData(
                                      'Lemak',
                                      (((breakfastController.breakfastLemak.value +
                                                  lunchController
                                                      .lunchLemak.value +
                                                  dinnerController
                                                      .dinnerLemak.value +
                                                  snackController
                                                      .snackLemak.value) /
                                              (breakfastController
                                                      .breakfastKarbo.value +
                                                  lunchController
                                                      .lunchKarbo.value +
                                                  dinnerController
                                                      .dinnerKarbo.value +
                                                  snackController
                                                      .snackKarbo.value +
                                                  breakfastController
                                                      .breakfastProtein.value +
                                                  lunchController
                                                      .lunchProtein.value +
                                                  dinnerController
                                                      .dinnerProtein.value +
                                                  snackController
                                                      .snackProtein.value +
                                                  breakfastController
                                                      .breakfastLemak.value +
                                                  lunchController
                                                      .lunchLemak.value +
                                                  dinnerController
                                                      .dinnerLemak.value +
                                                  snackController
                                                      .snackLemak.value +
                                                  1)) *
                                          100),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: whiteColor),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Makronutrisi hari yg lalu",
                            style: blackTextStyle.copyWith(
                                fontSize: 16, fontWeight: semiBold),
                          ),
                          Obx(
                            () => Row(
                              children: [
                                makronutrisi(
                                  context,
                                  palletChart,
                                  [
                                    ChartData(
                                      'Karbohidrat',
                                      (((dailyDietController.breakfastKarbo.value +
                                                  dailyDietController
                                                      .lunchKarbo.value +
                                                  dailyDietController
                                                      .dinnerKarbo.value +
                                                  dailyDietController
                                                      .snackKarbo.value) /
                                              (dailyDietController.breakfastKarbo.value +
                                                  dailyDietController
                                                      .lunchKarbo.value +
                                                  dailyDietController
                                                      .dinnerKarbo.value +
                                                  dailyDietController
                                                      .snackKarbo.value +
                                                  dailyDietController
                                                      .breakfastProtein.value +
                                                  dailyDietController
                                                      .lunchProtein.value +
                                                  dailyDietController
                                                      .dinnerProtein.value +
                                                  dailyDietController
                                                      .snackProtein.value +
                                                  dailyDietController
                                                      .breakfastLemak.value +
                                                  dailyDietController
                                                      .lunchLemak.value +
                                                  dailyDietController
                                                      .dinnerLemak.value +
                                                  dailyDietController
                                                      .snackLemak.value +
                                                  1)) *
                                          100),
                                    ),
                                    ChartData(
                                      'Protein',
                                      (((dailyDietController.breakfastProtein.value +
                                                  dailyDietController
                                                      .lunchProtein.value +
                                                  dailyDietController
                                                      .dinnerProtein.value +
                                                  dailyDietController
                                                      .snackProtein.value) /
                                              (dailyDietController.breakfastKarbo.value +
                                                  dailyDietController
                                                      .lunchKarbo.value +
                                                  dailyDietController
                                                      .dinnerKarbo.value +
                                                  dailyDietController
                                                      .snackKarbo.value +
                                                  dailyDietController
                                                      .breakfastProtein.value +
                                                  dailyDietController
                                                      .lunchProtein.value +
                                                  dailyDietController
                                                      .dinnerProtein.value +
                                                  dailyDietController
                                                      .snackProtein.value +
                                                  dailyDietController
                                                      .breakfastLemak.value +
                                                  dailyDietController
                                                      .lunchLemak.value +
                                                  dailyDietController
                                                      .dinnerLemak.value +
                                                  dailyDietController
                                                      .snackLemak.value +
                                                  1)) *
                                          100),
                                    ),
                                    ChartData(
                                      'Lemak',
                                      (((dailyDietController.breakfastLemak.value +
                                                  dailyDietController
                                                      .lunchLemak.value +
                                                  dailyDietController
                                                      .dinnerLemak.value +
                                                  dailyDietController
                                                      .snackLemak.value) /
                                              (dailyDietController.breakfastKarbo.value +
                                                  dailyDietController
                                                      .lunchKarbo.value +
                                                  dailyDietController
                                                      .dinnerKarbo.value +
                                                  dailyDietController
                                                      .snackKarbo.value +
                                                  dailyDietController
                                                      .breakfastProtein.value +
                                                  dailyDietController
                                                      .lunchProtein.value +
                                                  dailyDietController
                                                      .dinnerProtein.value +
                                                  dailyDietController
                                                      .snackProtein.value +
                                                  dailyDietController
                                                      .breakfastLemak.value +
                                                  dailyDietController
                                                      .lunchLemak.value +
                                                  dailyDietController
                                                      .dinnerLemak.value +
                                                  dailyDietController
                                                      .snackLemak.value +
                                                  1)) *
                                          100),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              Obx(() => dailyDietController.isToday.value
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
                                chartNutrisi(
                                  context,
                                  [
                                    (breakfastController.breakfastKarbo.value +
                                                lunchController
                                                    .lunchKarbo.value +
                                                dinnerController
                                                    .dinnerKarbo.value +
                                                snackController
                                                    .snackKarbo.value) <
                                            targetController.karbo.value
                                        ? ChartData(
                                            'Karbohidrat1',
                                            (((breakfastController
                                                            .breakfastKarbo
                                                            .value +
                                                        lunchController
                                                            .lunchKarbo.value +
                                                        dinnerController
                                                            .dinnerKarbo.value +
                                                        snackController
                                                            .snackKarbo.value) /
                                                    targetController
                                                        .karbo.value) *
                                                100))
                                        : ChartData(
                                            'Karbohidrat1',
                                            100,
                                          ),
                                    (breakfastController.breakfastKarbo.value +
                                                lunchController
                                                    .lunchKarbo.value +
                                                dinnerController
                                                    .dinnerKarbo.value +
                                                snackController
                                                    .snackKarbo.value) <
                                            targetController.karbo.value
                                        ? ChartData(
                                            'Karbohidrat2',
                                            (100 -
                                                ((breakfastController.breakfastKarbo.value +
                                                            lunchController
                                                                .lunchKarbo
                                                                .value +
                                                            dinnerController
                                                                .dinnerKarbo
                                                                .value +
                                                            snackController
                                                                .snackKarbo
                                                                .value) /
                                                        targetController
                                                            .karbo.value) *
                                                    100))
                                        : ChartData('Karbohidrat2', 0)
                                  ],
                                  "${breakfastController.breakfastKarbo.value + lunchController.lunchKarbo.value + dinnerController.dinnerKarbo.value + snackController.snackKarbo.value}",
                                  "/ ${targetController.karbo.value} g",
                                  "Karbohidrat",
                                ),
                                chartNutrisi(
                                  context,
                                  [
                                    (breakfastController
                                                    .breakfastProtein.value +
                                                lunchController
                                                    .lunchProtein.value +
                                                dinnerController
                                                    .dinnerProtein.value +
                                                snackController
                                                    .snackProtein.value) <
                                            targetController.protein.value
                                        ? ChartData(
                                            'Protein',
                                            (((breakfastController
                                                            .breakfastProtein.value +
                                                        lunchController
                                                            .lunchProtein
                                                            .value +
                                                        dinnerController
                                                            .dinnerProtein
                                                            .value +
                                                        snackController
                                                            .snackProtein
                                                            .value) /
                                                    targetController
                                                        .protein.value) *
                                                100))
                                        : ChartData(
                                            'Protein',
                                            100,
                                          ),
                                    (breakfastController
                                                    .breakfastProtein.value +
                                                lunchController
                                                    .lunchProtein.value +
                                                dinnerController
                                                    .dinnerProtein.value +
                                                snackController
                                                    .snackProtein.value) <
                                            targetController.protein.value
                                        ? ChartData(
                                            'Protein2',
                                            (100 -
                                                ((breakfastController
                                                                .breakfastProtein.value +
                                                            lunchController
                                                                .lunchProtein
                                                                .value +
                                                            dinnerController
                                                                .dinnerProtein
                                                                .value +
                                                            snackController
                                                                .snackProtein
                                                                .value) /
                                                        targetController
                                                            .protein.value) *
                                                    100))
                                        : ChartData('Protein2', 0),
                                  ],
                                  "${breakfastController.breakfastProtein.value + lunchController.lunchProtein.value + dinnerController.dinnerProtein.value + snackController.snackProtein.value}",
                                  "/ ${targetController.protein.value} g",
                                  "Protein",
                                ),
                                chartNutrisi(
                                  context,
                                  [
                                    (breakfastController.breakfastLemak.value +
                                                lunchController
                                                    .lunchLemak.value +
                                                dinnerController
                                                    .dinnerLemak.value +
                                                snackController
                                                    .snackLemak.value) <
                                            targetController.lemak.value
                                        ? ChartData(
                                            'Lemak',
                                            (((breakfastController
                                                            .breakfastLemak
                                                            .value +
                                                        lunchController
                                                            .lunchLemak.value +
                                                        dinnerController
                                                            .dinnerLemak.value +
                                                        snackController
                                                            .snackLemak.value) /
                                                    targetController
                                                        .lemak.value) *
                                                100))
                                        : ChartData('Lemak', 100),
                                    (breakfastController.breakfastLemak.value +
                                                lunchController
                                                    .lunchLemak.value +
                                                dinnerController
                                                    .dinnerLemak.value +
                                                snackController
                                                    .snackLemak.value) <
                                            targetController.lemak.value
                                        ? ChartData(
                                            'Lemak2',
                                            (100 -
                                                ((breakfastController.breakfastLemak.value +
                                                            lunchController
                                                                .lunchLemak
                                                                .value +
                                                            dinnerController
                                                                .dinnerLemak
                                                                .value +
                                                            snackController
                                                                .snackLemak
                                                                .value) /
                                                        targetController
                                                            .lemak.value) *
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
                            'Nutrisi hari yg lalu',
                            style: blackTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ),
                          ),
                          Obx(
                            () => Row(
                              children: [
                                chartNutrisi(
                                  context,
                                  [
                                    (dailyDietController.breakfastKarbo.value +
                                                dailyDietController
                                                    .lunchKarbo.value +
                                                dailyDietController
                                                    .dinnerKarbo.value +
                                                dailyDietController
                                                    .snackKarbo.value) <
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
                                                    targetController
                                                        .karbo.value) *
                                                100))
                                        : ChartData(
                                            'Karbohidrat1',
                                            100,
                                          ),
                                    (dailyDietController.breakfastKarbo.value +
                                                dailyDietController
                                                    .lunchKarbo.value +
                                                dailyDietController
                                                    .dinnerKarbo.value +
                                                dailyDietController
                                                    .snackKarbo.value) <
                                            targetController.karbo.value
                                        ? ChartData(
                                            'Karbohidrat2',
                                            (100 -
                                                ((dailyDietController
                                                                .breakfastKarbo.value +
                                                            dailyDietController
                                                                .lunchKarbo.value +
                                                            dailyDietController
                                                                .dinnerKarbo
                                                                .value +
                                                            dailyDietController
                                                                .snackKarbo
                                                                .value) /
                                                        targetController
                                                            .karbo.value) *
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
                                chartNutrisi(
                                  context,
                                  [
                                    (dailyDietController.breakfastProtein.value +
                                                dailyDietController
                                                    .lunchProtein.value +
                                                dailyDietController
                                                    .dinnerProtein.value +
                                                dailyDietController
                                                    .snackProtein.value) <
                                            targetController.protein.value
                                        ? ChartData(
                                            'Protein',
                                            (((dailyDietController
                                                            .breakfastProtein
                                                            .value +
                                                        dailyDietController
                                                            .lunchProtein
                                                            .value +
                                                        dailyDietController
                                                            .dinnerProtein
                                                            .value +
                                                        dailyDietController
                                                            .snackProtein
                                                            .value) /
                                                    targetController
                                                        .protein.value) *
                                                100))
                                        : ChartData(
                                            'Protein',
                                            100,
                                          ),
                                    (dailyDietController.breakfastProtein.value +
                                                dailyDietController
                                                    .lunchProtein.value +
                                                dailyDietController
                                                    .dinnerProtein.value +
                                                dailyDietController
                                                    .snackProtein.value) <
                                            targetController.protein.value
                                        ? ChartData(
                                            'Protein2',
                                            (100 -
                                                ((dailyDietController
                                                                .breakfastProtein
                                                                .value +
                                                            dailyDietController
                                                                .lunchProtein
                                                                .value +
                                                            dailyDietController
                                                                .dinnerProtein
                                                                .value +
                                                            dailyDietController
                                                                .snackProtein
                                                                .value) /
                                                        targetController
                                                            .protein.value) *
                                                    100))
                                        : ChartData('Protein2', 0),
                                  ],
                                  "${dailyDietController.breakfastProtein.value + dailyDietController.lunchProtein.value + dailyDietController.dinnerProtein.value + dailyDietController.snackProtein.value}",
                                  "/ ${targetController.protein.value} g",
                                  "Protein",
                                ),
                                chartNutrisi(
                                  context,
                                  [
                                    (dailyDietController.breakfastLemak.value +
                                                dailyDietController
                                                    .lunchLemak.value +
                                                dailyDietController
                                                    .dinnerLemak.value +
                                                dailyDietController
                                                    .snackLemak.value) <
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
                                                    targetController
                                                        .lemak.value) *
                                                100))
                                        : ChartData(
                                            'Lemak',
                                            100,
                                          ),
                                    (dailyDietController.breakfastLemak.value +
                                                dailyDietController
                                                    .lunchLemak.value +
                                                dailyDietController
                                                    .dinnerLemak.value +
                                                dailyDietController
                                                    .snackLemak.value) <
                                            targetController.lemak.value
                                        ? ChartData(
                                            'Lemak2',
                                            (100 -
                                                ((dailyDietController
                                                                .breakfastLemak.value +
                                                            dailyDietController
                                                                .lunchLemak.value +
                                                            dailyDietController
                                                                .dinnerLemak
                                                                .value +
                                                            dailyDietController
                                                                .snackLemak
                                                                .value) /
                                                        targetController
                                                            .lemak.value) *
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
                    )),
              const SizedBox(height: 30),
              Obx(
                () => dailyDietController.isToday.value
                    ? Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: whiteColor),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Kalori",
                              style: blackTextStyle.copyWith(
                                  fontSize: 16, fontWeight: semiBold),
                            ),
                            kalori(
                              context,
                              palletChartKalori,
                              [
                                ChartData(
                                  'Sarapan',
                                  (breakfastController.breakfast.value /
                                          (breakfastController.breakfast.value +
                                              lunchController.lunch.value +
                                              dinnerController.dinner.value +
                                              snackController.snack.value +
                                              1)) *
                                      100,
                                ),
                                ChartData(
                                  'Makan Siang',
                                  (lunchController.lunch.value /
                                          (breakfastController.breakfast.value +
                                              lunchController.lunch.value +
                                              dinnerController.dinner.value +
                                              snackController.snack.value +
                                              1)) *
                                      100,
                                ),
                                ChartData(
                                  'Makan Malam',
                                  (dinnerController.dinner.value /
                                          (breakfastController.breakfast.value +
                                              lunchController.lunch.value +
                                              dinnerController.dinner.value +
                                              snackController.snack.value +
                                              1)) *
                                      100,
                                ),
                                ChartData(
                                  'Snack',
                                  (snackController.snack.value /
                                          (breakfastController.breakfast.value +
                                              lunchController.lunch.value +
                                              dinnerController.dinner.value +
                                              snackController.snack.value +
                                              1)) *
                                      100,
                                ),
                              ],
                              breakfastController.breakfast.value,
                              lunchController.lunch.value,
                              dinnerController.dinner.value,
                              snackController.snack.value,
                            ),
                          ],
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: whiteColor),
                        padding: EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Kalori hari yang lalu",
                              style: blackTextStyle.copyWith(
                                  fontSize: 16, fontWeight: semiBold),
                            ),
                            kalori(
                              context,
                              palletChartKalori,
                              [
                                ChartData(
                                  'Sarapan',
                                  (dailyDietController.breakfast.value /
                                          (dailyDietController.breakfast.value +
                                              dailyDietController.lunch.value +
                                              dailyDietController.dinner.value +
                                              dailyDietController.snack.value +
                                              1)) *
                                      100,
                                ),
                                ChartData(
                                  'Makan Siang',
                                  (dailyDietController.lunch.value /
                                          (dailyDietController.breakfast.value +
                                              dailyDietController.lunch.value +
                                              dailyDietController.dinner.value +
                                              dailyDietController.snack.value +
                                              1)) *
                                      100,
                                ),
                                ChartData(
                                  'Makan Malam',
                                  (dailyDietController.dinner.value /
                                          (dailyDietController.breakfast.value +
                                              dailyDietController.lunch.value +
                                              dailyDietController.dinner.value +
                                              dailyDietController.snack.value +
                                              1)) *
                                      100,
                                ),
                                ChartData(
                                  'Snack',
                                  (dailyDietController.snack.value /
                                          (dailyDietController.breakfast.value +
                                              dailyDietController.lunch.value +
                                              dailyDietController.dinner.value +
                                              dailyDietController.snack.value +
                                              1)) *
                                      100,
                                ),
                              ],
                              dailyDietController.breakfast.value,
                              dailyDietController.lunch.value,
                              dailyDietController.dinner.value,
                              dailyDietController.snack.value,
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget makronutrisi(context, palletChart, chartData) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.height / 8,
            child: SfCircularChart(
              palette: palletChart,
              series: <CircularSeries>[
                DoughnutSeries<ChartData, String>(
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => data.x,
                  yValueMapper: (ChartData data, _) => data.y,
                  innerRadius: '70%',
                  cornerStyle: CornerStyle.bothFlat,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              descChart(
                pink,
                "${chartData[0].y.round()} %",
                "Karbohidrat",
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: descChart(
                  redColor,
                  "${chartData[1].y.round()} %",
                  "Protein",
                ),
              ),
              descChart(
                purpleColor,
                "${chartData[2].y.round()} %",
                "Lemak",
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget kalori(context, pallet, chart, breakfast, lunch, dinner, snack) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 3,
                height: MediaQuery.of(context).size.height / 8,
                child: SfCircularChart(
                  palette: pallet,
                  series: <CircularSeries>[
                    DoughnutSeries<ChartData, String>(
                      dataSource: chart,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y,
                      innerRadius: '70%',
                      cornerStyle: CornerStyle.bothFlat,
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rincian kalori",
                      style: blackTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: semiBold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Kalori Total",
                              style: greyTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: medium,
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                text: "${breakfast + lunch + dinner + snack}",
                                style: blackTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: medium,
                                ),
                                children: [
                                  TextSpan(
                                    text: " kcal",
                                    style: greyTextStyle.copyWith(
                                      fontSize: 8,
                                      fontWeight: regular,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Target",
                              style: greyTextStyle.copyWith(
                                fontSize: 12,
                                fontWeight: medium,
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                text: "${targetController.kalori.value}",
                                style: blackTextStyle.copyWith(
                                  fontSize: 12,
                                  fontWeight: medium,
                                ),
                                children: [
                                  TextSpan(
                                    text: " kcal",
                                    style: greyTextStyle.copyWith(
                                      fontSize: 8,
                                      fontWeight: regular,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  descChart(
                    redColor,
                    "${((breakfast / (breakfast + lunch + dinner + snack + 1)) * 100).round()}%",
                    "Sarapan",
                  ),
                  SizedBox(height: 8),
                  descChart(
                    purpleColor,
                    "${((dinner / (breakfast + lunch + dinner + snack + 1)) * 100).round()}%",
                    "Makan Malam",
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  descChart(
                    blueColor,
                    "${((lunch / (breakfast + lunch + dinner + snack + 1)) * 100).round()}%",
                    "Makan Siang",
                  ),
                  SizedBox(height: 8),
                  descChart(
                    purpleDarkColor,
                    "${((snack / (breakfast + lunch + dinner + snack + 1)) * 100).round()}%",
                    "Snack",
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget chartNutrisi(context, List<ChartData> chart, text1, text2, title) {
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
                SfCircularChart(palette: [
                  purpleColor,
                  greyF7
                ], series: <CircularSeries>[
                  DoughnutSeries<ChartData, String>(
                    dataSource: chart,
                    xValueMapper: (ChartData data, _) => data.x,
                    yValueMapper: (ChartData data, _) => data.y,
                    innerRadius: '80%',
                    cornerStyle: CornerStyle.bothCurve,
                  )
                ]),
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

  Widget descChart(color, percent, title) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: color,
          ),
        ),
        SizedBox(width: 10),
        Text(
          "$percent $title",
          style: blackTextStyle.copyWith(fontSize: 10, fontWeight: medium),
        ),
      ],
    );
  }
}
