import 'package:diet_app/controllers/perubahan_berat_controller.dart';
import 'package:diet_app/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../widgets/button.dart';

class BeratBadanPage extends GetView<PerubahanBeratController> {
  const BeratBadanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Berat Harian'),
      ),
      body: Column(
        children: [
          controller.obx(
            (data) => Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(14),
                itemCount: data!.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(bottom: 18),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: whiteColor,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  data[index].createdAt!.substring(0, 10),
                                  style: blackTextStyle.copyWith(
                                    fontSize: 14,
                                    fontWeight: semiBold,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 22),
                            Text(
                              '${data[index].beratSekarang} kg',
                              style: purpleTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: semiBold,
                              ),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            Text(
                              '${(data[index].beratSekarang! - data[index].beratSebelumnya!).toStringAsFixed(2)} kg',
                              style: blackTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: semiBold,
                              ),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            InkWell(
                              onTap: () async {
                                showDialog(
                                  context: context,
                                  builder: (context) => dialogDelete(() {
                                    controller.delPerubahanBerat(
                                        data[index].id!, context);
                                  }),
                                );
                              },
                              child: Icon(
                                Icons.close_rounded,
                                color: greyColor,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            height: 45,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => CustomBeratBadan(
              title: 'Berat badan hari ini',
            ),
          );
        },
        backgroundColor: purpleColor,
        child: Image.asset(
          'assets/ic_plus_circle.png',
          width: 24,
        ),
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
}

class CustomBeratBadan extends StatefulWidget {
  final String title;

  const CustomBeratBadan({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  _CustomBeratBadanState createState() => _CustomBeratBadanState();
}

class _CustomBeratBadanState extends State<CustomBeratBadan> {
  double _valBerat = 0;
  final TextEditingController _controller = TextEditingController();

  final perubahanBeratController = Get.find<PerubahanBeratController>();

  @override
  void initState() {
    super.initState();
    _controller.text = _valBerat.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: blackTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          if (_valBerat > 0) {
                            _valBerat -= 0.1;
                            _controller.text = _valBerat.toStringAsFixed(1);
                          }
                        });
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
                    SizedBox(width: 20),
                    Container(
                      width: 50,
                      child: TextFormField(
                        controller: _controller,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          DotCommaTextInputFormatter(),
                        ],
                        onChanged: (value) {
                          setState(
                            () {
                              _valBerat = double.tryParse(value) ?? 0;
                            },
                          );
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
                    SizedBox(width: 20),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _valBerat += 0.1;
                          _controller.text = _valBerat.toStringAsFixed(1);
                        });
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
                      final weight = _valBerat;
                      print('weight: $weight');
                      await perubahanBeratController.postPerubahanBerat(weight);
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
