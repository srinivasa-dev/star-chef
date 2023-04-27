// ignore_for_file: must_be_immutable

part of 'ingredients_bloc.dart';

abstract class IngredientsState extends Equatable {
  const IngredientsState();
}

class IngredientsInitial extends IngredientsState {
  @override
  List<Object> get props => [];
}

class IngredientsLoadingState extends IngredientsState {
  @override
  List<Object> get props => [];
}

class IngredientsLoadedState extends IngredientsState {
  IngredientsModel ingredientsModel;

  IngredientsLoadedState({required this.ingredientsModel});

  @override
  List<Object?> get props => [IngredientsState];

}

class IngredientsErrorState extends IngredientsState {

  String error;
  IngredientsErrorState({required this.error});

  @override
  List<Object?> get props => [error];

}
