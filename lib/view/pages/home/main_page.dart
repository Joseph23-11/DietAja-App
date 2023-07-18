import 'package:diet_app/controllers/main_page_controller.dart';
import 'package:diet_app/shared/theme.dart';
import 'package:diet_app/view/pages/home/profile_page.dart';
import 'package:diet_app/view/pages/home/status_page.dart';
import 'package:diet_app/view/widgets/home_service_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_page.dart';
import 'nutrisi_page.dart';

class MainPage extends GetView<MainPageController> {
  MainPage({Key? key}) : super(key: key);

  final PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Widget cartButton() {
      return FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const PlusButton(),
          );
        },
        backgroundColor: purpleColor,
        child: Image.asset(
          'assets/ic_plus_circle.png',
          width: 24,
        ),
      );
    }

    Widget customBottomNav() {
      return ClipRRect(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(0),
        ),
        child: Obx(
          () => BottomAppBar(
            color: whiteColor,
            shape: const CircularNotchedRectangle(),
            clipBehavior: Clip.antiAlias,
            notchMargin: 6,
            elevation: 0,
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: whiteColor,
              elevation: 0,
              selectedItemColor: purpleColor,
              unselectedItemColor: blackColor,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedLabelStyle: purpleTextStyle.copyWith(
                fontSize: 10,
                fontWeight: medium,
              ),
              unselectedLabelStyle: blackTextStyle.copyWith(
                fontSize: 10,
                fontWeight: medium,
              ),
              currentIndex: controller.currentIndex.value,
              onTap: (value) {
                print('Tapped index: $value');
                controller.currentIndex.value = value;
                pageController.animateToPage(
                  value,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
                // setState(() {});
              },
              items: [
                BottomNavigationBarItem(
                  icon: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      controller.currentIndex.value == 0
                          ? purpleColor
                          : blackColor,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      'assets/ic_overview.png',
                      width: 20,
                    ),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      controller.currentIndex.value == 1
                          ? purpleColor
                          : blackColor,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      'assets/ic_my_rewards.png',
                      width: 20,
                    ),
                  ),
                  label: 'Nutrisi',
                ),
                BottomNavigationBarItem(
                  icon: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      controller.currentIndex.value == 2
                          ? purpleColor
                          : blackColor,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      'assets/ic_statistic.png',
                      width: 20,
                    ),
                  ),
                  label: 'Status',
                ),
                BottomNavigationBarItem(
                  icon: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      controller.currentIndex.value == 3
                          ? purpleColor
                          : blackColor,
                      BlendMode.srcIn,
                    ),
                    child: Image.asset(
                      'assets/ic_edit_profile.png',
                      width: 20,
                    ),
                  ),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget body() {
      return PageView(
        controller: pageController, // Assign the PageController
        physics: NeverScrollableScrollPhysics(), // Disable page swiping
        children: [
          HomePage(),
          NutrisiPage(),
          StatusPage(),
          ProfilePage(),
        ],
      );
    }

    return Scaffold(
      floatingActionButton: cartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: customBottomNav(),
      body: body(),
    );
  }
}

class PlusButton extends StatelessWidget {
  const PlusButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      alignment: Alignment.bottomCenter,
      content: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: lightBackgroundColor,
        ),
        child: Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Wrap(
                  spacing: 29,
                  runSpacing: 25,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/aktifitas');
                      },
                      child: HomeServiceItemPage(
                        iconUrl: 'assets/ic_aktifitas.png',
                        title: 'Aktivitas',
                        color: hijau,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed('/berat-badan-page');
                      },
                      child: HomeServiceItemPage(
                        iconUrl: 'assets/ic_berat badan.png',
                        title: 'Berat\nBadan',
                        color: biru,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          '/makanan-page',
                          arguments: 'breakfasts',
                        );
                      },
                      child: HomeServiceItemPage(
                        iconUrl: 'assets/makan_pagi.png',
                        title: 'Makan\n  Pagi',
                        color: orange,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          '/makanan-page',
                          arguments: 'lunches',
                        );
                      },
                      child: HomeServiceItemPage(
                        iconUrl: 'assets/ic_makan_siang.png',
                        title: 'Makan\n Siang',
                        color: ungu,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          '/makanan-page',
                          arguments: 'dinners',
                        );
                      },
                      child: HomeServiceItemPage(
                        iconUrl: 'assets/ic_makan_malam.png',
                        title: 'Makan\nMalam',
                        color: pink2,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          '/makanan-page',
                          arguments: 'snacks',
                        );
                      },
                      child: HomeServiceItemPage(
                        iconUrl: 'assets/ic_snack.png',
                        title: 'Snack',
                        color: pinkMuda,
                      ),
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
