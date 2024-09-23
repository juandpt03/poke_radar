import 'package:flutter/material.dart';
import 'package:poke_radar/core/core.dart';
import 'package:poke_radar/features/home/domain/domain.dart';

class StatsPanel extends StatelessWidget {
  final Pokemon pokemon;

  const StatsPanel({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [
            colors.tertiary.withOpacity(0.1),
            colors.secondary.withOpacity(0.1),
          ],
          stops: const [0.1, 0.6],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: pokemon.info!.stats.map((stat) {
          return StatBar(
              stat: stat,
              backgroundColor: Color(int.parse(pokemon.backGroundColor)));
        }).toList(),
      ),
    );
  }
}

class StatBar extends StatelessWidget {
  final Stat stat;
  final Color backgroundColor;

  const StatBar({super.key, required this.stat, required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    final Translator translator = Translator();
    return Row(
      children: [
        Expanded(
          child: Text(
            translator.translate(name: stat.name, context: context),
            style: const TextStyle(fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          stat.baseStat.toString(),
          style: TextStyle(color: backgroundColor, fontSize: 16),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: LinearProgressIndicator(
            value: stat.baseStat / 100,
            backgroundColor: Colors.grey[800],
            color: backgroundColor,
            minHeight: 12,
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ],
    );
  }
}
