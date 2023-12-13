import 'package:flutter/material.dart';
import 'package:teste_find_solucoes/src/data/clients/dio_client.dart';
import 'package:teste_find_solucoes/src/data/models/personagem_model.dart';
import 'package:teste_find_solucoes/src/data/repositories/personagem_repository.dart';

class HeroisPorIDPage extends StatefulWidget {
  const HeroisPorIDPage({super.key, required this.id});

  final int id;
  @override
  State<HeroisPorIDPage> createState() => _HeroisPorIDPageState();
}

class _HeroisPorIDPageState extends State<HeroisPorIDPage> {
  late PersonagemRepository personagemRepository;
  PersonagemModel personagemModel = PersonagemModel();
  int offset = 0;
  List<Results>? personagem;

  int get id => widget.id;

  @override
  void initState() {
    personagemRepository = PersonagemRepository(dio: DioClient());
    super.initState();

    _loadData();
  }

  void _loadData() async {
    personagem = await personagemRepository.getPersonagemById(id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: personagem != null
          ? ListView.builder(
              itemCount: personagem!.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(personagem![index].name!),
                );
              },
            )
          : Center(
              child: const CircularProgressIndicator(),
            ),
    );
  }
}
