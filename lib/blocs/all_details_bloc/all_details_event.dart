part of 'all_details_bloc.dart';

abstract class AllDetailsEvent extends Equatable {
  const AllDetailsEvent();
}

class LoadAllDetailsBloc extends AllDetailsEvent {
  final BuildContext context;

  const LoadAllDetailsBloc({required this.context});

  @override
  List<Object?> get props => [context];
}