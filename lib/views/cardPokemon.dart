import 'package:flutter/material.dart';
import 'package:pokedex/src/models/pokedexDao.dart';

class CardPokemon extends StatelessWidget {
  const CardPokemon({
    Key key,
    @required this.pokemon,
  }) : super(key: key);

  final PokedexDao pokemon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(3),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  pokemon.id.toString(),
                  style: TextStyle(
                    fontFamily: 'Google',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                  backgroundColor: Colors.grey[350],
                  radius: 35,
                  backgroundImage: NetworkImage(pokemon.img),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                pokemon.name,
                style: TextStyle(
                  fontFamily: 'Google',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
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
      ),
    );
  }
}
