import 'package:flutter/material.dart';
import 'package:teste_find_solucoes/src/data/clients/dio_client.dart';
import 'package:teste_find_solucoes/src/data/models/personagem_model.dart';
import 'package:teste_find_solucoes/src/data/repositories/ids_service.dart';
import 'package:teste_find_solucoes/src/data/repositories/personagem_repository.dart';
import 'package:teste_find_solucoes/src/pages/herois/detalhes_herois.dart';

class FavoritosPage extends StatefulWidget {
  const FavoritosPage({
    Key? key,
  }) : super(key: key);

  @override
  State<FavoritosPage> createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  PersonagemRepository personagemRepository =
      PersonagemRepository(dio: DioClient());

  List<PersonagemModel> personagensFavoritos = [];

  List<int> listaIds = IdsService().listaIds;

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPersonagensFavoritos();
  }

  Future<void> _loadPersonagensFavoritos() async {
    try {
      List<PersonagemModel> personagens = [];
      for (int id in listaIds) {
        PersonagemModel personagem =
            await personagemRepository.getPersoByIDUnico(id);
        personagens.add(personagem);
      }

      setState(() {
        personagensFavoritos = personagens;
        _isLoading = false;
      });
    } catch (e) {
      print('Erro ao carregar personagens favoritos: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final altura = MediaQuery.of(context).size.height;
    return (_isLoading)
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            child: ListView.builder(
              itemCount: listaIds.length,
              itemBuilder: (context, index) {
                if (index < personagensFavoritos.length) {
                  final personagem = personagensFavoritos[index];
                  return Container(
                    height: altura * 0.1,
                    margin: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: const Color(0xffF2264B).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetalhesPage(
                              personagemModel: personagem,
                              selectedIndex: 0,
                            ),
                          ),
                        );
                      },
                      leading: Image.network(
                        "${personagem.data!.results![0].thumbnail!.path}.${personagem.data!.results![0].thumbnail!.extension}",
                        height: 80,
                      ),
                      title: Text(
                          "Personagem: ${personagem.data!.results![0].name ?? 'Nome não disponível'}"),
                    ),
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          );
  }
}
