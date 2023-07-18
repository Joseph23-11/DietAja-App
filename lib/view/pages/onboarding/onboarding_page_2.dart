import 'package:diet_app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../shared/theme.dart';
import '../../widgets/form.dart';
import '../../widgets/package_gender.dart';

class OnboardingPage2 extends GetView<AuthController> {
  final FocusNode beratFocusNode = FocusNode();
  final FocusNode tinggiFocusNode = FocusNode();
  final FocusNode usiaFocusNode = FocusNode();
  final bool isSelected;
  OnboardingPage2({
    Key? key,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cek Kebutuhan Kalori',
        ),
      ),
      body: GestureDetector(
        onTap: () {
          beratFocusNode.unfocus();
          tinggiFocusNode.unfocus();
          usiaFocusNode.unfocus();
        },
        child: ListView(
          padding: const EdgeInsets.only(
            top: 72,
            left: 24,
            right: 24,
          ),
          children: [
            Text(
              'Masukkan data anda',
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: medium,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: whiteColor,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // NOTE: JENIS KELAMIN
                    Text(
                      'Jenis Kelamin',
                      style: blackTextStyle.copyWith(
                        fontWeight: medium,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Obx(
                      () => Wrap(
                        spacing: 24,
                        runSpacing: 17,
                        children: [
                          PackageGender(
                            title: 'Pria',
                            isSelected: controller.gender[0].value,
                            click: () {
                              controller.gender[0].value =
                                  !controller.gender[0].value;
                              controller.gender[1].value = false;
                            },
                          ),
                          PackageGender(
                            title: 'Wanita',
                            isSelected: controller.gender[1].value,
                            click: () {
                              controller.gender[0].value = false;
                              controller.gender[1].value =
                                  !controller.gender[1].value;
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),
                    // NOTE: BERAT BADAN
                    CustomFormField(
                      title: 'Berat Badan (kg)',
                      inputType: TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        DotCommaTextInputFormatter(),
                      ],
                      controller: controller.beratController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Berat Badan cannot be Empty");
                        }
                        return null;
                      },
                      focusNode: beratFocusNode,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // NOTE: TINGGI BADAN
                    CustomFormField(
                      title: 'Tinggi Badan (cm)',
                      inputType: TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        DotCommaTextInputFormatter(),
                      ],
                      controller: controller.tinggiController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Tinggi cannot be Empty");
                        }
                        return null;
                      },
                      focusNode: tinggiFocusNode,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // NOTE: USIA
                    CustomFormField(
                      title: 'Usia (tahun)',
                      inputType: TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        DotCommaTextInputFormatter(),
                      ],
                      controller: controller.usiaController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Usia cannot be Empty");
                        }
                        return null;
                      },
                      focusNode: usiaFocusNode,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: TextButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () async {
                                  if (formKey.currentState!.validate()) {
                                    // controller.postRegister();
                                    controller.calcBmr(
                                      controller.gender[0].value,
                                      double.parse(
                                          controller.beratController.text),
                                      double.parse(
                                          controller.tinggiController.text),
                                      int.parse(controller.usiaController.text),
                                    );
                                    Get.toNamed('/onboarding-page-3');
                                  }
                                },
                          style: TextButton.styleFrom(
                            backgroundColor: purpleColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(56),
                            ),
                          ),
                          child: Text(
                            'Berikutnya',
                            style: whiteTextStyle.copyWith(
                              fontSize: 16,
                              fontWeight: semiBold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
