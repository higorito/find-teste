import 'package:equatable/equatable.dart';

abstract class PersonagemEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadPersonagens extends PersonagemEvent {}

// States
abstract class PersonagemState extends Equatable {
  @override
  List<Object?> get props => [];
}
