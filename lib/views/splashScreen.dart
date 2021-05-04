import 'package:flutter/material.dart';
import 'package:pokedex/src/screens/pokedexScreen.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenPokedex extends StatefulWidget {
  SplashScreenPokedex({Key key}) : super(key: key);

  @override
  _SplashScreenUserState createState() => _SplashScreenUserState();
}

class _SplashScreenUserState extends State<SplashScreenPokedex> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds: PokedexScreen(),
      title: Text(
        'Welcome',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      image: Image.asset(
        "assets/pokeball.png",
      ),
      photoSize: 200,
      loaderColor: Colors.red,
      loadingText: Text("Starting Pokedex"),
    );
  }
}
