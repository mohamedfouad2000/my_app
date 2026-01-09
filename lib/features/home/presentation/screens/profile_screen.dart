import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/features/auth/data/models/user.dart';
import 'package:my_app/features/auth/presenation/cubit/auth_cubit.dart';
import 'package:my_app/features/auth/presenation/screens/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  final AppUser user;

  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            child: Text(
              user.fullName != null && user.fullName!.isNotEmpty
                  ? user.fullName![0].toUpperCase()
                  : '?',
              style: const TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            user.fullName ?? 'No Name',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 10),
          Text(
            user.email ?? 'No Email',
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 30),
          BlocConsumer<AuthCubit, AuthState>(
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () async {
                  await context.read<AuthCubit>().logout();
                },
                child: const Text('Log Out'),
              );
            },
            listener: (BuildContext context, AuthState state) {
              if (state.isLoggedOut) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
