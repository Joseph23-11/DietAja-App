import 'package:diet_app/controllers/breakfast_controller.dart';
import 'package:diet_app/controllers/dinner_controller.dart';
import 'package:diet_app/controllers/lunch_controller.dart';
import 'package:diet_app/controllers/makanan_controller.dart';
import 'package:diet_app/controllers/snack_controller.dart';
import 'package:diet_app/models/makanan_model.dart';
import 'package:diet_app/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MakananPage extends GetView<MakananController> {
  MakananPage({Key? key}) : super(key: key);

  final FocusNode _searchFocusNode = FocusNode();

  final breakfastController = Get.find<BreakfastController>();
  final lunchController = Get.find<LunchController>();
  final dinnerController = Get.find<DinnerController>();
  final snackController = Get.find<SnackController>();

  final argumen = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: greyF7,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: blackColor,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: true,
        title: Text(
          'Cari makanan',
          style: blackTextStyle.copyWith(
            fontSize: 20,
            fontWeight: semiBold,
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Column(
            children: [
              GetBuilder<MakananController>(
                builder: (controller) => TextFormField(
                  controller: controller.textEditingController,
                  focusNode: _searchFocusNode,
                  style: blackTextStyle.copyWith(
                    fontWeight: medium,
                    fontSize: 14,
                  ),
                  onChanged: (value) {
                    controller.searchMakanan(value);
                  },
                  decoration: InputDecoration(
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: purpleColor,
                      ),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: greyColor,
                    ),
                    suffixIcon: controller.textEditingController.text.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              controller.clearSearch();
                            },
                            child: Icon(
                              Icons.clear,
                              color: purpleColor,
                            ),
                          )
                        : null,
                    hintText: "Pencarian makanan",
                    hintStyle: greyTextStyle.copyWith(
                      fontWeight: medium,
                    ),
                  ),
                  cursorColor: purpleColor,
                ),
              ),
              controller.obx(
                (data) => IconTheme(
                  data: IconThemeData(
                    color: purpleColor,
                  ),
                  child: Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 24),
                      child: ListView.builder(
                        itemCount: data!.length,
                        itemBuilder: (context, index) {
                          return _listItem(data[index], context);
                        },
                      ),
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

  Widget _listItem(MakananModel model, context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: whiteColor,
      ),
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 24),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return dialog(model, context, model.id);
            },
          );
        },
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    model.namaMakanan!,
                    style: blackTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                  ),
                ),
                SvgPicture.asset("assets/plus_purple.svg"),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${model.ukuran}, • ${model.beratMakanan} g',
                  style: greyTextStyle.copyWith(
                    fontSize: 10,
                    fontWeight: medium,
                  ),
                ),
                Text(
                  '${model.kalori} kcal',
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
  }

  Widget dialog(MakananModel model, context, id) {
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
                    switch (argumen) {
                      case 'breakfasts':
                        breakfastController.postBreakfast(
                          id,
                          controller.valPorsi.value,
                          context,
                        );
                        break;
                      case 'lunches':
                        lunchController.postLunch(
                          id,
                          controller.valPorsi.value,
                          context,
                        );
                        break;
                      case 'dinners':
                        dinnerController.postDinner(
                          id,
                          controller.valPorsi.value,
                          context,
                        );
                        break;
                      case 'snacks':
                        snackController.postSnack(
                          id,
                          controller.valPorsi.value,
                          context,
                        );
                        break;
                      default:
                    }
                    print('argumen: $argumen');

                    Get.back(); // Menutup dialog setelah mengubah porsi
                  },
                  child: Text(
                    "OK",
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
