import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'ingredients_event.dart';
part 'ingredients_state.dart';

class IngredientsBloc extends Bloc<IngredientsEvent, IngredientsState> {
  IngredientsBloc() : super(IngredientsInitial()) {
    on<IngredientsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
