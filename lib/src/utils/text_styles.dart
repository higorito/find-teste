import 'package:flutter/material.dart';

abstract class CharacterTextStyle {
  static const nomePersonagem = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const estadoPersonagem = TextStyle(
    fontSize: 14.0,
    color: Color.fromARGB(255, 62, 61, 129),
  );

  static const detalhePersonagem = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.w700,
    color: Colors.black,
  );

  static const informationTitleRow = TextStyle(
    fontSize: 18.0,
    color: Color.fromARGB(255, 62, 61, 129),
  );

  static const informationTextRow = TextStyle(
    fontSize: 18.0,
    color: Color.fromARGB(255, 62, 61, 129),
  );

  static const tituloAppBar = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    fontFamily: "Marvel",
    letterSpacing: 2,
    color: Colors.white,
  );
}
