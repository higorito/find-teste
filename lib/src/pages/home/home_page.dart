import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:teste_find_solucoes/src/data/repositories/ids_service.dart';
import 'package:teste_find_solucoes/src/pages/favoritos/favoritos_page.dart';
import 'package:teste_find_solucoes/src/pages/home/widgets/busca.dart';
import 'package:teste_find_solucoes/src/pages/home/widgets/custom_drawer.dart';
import 'package:teste_find_solucoes/src/utils/text_styles.dart';
import 'package:teste_find_solucoes/src/pages/herois/herois_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  final idsService = IdsService();

  @override
  Widget build(BuildContext context) {
    // final idsService = context.read<IdsService>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2264B),
        title: const Text(
          "DESAFIO  DA  MARVEl ",
          style: CharacterTextStyle.tituloAppBar,
        ),
        leading: Builder(
          builder: (context) => InkWell(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).size.width * 0.005),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 2),
                      blurRadius: 1,
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage("assets/icons/escudo.png"),
                  radius: 15,
                ),
              ),
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: [
          Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    //botoes para mostrar popular e ordem alfabetica
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      OutlinedButton(
                        onPressed: () {},
                        style: const ButtonStyle(
                          side: MaterialStatePropertyAll(
                            BorderSide(color: Color(0xFFF2264B), width: 2.0),
                          ),
                          minimumSize: MaterialStatePropertyAll(Size(100, 50)),
                        ),
                        child: const Text(
                          "Popular",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        style: const ButtonStyle(
                          side: MaterialStatePropertyAll(
                            BorderSide(color: Color(0xFFF2264B), width: 2.0),
                          ),
                          minimumSize: MaterialStatePropertyAll(Size(100, 50)),
                        ),
                        child: const Text(
                          "A-Z",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Text(
                "Personagens",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.start,
              ),
              const Expanded(
                flex: 5,
                child: HeroisPage(),
              ),
            ],
          ),
          const FavoritosPage(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: const Color(0xFFF2264B),
              iconSize: 28,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.favorite,
                  text: 'Favoritos',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                  _pageController.animateToPage(index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
