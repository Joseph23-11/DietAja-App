import 'package:diet_app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:diet_app/shared/theme.dart';
import 'package:diet_app/view/widgets/package_aktifitas.dart';
import 'package:get/get.dart';
import '../../widgets/button.dart';

class PersonalDetailsPage2 extends GetView<AuthController> {
  const PersonalDetailsPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cek Aktivitas Fisik',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(
          top: 72,
          left: 24,
          right: 24,
        ),
        children: [
          Text(
            'Level aktivitas anda',
            style: blackTextStyle.copyWith(
              fontSize: 20,
              fontWeight: semiBold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: whiteColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 70,
                ),
                Obx(
                  () => Wrap(
                    spacing: 37,
                    runSpacing: 17,
                    children: [
                      PackageAktifitas(
                        title: 'Tidak aktif',
                        isSelected: controller.select3[0].value,
                        click: () {
                          for (int i = 0; i < controller.select3.length; i++) {
                            controller.select3[i].value = (i == 0);
                          }
                        },
                      ),
                      PackageAktifitas(
                        title: 'Cukup Aktif, berolahraga 1-2 kali/minggu',
                        isSelected: controller.select3[1].value,
                        click: () {
                          for (int i = 0; i < controller.select3.length; i++) {
                            controller.select3[i].value = (i == 1);
                          }
                        },
                      ),
                      PackageAktifitas(
                        title: 'Aktif, berolahraga 3-5 kali/minggu',
                        isSelected: controller.select3[2].value,
                        click: () {
                          for (int i = 0; i < controller.select3.length; i++) {
                            controller.select3[i].value = (i == 2);
                          }
                        },
                      ),
                      PackageAktifitas(
                        title: 'Sangat Aktif, berolahraga 6-7 kali/minggu',
                        isSelected: controller.select3[3].value,
                        click: () {
                          for (int i = 0; i < controller.select3.length; i++) {
                            controller.select3[i].value = (i == 3);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 94,
                ),
                CustomFilledButton(
                  title: "Berikutnya",
                  onPressed: () async {
                    await controller.setPal();
                    await controller.calcTdee();
                    Get.toNamed('/personal-details-3');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
