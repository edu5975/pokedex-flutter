import 'package:flutter/material.dart';
import 'package:pokedex/src/screens/dashboard.dart';
import 'package:pokedex/src/screens/pokemonScreen.dart';
import 'package:pokedex/src/screens/pokedexScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/dashboard': (BuildContext context) => Dashboard(),
        '/pokedex': (BuildContext context) => PokedexScreen(),
        '/pokemon': (BuildContext context) => PokemonScreen(),
      },
      home: PokedexScreen(),
    );
  }
}
