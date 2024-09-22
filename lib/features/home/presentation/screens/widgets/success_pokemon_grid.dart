import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_radar/core/core.dart';
import 'package:poke_radar/features/home/domain/domain.dart';
import 'package:poke_radar/features/home/presentation/providers/providers.dart';
import 'package:poke_radar/features/shared/shared.dart';

class SuccessPokemonGrid extends ConsumerStatefulWidget {
  final Success state;

  const SuccessPokemonGrid({super.key, required this.state});

  @override
  ConsumerState<SuccessPokemonGrid> createState() => _SuccessPokemonGridState();
}

class _SuccessPokemonGridState extends ConsumerState<SuccessPokemonGrid> {
  late final ScrollController _scrollController;
  final valueNotifier = ValueNotifier<bool>(false);

  @override
  initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 30, left: 18, right: 18),
            child: GridView.builder(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 8,
                mainAxisSpacing: 9,
              ),
              itemCount: widget.state.pokemons.length,
              itemBuilder: (context, index) {
                final pokemon = widget.state.pokemons[index];
                return CustomAnimation(
                  child: _PokemonCard(pokemon: pokemon),
                );
              },
            ),
          ),
        ),
        ValueListenableBuilder<bool>(
          valueListenable: valueNotifier,
          builder: (context, isLoading, child) {
            return isLoading ? const CustomLoading() : const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  Future<void> _onScroll() async {
    if (_scrollController.position.pixels + 50 >=
            _scrollController.position.maxScrollExtent &&
        !valueNotifier.value) {
      valueNotifier.value = true;
      await ref.read(pokemonsProvider.notifier).getPokemons();
      valueNotifier.value = false;
    }
  }
}

class _PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  const _PokemonCard({
    required this.pokemon,
  });
  @override
  Widget build(BuildContext context) {
    final ImageManager img = ServiceLocator().get();
    final textStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 20,
        );

    return Card(
      color: Color(int.parse(pokemon.backGroundColor)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            left: 12,
            top: 12,
            child: img.getSvgImage(img.outlinedHeartIcon),
          ),
          Image.network(pokemon.imageUrl),
          const CustomBackground(),
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    pokemon.name,
                    style: textStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Icon(
                  Icons.arrow_circle_right_outlined,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
