import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/core/utils/service_locator.dart';
import 'package:my_app/features/auth/presenation/cubit/auth_cubit.dart';
import 'package:my_app/features/listing/presentation/cubit/listing_cubit.dart';
import 'package:my_app/features/splach/presentation/splach_screen.dart';

import '../core/theme/app_theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  String? fcmToken = '';

  @override
  void initState() {
    super.initState();
    setupFirebaseMessaging();
  }

  Future<void> setupFirebaseMessaging() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    // 🔒 طلب إذن استقبال الإشعارات (مهم في iOS)
    await messaging.requestPermission();

    // 🔑 الحصول على التوكن
    fcmToken = await messaging.getToken();
    print('✅ FCM Token: $fcmToken');

    // 📱 التطبيق مفتوح (Foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('🔥 [Foreground] عنوان: ${message.notification?.title}');
      print('📝 المحتوى: ${message.notification?.body}');
    });

    // 🚀 لما المستخدم يضغط على الإشعار ويفتح التطبيق
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print(
          '🚀 [Opened] تم فتح التطبيق من إشعار: ${message.notification?.title}');
    });

    // 🟢 لما التطبيق كان مقفول واتفتح من إشعار
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      print(
          '🟢 [Terminated] تم فتح التطبيق من إشعار: ${initialMessage.notification?.title}');
    }

    setState(() {}); // عشان نعرض التوكن على الشاشة
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(393, 852),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ListingCubit()..getAllNex(),
              ),
              BlocProvider(
                lazy: false,
                create: (context) => AuthCubit(sl()),
              ),
            ],
            child: MaterialApp(
              title: 'My App',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light(),
              darkTheme: AppTheme.dark(),
              themeMode: ThemeMode.system,
              home: SplachScreen(),
              // ListingScreen(),
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en'),
                Locale('hi'),
              ],
            ),
          );
        });
  }
}
