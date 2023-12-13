import 'package:teste_find_solucoes/src/data/models/personagem_model.dart';

import 'personagem_event.dart';

class PersonagensLoading extends PersonagemState {}

class PersonagensLoaded extends PersonagemState {
  final PersonagemModel personagens;

  PersonagensLoaded(this.personagens);

  @override
  List<Object?> get props => [personagens];
}

class PersonagensError extends PersonagemState {
  final String errorMessage;

  PersonagensError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
