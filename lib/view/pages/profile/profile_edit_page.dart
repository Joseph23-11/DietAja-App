import 'package:diet_app/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/theme.dart';
import '../../widgets/button.dart';
import '../../widgets/form.dart';

class ProfileEditPage extends GetView<UserController> {
  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  ProfileEditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: GestureDetector(
        onTap: () {
          usernameFocusNode.unfocus();
          emailFocusNode.unfocus();
          passwordFocusNode.unfocus();
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: whiteColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFormField(
                    title: 'Username',
                    controller: controller.usernameController,
                    inputType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Username cannot be Empty");
                      }
                      return null;
                    },
                    focusNode: passwordFocusNode,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomFormField(
                    title: 'Email Address',
                    controller: controller.emailController,
                    inputType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Email cannot be Empty");
                      }
                      return null;
                    },
                    focusNode: passwordFocusNode,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomFormField(
                    title: 'Password',
                    controller: controller.passwordController,
                    obscureText: true,
                    inputType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("Password cannot be Empty");
                      }
                      return null;
                    },
                    focusNode: passwordFocusNode,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomFilledButton(
                    title: 'Update Sekarang',
                    onPressed: () async {
                      controller.updateUserDataById();
                      Get.toNamed('/success-page');
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
