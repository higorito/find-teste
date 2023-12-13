import 'package:flutter/material.dart';
import 'package:teste_find_solucoes/src/data/models/personagem_model.dart';
import 'package:teste_find_solucoes/src/pages/herois/widgets/listar_icon.dart';
import 'package:teste_find_solucoes/src/utils/text_styles.dart';

class DetalhesPage extends StatelessWidget {
  final PersonagemModel personagemModel;
  final int selectedIndex;

  const DetalhesPage(
      {super.key, required this.personagemModel, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final personagem = personagemModel.data!.results![selectedIndex];
    final altura = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Escolha um personagem",
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        height: double.infinity,
        // decoration: const BoxDecoration(
        //   color: Color(0xffF2264B),
        // ),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(32.0),
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        personagem.name ?? "Sem nome",
                        style: const TextStyle(
                          fontSize: 44.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Marvel",
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.fromLTRB(48, 40, 48, 40),
                      margin: const EdgeInsets.only(top: 16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 5.0,
                            spreadRadius: 2.0,
                          ),
                        ],
                      ),
                      child: Hero(
                        tag: "heroImage$selectedIndex",
                        child: Image.network(
                          "${personagem.thumbnail!.path}.${personagem.thumbnail!.extension}",
                          height: altura * 0.35,
                          width: double.infinity,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: ShapeDecoration(
                  color: Colors.grey[200]!,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32.0),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${personagem.name} - ID: ${personagem.id} ",
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      personagem.description ?? "Sem descrição disponível",
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      "Informações",
                      style: CharacterTextStyle.detalhePersonagem,
                    ),
                    const SizedBox(height: 16.0),
                    ListaCategoria(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
