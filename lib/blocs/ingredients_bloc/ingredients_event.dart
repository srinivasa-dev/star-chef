part of 'ingredients_bloc.dart';

abstract class IngredientsEvent extends Equatable {
  const IngredientsEvent();
}

class LoadIngredientsBloc extends IngredientsEvent {
  final BuildContext context;

  const LoadIngredientsBloc({required this.context});

  @override
  List<Object?> get props => [context];
}