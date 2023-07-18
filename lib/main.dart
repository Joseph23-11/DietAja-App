import 'package:diet_app/view/pages/profile/personal_details_page2.dart';
import 'package:diet_app/view/pages/profile/personal_details_page3.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:diet_app/shared/theme.dart';
import 'package:diet_app/view/pages/components/aktifitas_page.dart';
import 'package:diet_app/view/pages/components/berat_badan_page.dart';
import 'package:diet_app/view/pages/components/makanan_page.dart';
import 'package:diet_app/view/pages/home/home_page.dart';
import 'package:diet_app/view/pages/home/main_page.dart';
import 'package:diet_app/view/pages/home/nutrisi_page.dart';
import 'package:diet_app/view/pages/home/profile_page.dart';
import 'package:diet_app/view/pages/home/status_page.dart';
import 'package:diet_app/view/pages/onboarding/onboarding_page.dart';
import 'package:diet_app/view/pages/onboarding/onboarding_page_2.dart';
import 'package:diet_app/view/pages/onboarding/onboarding_page_3.dart';
import 'package:diet_app/view/pages/onboarding/onboarding_page_4.dart';
import 'package:diet_app/view/pages/profile/notification_page.dart';
import 'package:diet_app/view/pages/profile/personal_details_page.dart';
import 'package:diet_app/view/pages/profile/profile_edit_page.dart';
import 'package:diet_app/view/pages/profile/profile_success_page.dart';
import 'package:diet_app/view/pages/onboarding/splash_page.dart';
import 'package:diet_app/view/pages/auth/sign_in_page.dart';
import 'package:diet_app/view/pages/auth/sign_up_page.dart';
import 'package:diet_app/view/pages/profile/tambah_makanan_page.dart';

import 'bindings/app_binding.dart';
import 'bindings/auth_binding.dart';
import 'bindings/daily_diet_binding.dart';
import 'bindings/home_page_binding.dart';
import 'bindings/main_page_binding.dart';
import 'bindings/makanan_binding.dart';
import 'bindings/perubahan_berat_binding.dart';
import 'bindings/sport_binding.dart';
import 'bindings/target_binding.dart';
import 'bindings/user_binding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: lightBackgroundColor,
        appBarTheme: AppBarTheme(
          backgroundColor: lightBackgroundColor,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: blackColor,
          ),
          titleTextStyle: blackTextStyle.copyWith(
            fontSize: 20,
            fontWeight: semiBold,
          ),
        ),
      ),
      initialBinding: AppBinding(),
      getPages: [
        GetPage(
          name: '/',
          page: () => const SplashPage(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: '/onboarding',
          page: () => const OnboardingPage(),
        ),
        GetPage(
          name: '/sign-in',
          page: () => SignInPage(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: '/sign-up',
          page: () => SignUpPage(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: '/onboarding-page-2',
          page: () => OnboardingPage2(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: '/onboarding-page-3',
          page: () => const OnboardingPage3(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: '/onboarding-page-4',
          page: () => OnboardingPage4(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: '/main-page',
          page: () => MainPage(),
          bindings: [
            MainPageBinding(),
            UserBinding(),
            AuthBinding(),
            HomePageBinding(),
            TargetBinding(),
            MakananBinding(),
            SportBinding(),
            DailyDietBinding(),
          ],
        ),
        GetPage(
          name: '/home-page',
          page: () => HomePage(),
          bindings: [],
        ),
        GetPage(
          name: '/makanan-page',
          page: () => MakananPage(),
          bindings: [
            MakananBinding(),
          ],
        ),
        GetPage(
          name: '/profile-page',
          page: () => ProfilePage(),
          bindings: [
            UserBinding(),
            AuthBinding(),
          ],
        ),
        GetPage(
          name: '/nutrisi-page',
          page: () => NutrisiPage(),
          bindings: [
            UserBinding(),
            MakananBinding(),
          ],
        ),
        GetPage(
          name: '/status-page',
          page: () => StatusPage(),
          bindings: [
            UserBinding(),
            TargetBinding(),
          ],
        ),
        GetPage(
          name: '/edit-profile',
          page: () => ProfileEditPage(),
        ),
        GetPage(
          name: '/personal-details',
          page: () => PersonalDetailsPage(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: '/personal-details-2',
          page: () => PersonalDetailsPage2(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: '/personal-details-3',
          page: () => PersonalDetailsPage3(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: '/success-page',
          page: () => const ProfileSuccessPage(),
        ),
        GetPage(
          name: '/berat-badan-page',
          page: () => const BeratBadanPage(),
          binding: PerubahanBeratBinding(),
        ),
        GetPage(
          name: '/aktifitas',
          page: () => AktifitasPage(),
          binding: SportBinding(),
        ),
        GetPage(
          name: '/notification',
          page: () => const NotificationPage(),
        ),
        GetPage(
          name: '/create-food',
          page: () => TambahMakananPage(),
          binding: MakananBinding(),
        ),
      ],
      initialRoute: '/',
    );
  }
}
