import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:star_chef/models/ingredients_model.dart';
import 'package:star_chef/services/star_chef_service.dart';

part 'ingredients_event.dart';
part 'ingredients_state.dart';

class IngredientsBloc extends Bloc<IngredientsEvent, IngredientsState> {
  IngredientsBloc() : super(IngredientsInitial()) {
    on<IngredientsEvent>((event, emit) async {
      if(event is LoadIngredientsBloc) {
        emit(IngredientsLoadingState());
        try {
          var ingredientsResponse = await StarChefService().getIngredients();
          var data = json.decode(ingredientsResponse.body);

          if(ingredientsResponse.statusCode == 200) {
            IngredientsModel ingredients = IngredientsModel.fromJson(data);
            emit(IngredientsLoadedState(ingredientsModel: ingredients));
          } else {
            ScaffoldMessenger.of(event.context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Oops Something went wrong!',
                ),
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 3),
              ),
            );
            emit(IngredientsErrorState(error: ingredientsResponse.statusCode.toString()));
          }
        } catch (_) {
          ScaffoldMessenger.of(event.context).showSnackBar(
            const SnackBar(
              content: Text(
                'Oops Something went wrong!',
              ),
              behavior: SnackBarBehavior.floating,
              duration: Duration(seconds: 3),
            ),
          );
          emit(IngredientsErrorState(error: 'Oops Something went wrong!'));
        }
      }
    });
  }
}
