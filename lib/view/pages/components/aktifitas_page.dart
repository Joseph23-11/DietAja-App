import 'package:diet_app/controllers/sport_controller.dart';
import 'package:diet_app/controllers/sport_daily_controller.dart';
import 'package:diet_app/models/sport_model.dart';
import 'package:diet_app/shared/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AktifitasPage extends GetView<SportController> {
  AktifitasPage({Key? key}) : super(key: key);

  final FocusNode _searchFocusNode = FocusNode();

  final sportDailyController = Get.find<SportDailyController>();

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
          'Cari aktifitas',
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
              TextFormField(
                controller: controller.textEditingController,
                focusNode: _searchFocusNode,
                style: blackTextStyle.copyWith(
                  fontWeight: medium,
                  fontSize: 14,
                ),
                onChanged: (value) {
                  controller.searchSport(value);
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
                  suffixIcon: Obx(() {
                    if (_searchFocusNode.hasFocus ||
                        controller.searchQuery.value.isNotEmpty) {
                      return GestureDetector(
                        onTap: () {
                          controller.clearSearch();
                          _searchFocusNode.unfocus();
                        },
                        child: Icon(
                          Icons.clear,
                          color: purpleColor,
                        ),
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  }),
                  hintText: "Pencarian aktifitas",
                  hintStyle: greyTextStyle.copyWith(
                    fontWeight: medium,
                  ),
                ),
                cursorColor: purpleColor,
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

  Widget _listItem(SportModel model, context) {
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
                Text(
                  model.namaOlahraga!,
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: medium,
                  ),
                ),
                SvgPicture.asset("assets/plus_purple.svg"),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "1 jam",
                  style: greyTextStyle.copyWith(
                    fontSize: 10,
                    fontWeight: medium,
                  ),
                ),
                Text(
                  "${model.kalori} kcal",
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

  Widget dialog(SportModel model, context, id) {
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
              "Pilih Durasi",
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: ValueListenableBuilder(
                      valueListenable: controller.valJam,
                      builder: (_, jam, __) {
                        return SizedBox(
                          height: 150,
                          child: CupertinoPicker(
                            scrollController: FixedExtentScrollController(
                              initialItem: jam.value,
                            ),
                            itemExtent: 30,
                            onSelectedItemChanged: (value) =>
                                controller.valJam.value.value = value,
                            children: List<Widget>.generate(24, (index) {
                              return Center(
                                child: Text(
                                  index.toString(),
                                  style: blackTextStyle.copyWith(
                                    fontSize: 24,
                                  ),
                                ),
                              );
                            }),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Text(
                  "jam",
                  style: blackTextStyle.copyWith(fontSize: 16),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: ValueListenableBuilder(
                      valueListenable: controller.valMenit,
                      builder: (_, menit, __) {
                        return SizedBox(
                          height: 150,
                          child: CupertinoPicker(
                            scrollController: FixedExtentScrollController(
                              initialItem: menit.value,
                            ),
                            itemExtent: 30,
                            onSelectedItemChanged: (value) =>
                                controller.valMenit.value.value = value,
                            children: List<Widget>.generate(60, (index) {
                              return Center(
                                child: Text(
                                  index.toString(),
                                  style: blackTextStyle.copyWith(
                                    fontSize: 24,
                                  ),
                                ),
                              );
                            }),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Text(
                  "menit",
                  style: blackTextStyle.copyWith(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancel",
                    style: purpleTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: medium,
                    ),
                  ),
                ),
                SizedBox(width: 30),
                InkWell(
                  onTap: () async {
                    sportDailyController.postSport(
                      id,
                      controller.valJam.value.value,
                      controller.valMenit.value.value,
                    );
                    Get.back();
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
}
