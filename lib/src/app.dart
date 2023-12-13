import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_find_solucoes/src/bloc/personagem_bloc.dart';
import 'package:teste_find_solucoes/src/data/clients/dio_client.dart';
import 'package:teste_find_solucoes/src/data/repositories/ids_service.dart';
import 'package:teste_find_solucoes/src/pages/home/home_page.dart';

import 'data/repositories/personagem_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PersonagemBloc(
            personagemRepository: PersonagemRepository(dio: DioClient()),
            idsService: context.read<IdsService>(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Find Soluções',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
          useMaterial3: true,
          fontFamily: 'Poppins',
        ),
        home: Builder(
          builder: (context) {
            return const HomePage();
          },
        ),
      ),
    );
  }
}
