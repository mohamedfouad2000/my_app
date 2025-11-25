import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/features/listing/presentation/cubit/listing_cubit.dart';

class ListingScreen extends StatelessWidget {
  const ListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listing Screen'),
      ),
      body: BlocBuilder<ListingCubit, ListingState>(builder: (context, state) {
        if (state is GetAllNexLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetAllNexErrorState) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<ListingCubit>().getAllNex();
            },
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              clipBehavior: Clip.none,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.all(16),
              children: [
                (0.5.sh -
                        (MediaQuery.of(context).padding.top +
                            kToolbarHeight +
                            kToolbarHeight +
                            32))
                    .verticalSpace,
                Icon(
                  state.apiErrorModel.icon,
                  size: 64,
                  color: Colors.red,
                ),
                const SizedBox(
                  height: 16,
                  width: double.infinity,
                ),
                Text(
                  state.apiErrorModel.message,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
              ],
            ),
          );
        }
        final allNexList = context.read<ListingCubit>().allNexList;
        return ListView.builder(
          itemCount: allNexList.length,
          itemBuilder: (context, index) {
            final nexItem = allNexList[index];
            return ListTile(
              title: Text(nexItem.title ?? 'No Title'),
              subtitle: Text(nexItem.title ?? 'No Description'),
            );
          },
        );
      }),
    );
  }
}
