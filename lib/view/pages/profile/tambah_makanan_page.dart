import 'package:diet_app/controllers/makanan_controller.dart';
import 'package:diet_app/shared/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../shared/theme.dart';
import '../../widgets/button.dart';
import '../../widgets/form.dart';

class TambahMakananPage extends StatelessWidget {
  final FocusNode namaFocusNode = FocusNode();
  final FocusNode beratFocusNode = FocusNode();
  final FocusNode kaloriFocusNode = FocusNode();
  final FocusNode karboFocusNode = FocusNode();
  final FocusNode lemakFocusNode = FocusNode();
  final FocusNode proteinFocusNode = FocusNode();
  final FocusNode ukuranFocusNode = FocusNode();
  TambahMakananPage({Key? key}) : super(key: key);

  final makananController = Get.find<MakananController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Makanan'),
      ),
      body: GestureDetector(
        onTap: () {
          namaFocusNode.unfocus();
          beratFocusNode.unfocus();
          kaloriFocusNode.unfocus();
          karboFocusNode.unfocus();
          lemakFocusNode.unfocus();
          proteinFocusNode.unfocus();
          ukuranFocusNode.unfocus();
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: whiteColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      CustomFormField(
                        title: 'Nama Makanan',
                        controller: makananController.namaController,
                        inputType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Nama Makanan cannot be Empty");
                          }
                          return null;
                        },
                        focusNode: namaFocusNode,
                      ),
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Text('porsi • 100g',
                            style: greyTextStyle.copyWith(
                              fontSize: 12,
                              fontWeight: regular,
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomFormField(
                    title: 'Berat Makanan (gram)',
                    controller: makananController.beratController,
                    inputType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      DotCommaTextInputFormatter(),
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Kalori Makanan cannot be Empty");
                      }
                      return null;
                    },
                    focusNode: beratFocusNode,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomFormField(
                    title: 'Kalori Makanan (kcal)',
                    controller: makananController.kaloriController,
                    inputType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      DotCommaTextInputFormatter(),
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Kalori Makanan cannot be Empty");
                      }
                      return null;
                    },
                    focusNode: kaloriFocusNode,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomFormField(
                    title: 'Karbohidrat (gram)',
                    controller: makananController.karboController,
                    inputType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      DotCommaTextInputFormatter(),
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Karbohidrat cannot be Empty");
                      }
                      return null;
                    },
                    focusNode: karboFocusNode,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomFormField(
                    title: 'Lemak (gram)',
                    controller: makananController.lemakController,
                    inputType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      DotCommaTextInputFormatter(),
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Lemak cannot be Empty");
                      }
                      return null;
                    },
                    focusNode: lemakFocusNode,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomFormField(
                    title: 'Protein (gram)',
                    controller: makananController.proteinController,
                    inputType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      DotCommaTextInputFormatter(),
                    ],
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Protein cannot be Empty");
                      }
                      return null;
                    },
                    focusNode: proteinFocusNode,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomFormField(
                    title: 'Ukuran (porsi)',
                    controller: makananController.ukuranController,
                    inputType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Ukuran cannot be Empty");
                      }
                      return null;
                    },
                    focusNode: ukuranFocusNode,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomFilledButton(
                    title: 'Tambah makanan',
                    onPressed: () async {
                      // controller.updateUserDataById();
                      await makananController.postFood(
                        makananController.namaController.text,
                        int.parse(makananController.beratController.text),
                        double.parse(makananController.kaloriController.text),
                        double.parse(makananController.karboController.text),
                        double.parse(makananController.lemakController.text),
                        double.parse(makananController.proteinController.text),
                        makananController.ukuranController.text,
                      );

                      await makananController.getFood();

                      showCustomSnackbar(
                        context,
                        'Berhasil menambahkan makanan',
                        Colors.greenAccent,
                      );
                    },
                  ),
                ],
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
