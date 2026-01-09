import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/utils/service_locator.dart';
import 'package:my_app/features/auth/data/models/user.dart';
import 'package:my_app/features/home/presentation/cubit/user_cubit.dart';
import 'package:my_app/features/home/presentation/screens/list_user_chat_screen.dart';
import 'package:my_app/features/home/presentation/screens/profile_screen.dart';

class ChatHomeScreen extends StatefulWidget {
  final AppUser user;
  const ChatHomeScreen({super.key, required this.user});

  @override
  State<ChatHomeScreen> createState() => _ChatHomeScreenState();
}

class _ChatHomeScreenState extends State<ChatHomeScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    context.read<UserCubit>().close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(sl())..getUsers(),
      child: BlocBuilder<UserCubit, UserStates>(
        builder: (context, state) {
          final userCubit = context.read<UserCubit>();
          final screens = [
            const ListUserChatScreen(),
            ProfileScreen(
              user: widget.user,
            ),
          ];

          return Scaffold(
            body: screens[userCubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: userCubit.currentIndex,
              onTap: (index) => userCubit.changeTab(index),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble),
                  label: 'Chat',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
