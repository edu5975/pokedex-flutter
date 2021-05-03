import 'package:flutter/material.dart';
import 'package:md2_tab_indicator/md2_tab_indicator.dart';
import 'package:pokedex/src/models/especieDao.dart';
import 'package:pokedex/src/models/pokemonDao.dart';
import 'package:pokedex/src/network/especieApi.dart';
import 'package:pokedex/src/network/pokemonApi.dart';
import 'package:pokedex/src/utils/configuration.dart';
import 'package:pokedex/views/informationPokemon.dart';
import 'package:pokedex/views/spritesPokemon.dart';
import 'package:pokedex/views/statsPokemon.dart';

class PokemonScreen extends StatefulWidget {
  PokemonScreen({Key key}) : super(key: key);

  @override
  _PokemonScreenState createState() => _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  var pok;
  EspecieApi especieApi = EspecieApi();
  PokemonApi pokemonApi = PokemonApi();

  @override
  Widget build(BuildContext context) {
    pok = ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    return tabbar();
  }

  Widget tabbar() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(250),
        child: AppBar(
          backgroundColor: Colors.red,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  pok['img'],
                ),
              ),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          title: Text(pok['name']),
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: TabBar(
              controller: tabController,
              labelStyle: TextStyle(
                fontWeight: FontWeight.w700,
              ),
              indicatorSize: TabBarIndicatorSize.label,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey[300],
              isScrollable: true,
              indicator: MD2Indicator(
                indicatorColor: Configuration.colorBorders,
                indicatorHeight: 3,
                indicatorSize: MD2IndicatorSize.normal,
              ),
              tabs: <Widget>[
                Tab(
                  text: "Information",
                ),
                Tab(
                  text: "Stats",
                ),
                Tab(
                  text: "Sprites",
                ),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: <Widget>[
          acerca(),
          estadisticas(),
          sprites(),
        ],
      ),
    );
  }

  Widget acerca() {
    return FutureBuilder(
      future: pokemonApi.getEspecie(pok['id'].toString()),
      builder: (BuildContext context, AsyncSnapshot<PokemonDao> pokemon) {
        if (pokemon.hasError) {
          return Center(child: Text('${pokemon.error}'));
        } else if (pokemon.connectionState == ConnectionState.done) {
          return FutureBuilder(
            future: especieApi.getEspecie(pok['id'].toString()),
            builder: (BuildContext context, AsyncSnapshot<EspecieDao> especie) {
              if (especie.hasError) {
                return Center(child: Text('${especie.error}'));
              } else if (especie.connectionState == ConnectionState.done) {
                return InformationPokemon(
                  especie: especie.data,
                  pokemon: pokemon.data,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget estadisticas() {
    return FutureBuilder(
      future: pokemonApi.getEspecie(pok['id'].toString()),
      builder: (BuildContext context, AsyncSnapshot<PokemonDao> pokemon) {
        if (pokemon.hasError) {
          return Center(child: Text('${pokemon.error}'));
        } else if (pokemon.connectionState == ConnectionState.done) {
          return StatsPokemon(
            pokemon: pokemon.data,
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget sprites() {
    return SpritesPokemon(pokemon: pok['id']);
  }
}
