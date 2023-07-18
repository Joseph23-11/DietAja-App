import 'package:diet_app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/theme.dart';
import '../../widgets/button.dart';
import '../../widgets/form.dart';

class SignUpPage extends GetView<AuthController> {
  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: GestureDetector(
        onTap: () {
          usernameFocusNode.unfocus();
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
              'Join Us to Unlock \nYour Growth',
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
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // NOTE: FULL NAME INPUT
                    CustomFormField(
                      title: 'Username',
                      inputType: TextInputType.text,
                      controller: controller.usernameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Username cannot be Empty");
                        }
                        return null;
                      },
                      focusNode: usernameFocusNode,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // NOTE: EMAIL INPUT
                    CustomFormField(
                      title: 'Email Address',
                      inputType: TextInputType.text,
                      controller: controller.emailController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Email cannot be Empty");
                        }
                        return null;
                      },
                      focusNode: emailFocusNode,
                    ),
                    const SizedBox(
                      height: 16,
                    ),

                    // NOTE: PASSWORD INPUT
                    CustomFormField(
                      title: 'Password',
                      obscureText: true,
                      inputType: TextInputType.text,
                      controller: controller.passwordController,
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
                    Obx(
                      () => SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: TextButton(
                          onPressed: controller.isLoading.value
                              ? null
                              : () async {
                                  if (formKey.currentState!.validate()) {
                                    await controller.postRegister();
                                    await controller.postLogin(
                                        true,
                                        controller.emailController.text,
                                        controller.passwordController.text,
                                        context);
                                  }
                                },
                          style: TextButton.styleFrom(
                            backgroundColor: purpleColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(56),
                            ),
                          ),
                          child: Text(
                            'Berikutnya',
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
            ),
            const SizedBox(
              height: 50,
            ),
            CustomTextButton(
              title: 'Sign In',
              onPressed: () {
                Get.offAllNamed('/sign-in');
              },
            ),
          ],
        ),
      ),
    );
  }
}
