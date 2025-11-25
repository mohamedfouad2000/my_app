part of 'listing_cubit.dart';

sealed class ListingState extends Equatable {
  const ListingState();

  @override
  List<Object> get props => [];
}

final class ListingInitial extends ListingState {}

final class GetAllNexLoadingState extends ListingState {}

final class GetAllNexErrorState extends ListingState {
  final ApiErrorModel apiErrorModel;

  const GetAllNexErrorState({required this.apiErrorModel});
}

final class GetAllNexSuccessState extends ListingState {}
