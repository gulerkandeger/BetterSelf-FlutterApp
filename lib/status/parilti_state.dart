import 'package:equatable/equatable.dart';

abstract class PariltiState extends Equatable {
  const PariltiState();

  @override
  List<Object> get props => [];
}

class PariltiInitialState extends PariltiState {}

class PariltiLoadingState extends PariltiState {}

class PariltiLoadedState extends PariltiState {
  final List<Map<String, dynamic>> challengeList;

  const PariltiLoadedState(this.challengeList);

  @override
  List<Object> get props => [challengeList];
}

class PariltiSuccessState extends PariltiState {
}

class PariltiErrorState extends PariltiState {
  final String error;

  const PariltiErrorState(this.error);

  @override
  List<Object> get props => [error];
}

