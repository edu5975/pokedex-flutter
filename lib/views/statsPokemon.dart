import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/src/models/pokemonDao.dart';

class StatsPokemon extends StatefulWidget {
  const StatsPokemon({
    Key key,
    @required this.pokemon,
  }) : super(key: key);
  final PokemonDao pokemon;

  @override
  _StatsPokemonState createState() => _StatsPokemonState(pokemon: pokemon);
}

class _StatsPokemonState extends State<StatsPokemon> {
  _StatsPokemonState({
    @required this.pokemon,
  });
  final PokemonDao pokemon;

  final Color barBackgroundColor = const Color(0xff72d8bf);
  final Duration animDuration = const Duration(milliseconds: 250);

  int touchedIndex;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: AspectRatio(
        aspectRatio: 1,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          color: const Color(0xff81e5cd),
          child: Stack(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: BarChart(
                          mainBarData(),
                          swapAnimationDuration: animDuration,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.red] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 120,
            colors: [barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups() => List.generate(7, (i) {
        var total = 0;
        for (var t in pokemon.stats) {
          total += t.baseStat;
        }
        switch (i) {
          case 0:
            return makeGroupData(0, pokemon.stats[0].baseStat.toDouble(),
                isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, pokemon.stats[1].baseStat.toDouble(),
                isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, pokemon.stats[2].baseStat.toDouble(),
                isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, pokemon.stats[3].baseStat.toDouble(),
                isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, pokemon.stats[4].baseStat.toDouble(),
                isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, pokemon.stats[5].baseStat.toDouble(),
                isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, total.toDouble() / 6,
                isTouched: i == touchedIndex);
          default:
            return null;
        }
      });

  BarChartData mainBarData() {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String stat;
              switch (group.x.toInt()) {
                case 0:
                  stat = 'HP';
                  break;
                case 1:
                  stat = 'Attack';
                  break;
                case 2:
                  stat = 'Defense';
                  break;
                case 3:
                  stat = 'Special Attack';
                  break;
                case 4:
                  stat = 'Special Defense';
                  break;
                case 5:
                  stat = 'Speed';
                  break;
                case 6:
                  stat = 'Total';
                  break;
              }
              return BarTooltipItem(
                stat + '\n',
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (groupIndex != 6)
                        ? (rod.y - 1).toString()
                        : ((rod.y - 1) * 6).toString(),
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! PointerUpEvent &&
                barTouchResponse.touchInput is! PointerExitEvent) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'HP';
              case 1:
                return 'A';
              case 2:
                return 'D';
              case 3:
                return 'SA';
              case 4:
                return 'SD';
              case 5:
                return 'S';
              case 6:
                return 'T';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(),
    );
  }
}
