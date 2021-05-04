import 'package:flutter/material.dart';
import 'package:pokedex/src/screens/pokemonScreen.dart';
import 'package:pokedex/src/screens/pokedexScreen.dart';
import 'package:pokedex/views/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/pokedex': (BuildContext context) => PokedexScreen(),
        '/pokemon': (BuildContext context) => PokemonScreen(),
      },
      home: SplashScreenPokedex(),
    );
  }
}
