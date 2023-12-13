import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_find_solucoes/src/data/repositories/ids_service.dart';
import 'package:teste_find_solucoes/src/data/repositories/personagem_repository.dart';

import 'personagem_event.dart';
import 'personagem_state.dart';

class PersonagemBloc extends Bloc<PersonagemEvent, PersonagemState> {
  final PersonagemRepository personagemRepository;

  final IdsService idsService;

  PersonagemBloc({
    required this.personagemRepository,
    required this.idsService,
  }) : super(PersonagensLoading());

  @override
  Stream<PersonagemState> mapEventToState(PersonagemEvent event) async* {
    if (event is LoadPersonagens) {
      yield PersonagensLoading();
      try {
        final personagens = await personagemRepository
            .getPersonagens(idsService.listaIds.length);

        yield PersonagensLoaded(personagens);
      } catch (e) {
        yield PersonagensError('Erro ao carregar personagens: $e');
      }
    }
  }
}
