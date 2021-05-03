import 'dart:convert';

import 'package:http/http.dart';
import 'package:pokedex/src/models/pokemonDao.dart';

class PokemonApi {
  // ignore: non_constant_identifier_names
  String URL_POKEDEX = 'https://pokeapi.co/api/v2/pokemon/';

  Client http = Client();

  Future<PokemonDao> getEspecie(id) async {
    final response = await http.get(URL_POKEDEX + id + '/');
    if (response.statusCode == 200) {
      var esp = jsonDecode(response.body);
      PokemonDao pokemon = PokemonDao().fromJson(esp);
      return pokemon;
    } else {
      return null;
    }
  }
}
