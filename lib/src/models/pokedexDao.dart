import 'package:basic_utils/basic_utils.dart';

class PokedexDao {
  int id;
  String name;
  String url;
  String img;

  PokedexDao({
    this.id,
    this.name,
    this.url,
    this.img,
  });

  PokedexDao fromJson(Map<String, dynamic> map) {
    var numb = int.parse(map['url'].toString().split('/')[6]);
    var dec = numb.toString().padLeft(3, '0');
    return PokedexDao(
        id: numb,
        name: StringUtils.capitalize(map['name']),
        url: map['url'],
        img:
            "https://assets.pokemon.com/assets/cms2/img/pokedex/full/${dec}.png");
  }

  @override
  String toString() {
    return "{id: " +
        id.toString() +
        " , name: " +
        name +
        " , url: " +
        url +
        " , img: " +
        img +
        " }";
  }
}
