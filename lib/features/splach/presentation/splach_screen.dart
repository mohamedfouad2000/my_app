import 'package:flutter/material.dart';
import 'package:my_app/core/utils/service_locator.dart';
import 'package:my_app/features/auth/data/data_source/local_data_source.dart';
import 'package:my_app/features/auth/presenation/screens/login_screen.dart';
import 'package:my_app/features/home/presentation/screens/chat_home_screen.dart';

class SplachScreen extends StatefulWidget {
  const SplachScreen({super.key});

  @override
  State<SplachScreen> createState() => _SplachScreenState();
}

class _SplachScreenState extends State<SplachScreen> {
  @override
  @override
  void initState() {
    super.initState();

    final localDataSource = sl<AuthLocalDataSource>();

    Future.delayed(const Duration(seconds: 2), () async {
      final cachedUser = await localDataSource.getCachedUser();

      if (cachedUser != null) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ChatHomeScreen(
                      user: cachedUser,
                    )));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Spalch Screen',
            style: Theme.of(context).textTheme.headlineLarge),
      ),
    );
  }
}
