import 'package:diet_app/shared/theme.dart';
import 'package:diet_app/view/widgets/notification_item.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool isNotificationEnabled = false;
  bool isNotificationMealsEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        children: [
          NotificationItem(
            title: "Notification",
            onChanged: (value) {
              setState(() {
                isNotificationEnabled = value;
                isNotificationMealsEnabled = value;
              });
            },
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(4),
            child: Text(
              'Meals',
              style: blackTextStyle.copyWith(
                fontSize: 18,
                fontWeight: semiBold,
              ),
            ),
          ),
          NotificationMeals(
            title: 'Sarapan',
            mealType: 'sarapan',
            selectedDurationText:
                null, // Set the default value or load from preferences
            isNotificationEnabled: isNotificationMealsEnabled,
          ),
          NotificationMeals(
            title: 'Makan Siang',
            mealType: 'makan_siang',
            selectedDurationText:
                null, // Set the default value or load from preferences
            isNotificationEnabled: isNotificationMealsEnabled,
          ),
          NotificationMeals(
            title: 'Makan Malam',
            mealType: 'makan_malam',
            selectedDurationText:
                null, // Set the default value or load from preferences
            isNotificationEnabled: isNotificationMealsEnabled,
          ),
          NotificationMeals(
            title: 'Snack',
            mealType: 'snack',
            selectedDurationText:
                null, // Set the default value or load from preferences
            isNotificationEnabled: isNotificationMealsEnabled,
          ),
        ],
      ),
    );
  }
}
