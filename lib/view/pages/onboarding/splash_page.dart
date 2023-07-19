import 'dart:async';

import 'package:diet_app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/theme.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final controller = Get.find<AuthController>();
  String? token;
  String? username;
  String? password;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      token = prefs.getString('token');
      username = prefs.getString('username');
      password = prefs.getString('password');

      if (token != null && token!.isNotEmpty) {
        if (username != null &&
            password != null &&
            username!.isNotEmpty &&
            password!.isNotEmpty) {
          Timer(const Duration(seconds: 2), () async {
            await controller.postLogin(
              false,
              username!,
              password!,
              context,
            );
          });
        } else {
          Timer(const Duration(seconds: 2), () {
            Navigator.pushNamedAndRemoveUntil(
                context, '/sign-in', (route) => false);
          });
        }
      } else {
        Timer(const Duration(seconds: 2), () {
          Navigator.pushNamedAndRemoveUntil(
              context, '/onboarding', (route) => false);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: lightBackgroundColor,
        body: Center(
          child: Container(
            width: 242,
            height: 50,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/img_logo_light.png',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
