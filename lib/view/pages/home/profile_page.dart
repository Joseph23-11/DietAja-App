import 'package:diet_app/controllers/user_controller.dart';
import 'package:diet_app/controllers/water_contoller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/theme.dart';
import '../../widgets/button.dart';
import '../../widgets/profile_menu_item.dart';

class ProfilePage extends GetView<UserController> {
  ProfilePage({Key? key}) : super(key: key);

  final waterController = Get.put(WaterController());

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'My Profile',
        ),
      );
    }

    Widget content() {
      return controller.obx(
        (data) => Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 22,
          ),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Container(
                width: 120,
                height: 120,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: CircleAvatar(
                        radius: 120,
                        backgroundColor: Color(0xff7E91FF),
                        child: Text(
                          (data?.username?.isNotEmpty == true)
                              ? (data!.username!.contains(' ')
                                  ? '${data.username!.split(' ')[0][0].toUpperCase()}${data.username!.split(' ')[1][0].toUpperCase()}'
                                  : (data.username!.length > 1
                                      ? '${data.username![0].toUpperCase()}${data.username![data.username!.length - 1].toUpperCase()}'
                                      : data.username![0].toUpperCase()))
                              : '',
                          style: whiteTextStyle.copyWith(
                            fontSize: 24,
                            fontWeight: semiBold,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: whiteColor,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.check_circle,
                            color: greenColor,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                data?.username ?? '',
                style: blackTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: medium,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              ProfileMenuItem(
                iconUrl: 'assets/ic_edit_profile.png',
                title: 'Edit Profile',
                onTap: () {
                  Get.toNamed('/edit-profile');
                },
              ),
              ProfileMenuItem(
                iconUrl: 'assets/ic_personal_details.png',
                title: 'Personal Details',
                onTap: () {
                  Get.toNamed('/personal-details');
                },
              ),
              ProfileMenuItem(
                iconUrl: 'assets/ic_help.png',
                title: 'Notification',
                onTap: () {
                  Get.toNamed('/notification');
                },
              ),
              ProfileMenuItem(
                iconUrl: 'assets/ic_create_food.png',
                title: 'Create Food',
                onTap: () {
                  Get.toNamed('/create-food');
                },
              ),
              ProfileMenuItem(
                iconUrl: 'assets/ic_logout.png',
                title: 'Log Out',
                onTap: () async {
                  waterController.resetWaterData();
                  controller.postLogout(context);
                },
              ),
            ],
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
      ),
      children: [
        header(),
        const SizedBox(
          height: 30,
        ),
        content(),
        const SizedBox(
          height: 35,
        ),
        CustomTextButton(
          title: 'Report a Problem',
        ),
      ],
    );
  }
}
