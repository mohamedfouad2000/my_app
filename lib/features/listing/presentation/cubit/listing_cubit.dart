import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_app/core/usecase/usecase.dart';
import 'package:my_app/core/utils/hanlders/api_error_model.dart';
import 'package:my_app/core/utils/service_locator.dart';
import 'package:my_app/features/listing/data/models/nex_media_model.dart';
import 'package:my_app/features/listing/domain/use_cases/get_all_nex_use_case.dart';

part 'listing_state.dart';

class ListingCubit extends Cubit<ListingState> {
  ListingCubit() : super(ListingInitial());
  List<NexMediaModel> allNexList = [];
  void getAllNex() async {
    emit(GetAllNexLoadingState());
    final result = await sl<GetAllNexUseCase>()(NoParams());
    result.fold(
      (l) {
        emit(GetAllNexErrorState(apiErrorModel: l.error));
      },
      (r) {
        allNexList = r;

        emit(GetAllNexSuccessState());
      },
    );
  }
}
