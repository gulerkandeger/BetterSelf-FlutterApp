import 'package:equatable/equatable.dart';

abstract class GunlukHedefState extends Equatable {
  const GunlukHedefState();

  @override
  List<Object> get props => [];
}

class GunlukHedefInitialState extends GunlukHedefState {}

class GunlukHedefLoadingState extends GunlukHedefState {}

class GunlukHedefLoadedState extends GunlukHedefState {
  final List<Map<String, dynamic>> gorevList;

  const GunlukHedefLoadedState(this.gorevList);

  @override
  List<Object> get props => [gorevList];
}

class GunlukHedefSuccessState extends GunlukHedefState {

}

class GunlukHedefErrorState extends GunlukHedefState {
  final String error;

  const GunlukHedefErrorState(this.error);

  @override
  List<Object> get props => [error];
}

