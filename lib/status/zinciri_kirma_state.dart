import 'package:equatable/equatable.dart';

abstract class ZincirState extends Equatable {
  const ZincirState();

  @override
  List<Object> get props => [];
}

class ZincirInitialState extends ZincirState {}

class ZincirLoadingState extends ZincirState {}

class ZincirLoadedState extends ZincirState {
  final List<Map<String, dynamic>> habitList;

  const ZincirLoadedState(this.habitList);

  @override
  List<Object> get props => [habitList];
}

class ZincirSuccessState extends ZincirState {
}

class ZincirErrorState extends ZincirState {
  final String error;

  const ZincirErrorState(this.error);

  @override
  List<Object> get props => [error];
}
