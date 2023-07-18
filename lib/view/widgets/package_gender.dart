import 'package:flutter/material.dart';

import '../../shared/theme.dart';

class PackageGender extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function() click;

  const PackageGender(
      {Key? key,
      required this.title,
      this.isSelected = false,
      required this.click})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: click,
      child: Container(
        width: 137,
        height: 45,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
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
