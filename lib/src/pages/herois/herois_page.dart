import 'package:flutter/material.dart';
import 'package:teste_find_solucoes/src/data/clients/dio_client.dart';
import 'package:teste_find_solucoes/src/data/models/personagem_model.dart';
import 'package:teste_find_solucoes/src/data/repositories/personagem_repository.dart';

import 'carrossel.dart';

class HeroisPage extends StatefulWidget {
  const HeroisPage({super.key});

  @override
  State<HeroisPage> createState() => _HeroisPageState();
}

class _HeroisPageState extends State<HeroisPage> {
  late PersonagemRepository personagemRepository;
  PersonagemModel personagemModel = PersonagemModel();
  int offset = 0;

  @override
  void initState() {
    personagemRepository = PersonagemRepository(dio: DioClient());
    super.initState();

    _loadData();
  }

  void _loadData() async {
    if (personagemModel.data == null) {
      personagemModel = await personagemRepository.getPersonagens(0);
    } else {
      offset = offset + personagemModel.data!.count!;
      final temp = await personagemRepository.getPersonagens(offset);
      personagemModel.data!.results!.addAll(temp.data!.results!);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: personagemModel.data != null
          ? Carrossel(personagemModel: personagemModel)
          : Center(
              child: CircularProgressIndicator.adaptive(
                backgroundColor: Color(0xFFF2264B),
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
    );
  }
}
