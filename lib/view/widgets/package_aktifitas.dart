import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class PackageAktifitas extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function() click;
  const PackageAktifitas(
      {Key? key,
      required this.title,
      this.isSelected = false,
      required this.click})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 327,
      height: 45,
      padding: const EdgeInsets.symmetric(
        horizontal: 2,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isSelected ? purpleColor : greyColor,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: click,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: blackTextStyle.copyWith(
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
