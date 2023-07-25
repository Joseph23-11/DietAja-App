import 'package:diet_app/controllers/daily_diet_controller.dart';
import 'package:diet_app/controllers/perubahan_berat_controller.dart';
import 'package:diet_app/controllers/target_controller.dart';
import 'package:diet_app/controllers/user_controller.dart';
import 'package:diet_app/networks/api_service.dart';
import 'package:diet_app/networks/base_provider.dart';
import 'package:diet_app/services/providers/perubahan_berat_provider.dart';
import 'package:diet_app/services/repository/perubahan_berat_repository.dart';
import 'package:diet_app/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:get/get.dart';

import '../../../models/chart_data.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({Key? key}) : super(key: key);

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  final dailyDietController = Get.find<DailyDietController>();
  @override
  void initState() {
    super.initState();
    dailyDietController.getStatusHariDiet();
  }

  @override
  Widget build(BuildContext context) {
    final List<Color> palletChart = [purpleColor, greyF7];

    TooltipBehavior tooltipBehavior = TooltipBehavior(enable: true);

    final userController = Get.find<UserController>();
    final targetController = Get.find<TargetController>();

    return Scaffold(
      backgroundColor: lightBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Status",
          style: blackTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15), color: whiteColor),
                padding: EdgeInsets.all(20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Status",
                            style: blackTextStyle.copyWith(
                                fontSize: 14, fontWeight: semiBold),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height / 7,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GetBuilder<DailyDietController>(
                                      builder: (controller) => Text(
                                        "${controller.statusHari.value}",
                                        style: blackTextStyle.copyWith(
                                          fontSize: 12,
                                          fontWeight: semiBold,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "/ ${targetController.targetHari} hari",
                                      style: greyTextStyle.copyWith(
                                          fontSize: 8, fontWeight: regular),
                                    ),
                                  ],
                                ),
                                SfCircularChart(
                                    palette: palletChart,
                                    series: <CircularSeries>[
                                      DoughnutSeries<ChartData, String>(
                                        dataSource: [
                                          ChartData(
                                            'status1',
                                            (targetController.targetHari.value -
                                                    dailyDietController
                                                        .statusHari.value)
                                                .toDouble(),
                                          ),
                                          ChartData(
                                            'status2',
                                            dailyDietController.statusHari.value
                                                .toDouble(),
                                          ),
                                        ],
                                        xValueMapper: (ChartData data, _) =>
                                            data.x,
                                        yValueMapper: (ChartData data, _) =>
                                            data.y,
                                        innerRadius: '80%',
                                        cornerStyle: CornerStyle.bothCurve,
                                      )
                                    ]),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            "Berat badan",
                            style: blackTextStyle.copyWith(
                                fontSize: 14, fontWeight: semiBold),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(TextSpan(
                                      text:
                                          "${userController.beratBadan.value}",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 14, fontWeight: semiBold),
                                      children: [
                                        TextSpan(
                                            text: " kg",
                                            style: greyTextStyle.copyWith(
                                                fontSize: 12,
                                                fontWeight: regular))
                                      ])),
                                  Text(
                                    "Awal",
                                    style: greyTextStyle.copyWith(
                                        fontSize: 12, fontWeight: regular),
                                  )
                                ],
                              ),
                              Icon(Icons.arrow_forward),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text.rich(TextSpan(
                                      text: "${targetController.targetBerat}",
                                      style: blackTextStyle.copyWith(
                                          fontSize: 14, fontWeight: semiBold),
                                      children: [
                                        TextSpan(
                                            text: " kg",
                                            style: greyTextStyle.copyWith(
                                                fontSize: 12,
                                                fontWeight: regular))
                                      ])),
                                  Text(
                                    "Target",
                                    style: greyTextStyle.copyWith(
                                        fontSize: 12, fontWeight: regular),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15), color: whiteColor),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Minggu terakhir",
                      style: blackTextStyle.copyWith(
                          fontSize: 14, fontWeight: semiBold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GetBuilder<PerubahanBeratController>(
                      init: PerubahanBeratController(Get.put(
                          PerubahanBeratProvider(Get.put(
                              PerubahanBeratRepository(Get.put(
                                  ApiService(Get.put(BaseProvider())))))))),
                      builder: (controller) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SfCartesianChart(
                              primaryXAxis: DateTimeCategoryAxis(
                                dateFormat: DateFormat('dd MMM'),
                                labelRotation: 50,
                                desiredIntervals: 10,
                                labelPlacement: LabelPlacement.betweenTicks,
                              ),
                              tooltipBehavior: tooltipBehavior,
                              series: [
                                // regresi line
                                LineSeries<ChartData, DateTime>(
                                  dataSource: controller.regresiList,
                                  xValueMapper: (ChartData data, _) {
                                    if (data.isPrediction) {
                                      DateTime currentDate =
                                          DateTime.parse(data.x!);
                                      DateTime nextDate =
                                          currentDate.add(Duration(days: 0));
                                      return nextDate;
                                    } else {
                                      String dateString =
                                          data.x!.substring(0, 10);
                                      return DateTime.parse(dateString);
                                    }
                                  },
                                  yValueMapper: (ChartData data, _) => data.y,
                                  color: Colors.transparent,
                                  enableTooltip: false,
                                  dataLabelSettings: DataLabelSettings(
                                    isVisible: false,
                                    color: Colors.yellowAccent,
                                    borderRadius: 10,
                                  ),
                                  markerSettings: MarkerSettings(
                                    isVisible: false,
                                  ),
                                ),
                                // prediksi line
                                LineSeries<ChartData, DateTime>(
                                  dataSource: controller.weightDataList,
                                  dashArray: <double>[1, 100000000],
                                  xValueMapper: (ChartData data, _) {
                                    if (data.isPrediction) {
                                      DateTime currentDate =
                                          DateTime.parse(data.x!);
                                      DateTime nextDate =
                                          currentDate.add(Duration(days: 0));
                                      return nextDate;
                                    } else {
                                      String dateString =
                                          data.x!.substring(0, 10);
                                      return DateTime.parse(dateString);
                                    }
                                  },
                                  yValueMapper: (ChartData data, _) => data.y,
                                  color: purpleColor,
                                  enableTooltip: false,
                                  dataLabelSettings: DataLabelSettings(
                                    isVisible: true,
                                    color: pink,
                                    borderRadius: 10,
                                  ),
                                  markerSettings: MarkerSettings(
                                    isVisible: true,
                                  ),
                                ),
                                LineSeries<ChartData, DateTime>(
                                  dataSource: controller.regresiList2,
                                  xValueMapper: (ChartData data, _) {
                                    if (data.isPrediction) {
                                      DateTime currentDate =
                                          DateFormat('yyyy-MM-dd')
                                              .parse(data.x!);
                                      DateTime nextDate =
                                          currentDate.add(Duration(days: 0));
                                      return nextDate;
                                    } else {
                                      String dateString =
                                          data.x!.substring(0, 10);
                                      return DateFormat('yyyy-MM-dd')
                                          .parse(dateString);
                                    }
                                  },
                                  yValueMapper: (ChartData data, _) => data.y,
                                  color: pink,
                                  enableTooltip: false,
                                  dataLabelSettings: DataLabelSettings(
                                    isVisible: true,
                                    textStyle: whiteTextStyle.copyWith(
                                      fontSize: 11,
                                    ),
                                    color: redColor,
                                    borderRadius: 10,
                                  ),
                                  markerSettings: MarkerSettings(
                                    isVisible: false,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            // Hari Target = 19 hari (dd-MMM), berat target = 70kg
                            Text(
                              "Hari target = ${controller.hariTarget.hari} hari (${controller.hariTarget.tanggal}), berat target = ${targetController.targetBerat} kg",
                              style: blackTextStyle.copyWith(
                                  fontSize: 10, fontWeight: regular),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Berat badan berikutnya = ${controller.prediksiBerat.berat} kg (${controller.prediksiBerat.tanggal})",
                              style: blackTextStyle.copyWith(
                                  fontSize: 10, fontWeight: regular),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
