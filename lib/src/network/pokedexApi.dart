import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:pokedex/src/models/pokedexDao.dart';

class ApiPokedex {
  // ignore: non_constant_identifier_names
  final String URL_POKEDEX =
      "https://pokeapi.co/api/v2/pokemon/?offset=0&limit=50";
  Client http = Client();

  Future<List<PokedexDao>> getAllPokedex() async {
    final response = await http.get(URL_POKEDEX);
    if (response.statusCode == 200) {
      var pokedex = jsonDecode(response.body)['results'] as List;
      List<PokedexDao> listPokedex = List();
      for (var pokemon in pokedex) {
        listPokedex.add(PokedexDao().fromJson(pokemon));
      }
      return listPokedex;
    } else {
      return null;
    }
  }
}
