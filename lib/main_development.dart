import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:my_app/core/config/app_config.dart';
import 'package:my_app/core/config/env_loader.dart';
import 'package:my_app/core/storage/local_storage.dart';
import 'package:my_app/features/maps/presentation/screen/map_screen.dart';
import 'package:my_app/firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('📩 رسالة في الخلفية: ${message.notification?.title}');
}

// إعداد الإشعارات المحلية

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await MobileAds.instance.initialize();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await EnvLoader.load();

  // تحميل AppConfig
  // final appConfig = AppConfig.load();
  // await EnvLoader.load();
  // await ServiceLocator().init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await LocalStorage.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Chat',
      debugShowCheckedModeBanner: false,
      home: UberStyleMapScreen(),
      // home: AdsScreen(),
    );
  }
}
