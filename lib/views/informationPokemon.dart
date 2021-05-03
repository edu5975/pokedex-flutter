import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/src/models/especieDao.dart';
import 'package:pokedex/src/models/pokemonDao.dart';

class InformationPokemon extends StatefulWidget {
  InformationPokemon({
    Key key,
    @required this.pokemon,
    @required this.especie,
  }) : super(key: key);

  final PokemonDao pokemon;
  final EspecieDao especie;

  @override
  _InformationPokemonState createState() =>
      _InformationPokemonState(especie: especie, pokemon: pokemon);
}

class _InformationPokemonState extends State<InformationPokemon> {
  _InformationPokemonState({
    @required this.pokemon,
    @required this.especie,
  });
  final PokemonDao pokemon;
  final EspecieDao especie;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            acercaTipos(),
            acercaInformation(),
          ],
        ),
      ),
    );
  }

  Widget acercaTipos() {
    var types = pokemon.types.length;
    double width = MediaQuery.of(context).size.width - 80;
    double height = 40;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Container(
            height: height,
            width: types > 1 ? width / 2 : width,
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                pokemon.types[0].type.name,
                style: TextStyle(
                  fontFamily: 'Google',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
          ),
        ),
        (types > 1
            ? Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: height,
                  width: width / 2,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      pokemon.types[1].type.name,
                      style: TextStyle(
                        fontFamily: 'Google',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
              )
            : SizedBox(width: 0, height: 0))
      ],
    );
  }

  Widget acercaInformation() {
    return Column(
      children: [
        Text(
          "No. Pokedex #" + pokemon.id.toString(),
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Description",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          especie.flavorTextEntries
              .where((item) => item.language.name == 'en')
              .first
              .flavorText,
          style: TextStyle(
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Weight",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          pokemon.weight.toString() + "cm",
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Height",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          pokemon.height.toString() + "kg",
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Color",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          StringUtils.capitalize(especie.color.name),
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Shape",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          StringUtils.capitalize(especie.shape.name),
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Grow rate",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          StringUtils.capitalize(especie.growthRate.name),
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
