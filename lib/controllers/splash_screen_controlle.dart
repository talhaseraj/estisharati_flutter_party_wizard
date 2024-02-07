import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constants/constants.dart';
import '../constants/storeage_constants.dart';
import '../models/user_profile_response_model.dart';
import '../screens/home_tab_screens/home_tab_screen.dart';
import '../screens/onboarding_screens/onboarding_screen.dart';
import '../services/auth_services.dart';

class SplashScreenController extends GetxController {
  final box = GetStorage();
  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title// description
    importance: Importance.high,
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  @override
  void onInit() {
    initialize();
    super.onInit();
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    await Firebase.initializeApp();
    print('Handling a background message ${message.messageId}');
  }

  initialize() async {
    try {
      final notificationSettings =
          await FirebaseMessaging.instance.requestPermission(provisional: true);
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      print(await FirebaseMessaging.instance.getToken());
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print('Got a message whilst in the foreground!');
        print('Message data: ${message.data}');

        if (message.notification != null) {
          print(
              'Message also contained a notification: ${message.notification}');
        }
      });
      //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }

    String? token = box.read(Constants.accessToken);
    try {
      final stringResponse = await AuthServices.getUserProfile(token: token);
      final res = userProfileResponseFromJson(stringResponse);

      if (res.status == 200) {
        box.write(StorageConstants.userProfile, stringResponse);

        Get.offAll(() => HomeTabScreen());
      }
    } catch (e) {
      box.remove(Constants.accessToken);
      Get.off(() => const OnBoardingScreen());
    }
  }
}
