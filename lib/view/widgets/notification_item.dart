import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../shared/theme.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class NotificationItem extends StatefulWidget {
  final String title;
  final Function(bool) onChanged;

  const NotificationItem({
    Key? key,
    required this.title,
    required this.onChanged,
  }) : super(key: key);

  @override
  _NotificationItemState createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  bool _isSwitchedNotification = false;
  late SharedPreferences _preferences;

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  Future<void> loadPreferences() async {
    _preferences = await SharedPreferences.getInstance();
    setState(() {
      _isSwitchedNotification =
          _preferences.getBool('notificationEnabled') ?? false;
    });
  }

  Future<void> savePreferences() async {
    await _preferences.setBool('notificationEnabled', _isSwitchedNotification);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        top: 24,
      ),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: whiteColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  widget.title,
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlutterSwitch(
                  width: 48.0,
                  height: 25.0,
                  toggleSize: 20.0,
                  value: _isSwitchedNotification,
                  borderRadius: 20.0,
                  padding: 5.0,
                  onToggle: (val) async {
                    setState(() {
                      _isSwitchedNotification = val;
                    });
                    widget.onChanged(val);
                    savePreferences();
                  },
                  activeColor: purpleColor,
                  inactiveColor: Color(0xffBAC4FF),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12, bottom: 12),
            child: Text(
              'Aktifkan notifikasi agar diet kamu \nberhasil!',
              style: greyTextStyle.copyWith(
                fontSize: 12,
                fontWeight: medium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationMeals extends StatefulWidget {
  final String title;
  final String mealType;
  final String? selectedDurationText;
  final bool isNotificationEnabled;

  NotificationMeals({
    Key? key,
    required this.title,
    required this.mealType,
    this.selectedDurationText,
    required this.isNotificationEnabled,
  }) : super(key: key);

  @override
  _NotificationMealsState createState() => _NotificationMealsState();
}

class _NotificationMealsState extends State<NotificationMeals> {
  bool _isSwitched = false;
  late SharedPreferences _preferences;
  late String preferencesKey;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  String? _selectedDurationText;
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    preferencesKey = 'selectedDurationText_${widget.mealType}';
    loadPreferences();
    initializeNotifications();
    _showMealNotification(selectedTime);
  }

  Future<void> loadPreferences() async {
    _preferences = await SharedPreferences.getInstance();
    setState(() {
      _selectedDurationText = _preferences.getString(preferencesKey);
      _isSwitched = _preferences.getBool(preferencesKey + '_switched') ?? false;
    });
  }

  Future<void> savePreferences() async {
    await _preferences.setString(preferencesKey, _selectedDurationText ?? '');
    await _preferences.setBool(preferencesKey + '_switched', _isSwitched);
  }

  Future<void> initializeNotifications() async {
    tz.initializeTimeZones();
    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('logo_app_diet');
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  @override
  void didUpdateWidget(NotificationMeals oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isNotificationEnabled != oldWidget.isNotificationEnabled) {
      setState(() {
        _isSwitched = widget.isNotificationEnabled && _isSwitched;
      });
    }
  }

  @override
  void dispose() {
    savePreferences();
    super.dispose();
  }

  String formatDuration(int hours, int minutes) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    return "${twoDigits(hours)}:${twoDigits(minutes)}";
  }

  Future<void> showNotification() async {
    showDialog<TimeOfDay>(
      context: context,
      builder: (BuildContext context) {
        TimeOfDay? selectedTime;
        int initialHour = DateTime.now().hour;
        int initialMinute = DateTime.now().minute;
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            height: 300,
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Pilih Durasi",
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: CupertinoPicker.builder(
                          scrollController: FixedExtentScrollController(
                            initialItem: initialHour - 1 + 24,
                          ),
                          itemExtent: 40,
                          onSelectedItemChanged: (int index) {
                            initialHour = (index % 24) + 1;
                            selectedTime = TimeOfDay(
                              hour: initialHour,
                              minute: initialMinute,
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            final hour = (index % 24) + 1;
                            return Center(
                              child: Text(
                                hour < 10 ? '0$hour' : '$hour',
                                style: blackTextStyle.copyWith(fontSize: 24),
                              ),
                            );
                          },
                        ),
                      ),
                      Expanded(
                        child: CupertinoPicker.builder(
                          scrollController: FixedExtentScrollController(
                            initialItem: initialMinute - 1,
                          ),
                          itemExtent: 40,
                          onSelectedItemChanged: (int index) {
                            initialMinute = (index % 60) + 1;
                            selectedTime = TimeOfDay(
                              hour: initialHour,
                              minute: initialMinute,
                            );
                          },
                          itemBuilder: (BuildContext context, int index) {
                            final minute = (index % 60) + 1;
                            return Center(
                              child: Text(
                                minute < 10 ? '0$minute' : '$minute',
                                style: blackTextStyle.copyWith(fontSize: 24),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: purpleTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    InkWell(
                      onTap: () {
                        if (selectedTime != null) {
                          setState(() {
                            _selectedDurationText = formatDuration(
                              selectedTime!.hour,
                              selectedTime!.minute,
                            );
                          });
                          Navigator.pop(context, selectedTime);
                        }
                      },
                      child: Text(
                        "OK",
                        style: purpleTextStyle.copyWith(
                          fontSize: 14,
                          fontWeight: medium,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    ).then((result) {
      if (result != null) {
        setState(() {
          _selectedDurationText = formatDuration(
            result.hour,
            result.minute,
          );
          selectedTime = result;
        });
        savePreferences();
        if (widget.isNotificationEnabled && _isSwitched) {
          _showMealNotification(result);
        }
      }
    });
  }

  Future<void> _showMealNotification(TimeOfDay? selectedTime) async {
    if (_selectedDurationText != null && selectedTime != null) {
      final now = tz.TZDateTime.now(tz.local);
      var scheduledDate = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      String notificationTitle = '';
      String notificationMessage = '';

      if (widget.mealType == 'sarapan') {
        notificationTitle = 'Waktunya Sarapan';
        notificationMessage = 'Ayo masukkan makanan di sarapan kamu! 🍳';
      } else if (widget.mealType == 'makan_siang') {
        notificationTitle = 'Waktunya Makan Siang';
        notificationMessage =
            'Makan Siang kamu belum ada nih! Ayo masukkan Makan Siang Kamu! 🍽️';
      } else if (widget.mealType == 'makan_malam') {
        notificationTitle = 'Waktunya Makan Malam';
        notificationMessage =
            'Dah malam nih, jangan lupa makan malam ya.. 🍲🥘';
      } else if (widget.mealType == 'snack') {
        notificationTitle = 'Yakin Gak Mau Snack';
        notificationMessage = 'Buruan masukin Snack Kamu! 🍫';
      }

      final androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'meal_channel',
        'Meal Notifications',
        importance: Importance.high,
        priority: Priority.high,
      );

      final iOSPlatformChannelSpecifics = DarwinNotificationDetails();

      final platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics,
      );

      final notificationId = widget.mealType.hashCode;

      await flutterLocalNotificationsPlugin.zonedSchedule(
        notificationId,
        notificationTitle,
        notificationMessage,
        scheduledDate,
        platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 12),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  widget.title,
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (widget.isNotificationEnabled && _isSwitched) {
                    showNotification();
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                      top: 6,
                      bottom: 6,
                    ),
                    color: (widget.isNotificationEnabled &&
                            _isSwitched &&
                            _selectedDurationText != null)
                        ? purpleColor
                        : Color(0xffb9c5ff),
                    child: Text(
                      _selectedDurationText ?? '',
                      style: whiteTextStyle.copyWith(
                        fontSize: 14,
                        fontWeight: medium,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FlutterSwitch(
                  width: 48.0,
                  height: 25.0,
                  toggleSize: 20.0,
                  value: widget.isNotificationEnabled ? _isSwitched : false,
                  borderRadius: 20.0,
                  padding: 5.0,
                  onToggle: (val) {
                    setState(() {
                      _isSwitched = val;
                      if (_isSwitched) {
                        if (widget.isNotificationEnabled) {
                          savePreferences();
                        }
                      } else {
                        if (widget.isNotificationEnabled) {
                          savePreferences();
                        }
                      }
                    });
                    if (val) {
                      if (_selectedDurationText != null &&
                          selectedTime != null) {
                        _showMealNotification(selectedTime);
                      }
                    } else {
                      if (!_isSwitched) {
                        flutterLocalNotificationsPlugin
                            .cancel(widget.mealType.hashCode);
                      }
                    }
                  },
                  activeColor: purpleColor,
                  inactiveColor: Color(0xffBAC4FF),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
