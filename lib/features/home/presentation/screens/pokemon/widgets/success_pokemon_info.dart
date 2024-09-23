import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:poke_radar/core/core.dart';
import 'package:poke_radar/features/home/domain/domain.dart';

import 'package:poke_radar/features/home/presentation/screens/pokemon/widgets/widgets.dart';
import 'package:poke_radar/features/shared/shared.dart';

class SuccessPokemonInfo extends StatelessWidget {
  final Pokemon pokemon;
  const SuccessPokemonInfo({
    required this.pokemon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (pokemon.info?.stats == null) {
      return const CustomLoading();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 60),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    Color(int.parse(pokemon.backGroundColor)).withOpacity(0.2),
                    Color(int.parse(pokemon.backGroundColor)).withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  stops: const [0.1, 0.5],
                ),
              ),
              child: AspectRatio(
                aspectRatio: 1.3,
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: pokemon.imageUrl,
                ),
              ),
            ),
            const SizedBox(height: 40),
            _HeightWeightInfo(pokemon: pokemon),
            const SizedBox(height: 40),
            _TabBarView(
              pokemon: pokemon,
            ),
          ],
        ),
      ),
    );
  }
}

class _TabBarView extends StatelessWidget {
  final Pokemon pokemon;
  const _TabBarView({required this.pokemon});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        );
    final colors = Theme.of(context).colorScheme;
    return AspectRatio(
      aspectRatio: 1.4,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            automaticallyImplyLeading: false,
            bottom: TabBar(
              dividerHeight: 0,
              labelStyle: textStyle,
              indicatorColor: colors.onSurface,
              unselectedLabelColor: colors.onSurface.withOpacity(0.5),
              indicatorPadding: const EdgeInsets.only(bottom: 10),
              tabs: [
                Tab(
                  text: S.of(context).estadsticas,
                ),
                Tab(
                  text: S.of(context).movimentos,
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              StatsPanel(pokemon: pokemon),
              MovesDetails(moves: pokemon.info!.moves),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeightWeightInfo extends StatelessWidget {
  final Pokemon pokemon;
  const _HeightWeightInfo({
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    final ImageManager img = ServiceLocator().get();
    final textStyle = Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        );
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Column(
            children: [
              Text(
                '${pokemon.info?.height} M',
                style: textStyle,
              ),
              Text(
                S.of(context).altura,
              ),
            ],
          ),
        ),
        img.getSvgImage(img.statIcon),
        Expanded(
          child: Column(
            children: [
              Text(
                '${pokemon.info?.weight} KG',
                style: textStyle,
              ),
              Text(
                S.of(context).peso,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
