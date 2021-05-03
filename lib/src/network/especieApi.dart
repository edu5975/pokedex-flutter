import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:pokedex/src/models/especieDao.dart';

class EspecieApi {
  // ignore: non_constant_identifier_names
  String URL_POKEDEX = 'https://pokeapi.co/api/v2/pokemon-species/';
  Client http = Client();

  Future<EspecieDao> getEspecie(id) async {
    final response = await http.get(URL_POKEDEX + id + '/');
    if (response.statusCode == 200) {
      var especie = jsonDecode(response.body);
      EspecieDao especiedao = EspecieDao().fromJson(especie);
      return especiedao;
    } else {
      return null;
    }
  }
}
