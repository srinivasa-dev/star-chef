import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:star_chef/models/all_details_model.dart';
import 'package:star_chef/services/star_chef_service.dart';

part 'all_details_event.dart';
part 'all_details_state.dart';

class AllDetailsBloc extends Bloc<AllDetailsEvent, AllDetailsState> {
  AllDetailsBloc() : super(AllDetailsInitial()) {
    on<AllDetailsEvent>((event, emit) async {
      if(event is LoadAllDetailsBloc) {
        emit(AllDetailsLoadingState());
        try {
          var allDetailsResponse = await StarChefService().getAllDetails();
          var data = json.decode(allDetailsResponse.body);

          if(allDetailsResponse.statusCode == 200) {
            AllDetailsModel allDetails = AllDetailsModel.fromJson(data);
            emit(AllDetailsLoadedState(allDetailsModel: allDetails));
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
            emit(AllDetailsErrorState(error: allDetailsResponse.statusCode.toString()));
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
          emit(AllDetailsErrorState(error: 'Oops Something went wrong!'));
        }
      }
    });
  }
}
