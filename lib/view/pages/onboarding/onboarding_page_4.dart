import 'package:diet_app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../shared/theme.dart';
import '../../widgets/button.dart';
import '../../widgets/form.dart';

class OnboardingPage4 extends GetView<AuthController> {
  final FocusNode targetFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  OnboardingPage4({Key? key}) : super(key: key);

  final ValueNotifier<String> _valBerat = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Set Target Berat Badan',
        ),
      ),
      body: GestureDetector(
        onTap: () {
          targetFocusNode.unfocus();
        },
        child: ListView(
          padding: const EdgeInsets.only(
            top: 72,
            left: 24,
            right: 24,
          ),
          children: [
            Text(
              'Target berat badan (kg)',
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: lightBackgroundColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFormField(
                    title: '',
                    inputType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      DotCommaTextInputFormatter(),
                    ],
                    controller: controller.tecBerat,
                    onChange: (text) {
                      _valBerat.value = text;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("This Value cannot be Empty");
                      }
                      return null;
                    },
                    focusNode: targetFocusNode,
                  ),
                ],
              ),
            ),
            ValueListenableBuilder<String>(
              valueListenable: _valBerat,
              builder: (_, berat, __) {
                controller.beratAwal.value =
                    double.parse(controller.beratController.text);
                double beratTarget = double.tryParse(berat) ?? 0.0;
                controller.totalPengurangan.value =
                    controller.beratAwal.value - beratTarget;
                return Container(
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: whiteColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Seberapa cepat anda akan melakukannya?',
                        style: blackTextStyle.copyWith(
                          fontSize: 12,
                          fontWeight: medium,
                        ),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Obx(
                            () => Slider(
                              value: controller.currentValue.value,
                              min: 0.0,
                              max: 1,
                              divisions: 2,
                              onChanged: (double value) {
                                controller.updateSliderValue(value);
                              },
                              activeColor: purpleDarkColor,
                              inactiveColor: purpleColor,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Lambat',
                                  style: blackTextStyle.copyWith(fontSize: 12)),
                              Text('Normal',
                                  style: blackTextStyle.copyWith(fontSize: 12)),
                              Text('Cepat',
                                  style: blackTextStyle.copyWith(fontSize: 12)),
                            ],
                          ),
                          SizedBox(height: 35),
                          Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Rencana pengurangan berat badan anda:',
                                    style: blackTextStyle.copyWith(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Hari target diet:\n${controller.hari.value} hari',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'Kebutuhan kalori harian:\n${controller.kalori.value}',
                                  style: blackTextStyle.copyWith(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Total pengurangan berat badan:\n${controller.totalPengurangan.value.toStringAsFixed(1)} kg",
                            style: blackTextStyle.copyWith(
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomFilledButton(
                              title: "Berikutnya",
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => MoreDialog(
                                      beratAwal: controller.beratAwal.value,
                                      gender: controller.gender[0].value
                                          ? 'Pria'
                                          : 'Wanita',
                                      usia: int.parse(
                                          controller.usiaController.text),
                                      kalori: controller.kalori.value,
                                      tinggi: double.parse(
                                          controller.tinggiController.text),
                                      totalPengurangan:
                                          controller.totalPengurangan.value,
                                      onPressed: () async {
                                        print('siuuuuu');
                                        await controller.createPersonalDetails(
                                          controller.gender[0].value
                                              ? 'pria'
                                              : 'wanita',
                                          controller.beratAwal.value,
                                          int.parse(
                                              controller.tinggiController.text),
                                          int.parse(
                                              controller.usiaController.text),
                                        );
                                        await controller.createTarget(
                                          controller.pal.value.toString(),
                                          int.parse(controller.tecBerat.text),
                                          controller.currentLabel.value
                                              .toString()
                                              .toLowerCase(),
                                          controller.hari.value,
                                          controller.kalori.value,
                                          controller.totalPengurangan.value
                                              .toInt(),
                                        );
                                        Get.offAndToNamed('/main-page');
                                      },
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MoreDialog extends StatelessWidget {
  final double beratAwal;
  final double totalPengurangan;
  final String gender;
  final double tinggi;
  final int usia;
  final int kalori;
  final Function onPressed;

  const MoreDialog({
    Key? key,
    required this.beratAwal,
    required this.totalPengurangan,
    required this.gender,
    required this.tinggi,
    required this.usia,
    required this.kalori,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      content: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: whiteColor,
        ),
        child: Wrap(
          children: [
            Text(
              'Cek kembali data anda',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Apakah data yang diisikan sudah benar?\nJenis kelamin: $gender\nBerat: $beratAwal kg\nTinggi: $tinggi cm\nUsia: $usia tahun\nBudget kalori harian: $kalori kcal\n',
              style: blackTextStyle.copyWith(
                fontSize: 12,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomConfirmButton(
                      title: 'Batal',
                      onPressed: () {
                        Navigator.pop(context, '/onboarding-page-4');
                      },
                    ),
                    const SizedBox(
                      width: 22,
                    ),
                    CustomCorrectButton(
                      title: 'Benar',
                      onPressed: () {
                        onPressed();
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
}

class DotCommaTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String newText = newValue.text.replaceAll(',', '.');
    return newValue.copyWith(text: newText);
  }
}
