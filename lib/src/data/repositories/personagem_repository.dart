import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:teste_find_solucoes/src/data/clients/dio_client.dart';

import 'package:teste_find_solucoes/src/data/models/personagem_model.dart';

import '../clients/exceptions.dart';
import '../clients/http_client.dart';

abstract class IPersonagemRepository {
  Future<PersonagemModel> getPersonagens(int offset);

  Future<List<Results>> getPersonagemById(int id);

  Future<PersonagemModel> getPersoByIDUnico(int id);
}

class PersonagemRepository implements IPersonagemRepository {
  // final IHttpClient httpClient;
  final DioClient dio;

  final API_KEY = dotenv.get("MARVELPUBLICKEY");
  final PRIVATE_KEY = dotenv.get("MARVELPRIVATEKEY");

  final timestamp = DateTime.now().millisecondsSinceEpoch.toString();

  PersonagemRepository({required this.dio});

  String _generateHash() {
    final stringToHash = '$timestamp$PRIVATE_KEY$API_KEY';
    final hash = md5.convert(utf8.encode(stringToHash)).toString();
    return hash;
  }

  @override
  Future<PersonagemModel> getPersonagens(int offset) async {
    final hash = _generateHash();
    final url =
        'https://gateway.marvel.com/v1/public/characters?offset=$offset&ts=$timestamp&apikey=$API_KEY&hash=$hash';

    final resposta = await dio.get(url);

    if (resposta.statusCode == 200) {
      final personagens = PersonagemModel.fromJson(resposta.data);

      return personagens;
    } else if (resposta.statusCode == 404) {
      throw NotFoundException('URL não é válida');
    }
    //tratando o erro de autenticação
    else if (resposta.statusCode == 401) {
      throw UnauthorizedException('Não autorizado');
    } else {
      throw Exception('Erro ao buscar personagens');
    }
  }

  @override
  Future<List<Results>> getPersonagemById(int id) async {
    final hash = _generateHash();
    final url =
        'https://gateway.marvel.com/v1/public/characters/$id?ts=$timestamp&apikey=$API_KEY&hash=$hash';

    final resposta = await dio.get(url);

    if (resposta.statusCode == 200) {
      final personagem = PersonagemModel.fromJson(resposta.data);

      final personagemData = personagem.data!.results!.map((e) => e).toList();

      return personagemData;
    } else if (resposta.statusCode == 404) {
      throw NotFoundException('URL não é válida');
    }
    //tratando o erro de autenticação
    else if (resposta.statusCode == 401) {
      throw UnauthorizedException('Não autorizado');
    } else {
      throw Exception('Erro ao buscar personagem');
    }
  }

  @override
  Future<PersonagemModel> getPersoByIDUnico(int id) async {
    final hash = _generateHash();
    final url =
        'https://gateway.marvel.com/v1/public/characters/$id?ts=$timestamp&apikey=$API_KEY&hash=$hash';

    final resposta = await dio.get(url);

    if (resposta.statusCode == 200) {
      final personagens = PersonagemModel.fromJson(resposta.data);

      return personagens;
    } else if (resposta.statusCode == 404) {
      throw NotFoundException('URL não é válida');
    }
    //tratando o erro de autenticação
    else if (resposta.statusCode == 401) {
      throw UnauthorizedException('Não autorizado');
    } else {
      throw Exception('Erro ao buscar personagem');
    }
  }
}
