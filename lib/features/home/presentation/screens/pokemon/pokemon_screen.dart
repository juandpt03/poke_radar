import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_radar/core/core.dart';
import 'package:poke_radar/features/home/presentation/providers/providers.dart';
import 'package:poke_radar/features/home/presentation/screens/pokemon/widgets/widgets.dart';

import 'package:poke_radar/features/shared/shared.dart';

class PokemonScreen extends ConsumerStatefulWidget {
  static const routeName = '/pokemon';
  const PokemonScreen({super.key});

  @override
  ConsumerState<PokemonScreen> createState() => _PokemonScreenState();
}

class _PokemonScreenState extends ConsumerState<PokemonScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(pokemonsProvider.notifier).getPokemonInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pokemon = ref.watch(pokemonsProvider);

    return Scaffold(
      appBar: const _CustomAppbar(),
      body: pokemon.map(
        loading: (_) => const CustomLoading(),
        success: (state) => SuccessPokemonInfo(
          pokemon: state.pokemon!,
        ),
        error: (state) => Center(
          child: Text(state.error.toString()),
        ),
      ),
    );
  }
}

class _CustomAppbar extends ConsumerWidget implements PreferredSizeWidget {
  const _CustomAppbar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemon = ref.watch(pokemonsProvider);
    final ImageManager img = ServiceLocator().get();
    final textStyle = Theme.of(context)
        .textTheme
        .displaySmall
        ?.copyWith(fontWeight: FontWeight.bold);
    return AppBar(
      centerTitle: true,
      title: Text(
        pokemon.map(
          loading: (_) => 'Cargando...',
          success: (state) => state.pokemon!.name,
          error: (state) => 'Error',
        ),
        style: textStyle,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: pokemon.map(
            error: (_) => img.getSvgImage(
              img.outlinedHeartIcon,
            ),
            success: (state) {
              return GestureDetector(
                onTap: () {
                  ref.read(pokemonsProvider.notifier).toggleFavoritePokemon();
                },
                child: img.getSvgImage(
                  state.pokemon!.isFavorite
                      ? img.fillHeartIcon
                      : img.outlinedHeartIcon,
                ),
              );
            },
            loading: (_) => img.getSvgImage(
              img.outlinedHeartIcon,
            ),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
