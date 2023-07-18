import 'package:diet_app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/theme.dart';
import '../../widgets/button.dart';
import '../../widgets/form.dart';

class SignInPage extends GetView<AuthController> {
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: GestureDetector(
        onTap: () {
          emailFocusNode.unfocus();
          passwordFocusNode.unfocus();
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            Container(
              width: 170,
              height: 50,
              margin: const EdgeInsets.only(
                top: 100,
                bottom: 100,
              ),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/img_logo_light.png'),
                ),
              ),
            ),
            Text(
              'Sign In &\nGrow Your Diet',
              style: blackTextStyle.copyWith(
                fontSize: 20,
                fontWeight: semiBold,
              ),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomFormField(
                    key: const Key('emailField'),
                    title: 'Email Address',
                    inputType: TextInputType.emailAddress,
                    controller: controller.emailController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("email cannot be Empty");
                      }
                      return null;
                    },
                    focusNode: emailFocusNode,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  CustomFormField(
                    key: const Key('passwordField'),
                    title: 'Password',
                    obscureText: true,
                    inputType: TextInputType.text,
                    controller: controller.passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return ("password cannot be Empty");
                      }
                      return null;
                    },
                    focusNode: passwordFocusNode,
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
                                await controller.postLogin(
                                    false,
                                    controller.emailController.text,
                                    controller.passwordController.text,
                                    context);
                              },
                        style: TextButton.styleFrom(
                          backgroundColor: purpleColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(56),
                          ),
                        ),
                        child: Text(
                          'Sign In',
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
            const SizedBox(
              height: 50,
            ),
            CustomTextButton(
              key: const Key('createAccountButton'),
              title: 'Create New Account',
              onPressed: () {
                Get.toNamed('/sign-up');
              },
            ),
          ],
        ),
      ),
    );
  }
}
