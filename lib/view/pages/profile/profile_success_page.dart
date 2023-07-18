import 'package:diet_app/controllers/main_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/theme.dart';
import '../../widgets/button.dart';

class ProfileSuccessPage extends StatefulWidget {
  const ProfileSuccessPage({super.key});

  @override
  State<ProfileSuccessPage> createState() => _ProfileSuccessPageState();
}

class _ProfileSuccessPageState extends State<ProfileSuccessPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nice Update!',
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 26,
            ),
            Text(
              'Your data is safe with\nour system',
              style: greyTextStyle.copyWith(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
            CustomFilledButton(
              width: 183,
              title: 'My Profile',
              onPressed: () {
                Get.find<MainPageController>().currentIndex.value = 0;
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/main-page',
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
