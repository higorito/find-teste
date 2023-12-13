import 'package:flutter/material.dart';
import 'package:teste_find_solucoes/src/data/clients/dio_client.dart';
import 'package:teste_find_solucoes/src/data/models/personagem_model.dart';
import 'package:teste_find_solucoes/src/data/repositories/personagem_repository.dart';
import 'package:teste_find_solucoes/src/pages/herois/detalhes_herois.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _idController = TextEditingController();
  PersonagemRepository personagemRepository =
      PersonagemRepository(dio: DioClient());

  PersonagemModel personagem = PersonagemModel();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesquisa de Heróis'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _idController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'ID do Herói',
                hintText: 'Ex: 1011176',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  borderSide: const BorderSide(
                    color: Color(0xFFF2264B),
                  ),
                ),
                labelStyle: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                const Color(0xFFF2264B),
              )),
              onPressed: () {
                setState(() {
                  _isLoading = true;
                });
                _searchPersonagemById();
                // await Future.delayed(const Duration(seconds: 2));
              },
              child: const Text(
                'Pesquisar',
                style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16.0),
            _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                    color: Color(0xFFF2264B),
                  ))
                : personagem.data == null
                    ? Container()
                    : Expanded(
                        child: ListView.builder(
                          itemCount: personagem.data!.results!.length,
                          itemBuilder: (context, index) {
                            final perso = personagem.data!.results![index];
                            return Container(
                              margin: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                color: const Color(0xffF2264B).withOpacity(0.5),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: ListTile(
                                leading: Image.network(
                                  "${personagem.data!.results![index].thumbnail!.path}.${personagem.data!.results![index].thumbnail!.extension}",
                                  height: 50.0,
                                ),
                                title: Text(
                                    personagem.data!.results![index].name!),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetalhesPage(
                                        personagemModel: personagem,
                                        selectedIndex: index,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }

  void _searchPersonagemById() async {
    int id = int.tryParse(_idController.text) ?? 0;
    if (id > 0) {
      PersonagemModel personagemBuscado =
          await personagemRepository.getPersoByIDUnico(id);
      if (personagem != null) {
        setState(() {
          personagem = personagemBuscado;
          _isLoading = false;
        });
      } else {
        //tratar caso em que nenhum herói foi encontrado pelo ID
        setState(() {
          personagem = PersonagemModel();
        });
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Herói não encontrado'),
              content: Text('Nenhum herói encontrado para o ID fornecido.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }
}
