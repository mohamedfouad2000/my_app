import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/core/constants/app_constants.dart';
import 'package:my_app/core/storage/secure_storage.dart';
import 'package:my_app/core/utils/service_locator.dart';
import 'package:my_app/features/home/presentation/cubit/user_cubit.dart';
import 'package:my_app/features/home/presentation/screens/chat_one_to_one.dart';
import 'package:my_app/features/home/presentation/widget/search_bar_widget.dart';

class ListUserChatScreen extends StatefulWidget {
  const ListUserChatScreen({super.key});

  @override
  State<ListUserChatScreen> createState() => _ListUserChatScreenState();
}

class _ListUserChatScreenState extends State<ListUserChatScreen> {
  bool showSearch = false;
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: showSearch ? null : const Text('Users'),
        actions: [
          IconButton(
            icon: Icon(showSearch ? Icons.close : Icons.search),
            onPressed: () {
              setState(() {
                showSearch = !showSearch;
                searchText = '';
              });
            },
          ),
        ],
        bottom: showSearch
            ? PreferredSize(
                preferredSize: const Size.fromHeight(60),
                child: SearchBarWidget(
                  visible: showSearch,
                  onChanged: (value) {
                    searchText = value.toLowerCase();

                    context.read<UserCubit>().getUsers(
                          query: searchText,
                        );
                  },
                ),
              )
            : null,
      ),
      body: BlocBuilder<UserCubit, UserStates>(
        buildWhen: (previous, current) {
          return previous.status != current.status ||
              previous.users != current.users;
        },
        builder: (context, state) {
          switch (state.status) {
            case UserState.loading:
              return const Center(child: CircularProgressIndicator());

            case UserState.userLoaded || UserState.changeIndex:
              return FutureBuilder<String?>(
                future: sl<SecureStorage>().read(AppConstants.keyUserId),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final myId = snapshot.data ?? '';

                  final filteredUsers = (state.users ?? [])
                      .where((user) => user.uid != myId)
                      .toList();

                  if (filteredUsers.isEmpty) {
                    return const Center(
                      child: Text('لا يوجد مستخدمين آخرين'),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      final user = filteredUsers[index];
                      return GestureDetector(
                        onLongPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChatOneToOne(
                                otherName: user.fullName ?? user.email ?? '',
                                otherUid: user.uid,
                                uId: myId,
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          title: Text(user.fullName ?? ''),
                          subtitle: Text(user.email ?? ''),
                        ),
                      );
                    },
                  );
                },
              );

            case UserState.error:
              return Center(child: Text(state.message ?? 'An error occurred'));

            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
