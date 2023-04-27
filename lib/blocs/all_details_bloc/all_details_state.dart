// ignore_for_file: must_be_immutable

part of 'all_details_bloc.dart';

abstract class AllDetailsState extends Equatable {
  const AllDetailsState();
}

class AllDetailsInitial extends AllDetailsState {
  @override
  List<Object> get props => [];
}

class AllDetailsLoadingState extends AllDetailsState {
  @override
  List<Object> get props => [];
}

class AllDetailsLoadedState extends AllDetailsState {
  AllDetailsModel allDetailsModel;

  AllDetailsLoadedState({required this.allDetailsModel});

  @override
  List<Object?> get props => [AllDetailsModel];

}

class AllDetailsErrorState extends AllDetailsState {

  String error;
  AllDetailsErrorState({required this.error});

  @override
  List<Object?> get props => [error];

}