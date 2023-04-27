part of 'ingredients_bloc.dart';

abstract class IngredientsState extends Equatable {
  const IngredientsState();
}

class IngredientsInitial extends IngredientsState {
  @override
  List<Object> get props => [];
}
