import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:teste_find_solucoes/src/data/models/personagem_model.dart';
import 'package:teste_find_solucoes/src/pages/herois/detalhes_herois.dart';
import 'package:teste_find_solucoes/src/utils/text_styles.dart';

class Carrossel extends StatelessWidget {
  final PersonagemModel personagemModel;

  Carrossel({required this.personagemModel});

  final CarouselController _ctrlCarousel = CarouselController();

  @override
  Widget build(BuildContext context) {
    final altura = MediaQuery.of(context).size.height;
    return CarouselSlider.builder(
      carouselController: _ctrlCarousel,
      options: CarouselOptions(
        height: altura * 0.55,
        enlargeCenterPage: true,
        aspectRatio: 16 / 9,
        autoPlayCurve: Curves.fastOutSlowIn,
        enableInfiniteScroll: true,
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        viewportFraction: 0.75,
      ),
      itemCount: personagemModel.data!.results!.length,
      itemBuilder: (BuildContext context, int index, int realIndex) {
        final personagem = personagemModel.data!.results![index];
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () => _onItemTap(context, index),
              child: Container(
                margin: const EdgeInsets.all(1),
                child: Card(
                  color: const Color(0xffF2264B),
                  elevation: 5.0,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Hero(
                          createRectTween: (begin, end) {
                            return MaterialRectCenterArcTween(
                              begin: Rect.fromPoints(
                                begin!.topLeft,
                                begin.bottomRight,
                              ),
                              end: Rect.fromPoints(
                                end!.topLeft,
                                end.bottomRight,
                              ),
                            );
                          },
                          tag: "heroImage$index",
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              topRight: Radius.circular(16.0),
                            ),
                            child: Image.network(
                              "${personagem.thumbnail!.path}.${personagem.thumbnail!.extension}",
                              height: altura * 0.3,
                              width: double.infinity,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(personagem.name!,
                                  style: CharacterTextStyle.nomePersonagem),
                              const SizedBox(height: 8.0),
                              Text(
                                personagem.description ??
                                    "Sem descrição disponível",
                                style: TextStyle(
                                  fontSize: (altura < 250) ? 8.0 : 16.0,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                maxLines: 2,
                              ),
                              //botao de ver mais
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: const Row(
                            children: [
                              Text("Ver mais",
                                  style: TextStyle(
                                    color: Colors.black,
                                  )),
                              SizedBox(width: 8.0),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _onItemTap(BuildContext context, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetalhesPage(
            personagemModel: personagemModel, selectedIndex: index),
      ),
    );
  }
}
