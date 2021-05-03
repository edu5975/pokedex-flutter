import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pokedex/src/models/pokedexDao.dart';
import 'package:pokedex/src/network/pokedexAPI.dart';
import 'package:pokedex/src/utils/configuration.dart';
import 'package:pokedex/views/cardPokemon.dart';

class PokedexScreen extends StatefulWidget {
  PokedexScreen({Key key}) : super(key: key);

  @override
  _PokedexScreenState createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  ApiPokedex apiPokedex;
  @override
  void initState() {
    super.initState();
    apiPokedex = ApiPokedex();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
        backgroundColor: Configuration.colorHeader,
      ),
      body: FutureBuilder(
        future: apiPokedex.getAllPokedex(),
        builder:
            (BuildContext context, AsyncSnapshot<List<PokedexDao>> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('${snapshot.error}'));
          } else if (snapshot.connectionState == ConnectionState.done) {
            return _listPokedex(snapshot.data);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _listPokedex(List<PokedexDao> pokedex) {
    if (pokedex != null && pokedex.length > 0) {
      return AnimationLimiter(
        child: GridView.builder(
          physics: BouncingScrollPhysics(),
          padding: EdgeInsets.all(12),
          addAutomaticKeepAlives: true,
          gridDelegate:
              new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemCount: pokedex.length,
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredGrid(
              position: index,
              columnCount: 3,
              duration: const Duration(milliseconds: 350),
              child: ScaleAnimation(
                child: GestureDetector(
                  child: CardPokemon(
                    pokemon: pokedex[index],
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      "/pokemon",
                      arguments: {
                        'id': pokedex[index].id,
                        'name': pokedex[index].name,
                        'img': pokedex[index].img,
                      },
                    );
                  },
                ),
              ),
            );
          },
        ),
      );
    } else {
      return Text('ERROR');
    }
  }
}
