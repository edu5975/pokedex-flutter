import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SpritesPokemon extends StatelessWidget {
  const SpritesPokemon({
    Key key,
    @required this.pokemon,
  }) : super(key: key);
  final int pokemon;

  @override
  Widget build(BuildContext context) {
    var id = pokemon.toString();
    String frontNormal =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${id}.png';
    String backNormal =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/${id}.png';
    String frontShiny =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/${id}.png';
    String backShiny =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/${id}.png';
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(10),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        sprite(frontNormal, "Front Normal"),
        sprite(backNormal, "Back Normal"),
        sprite(frontShiny, "Front Shiny"),
        sprite(backShiny, "Back Shiny"),
      ],
    );
  }

  Widget sprite(String img, String msg) {
    return Container(
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: CircleAvatar(
              backgroundColor: Colors.red,
              radius: 250,
              backgroundImage: NetworkImage(img),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                msg,
                style: TextStyle(
                  fontFamily: 'Google',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
    );
  }
}
