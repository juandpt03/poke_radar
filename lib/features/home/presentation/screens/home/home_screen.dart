import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_radar/core/core.dart';

import 'package:poke_radar/features/home/presentation/providers/providers.dart';
import 'package:poke_radar/features/home/presentation/screens/home/widgets/widgets.dart';
import 'package:poke_radar/features/shared/shared.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          _CustomAvatar(),
        ],
      ),
      drawer: const CustomDrawer(),
      body: SizedBox(
        width: double.infinity,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: const Column(
            children: [
              _Title(),
              _SearchBar(),
              _PokemonGrid(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomAvatar extends ConsumerWidget {
  const _CustomAvatar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ImageManager img = ServiceLocator().get();
    final image = ref.watch(imageProvider);
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: () => ref.read(imageProvider.notifier).setImage(),
        child: FittedBox(
          fit: BoxFit.contain,
          child: CircleAvatar(
            radius: 50,
            backgroundImage: image == null
                ? AssetImage(img.avatar)
                : FileImage(
                    image,
                  ),
          ),
        ),
      ),
    );
  }
}

class _PokemonGrid extends ConsumerWidget {
  const _PokemonGrid();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pokemons = ref.watch(pokemonsProvider);

    return Expanded(
      child: pokemons.map(
        loading: (_) => const LoadingPokemonGrid(),
        success: (state) => SuccessPokemonGrid(state: state),
        error: (state) => ErrorPokemonGrid(error: state.error),
      ),
    );
  }
}

class _SearchBar extends ConsumerWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = Theme.of(context).colorScheme;
    final ImageManager img = ServiceLocator().get();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 40),
        child: SearchBar(
          onChanged: (query) {
            ref.read(pokemonsProvider.notifier).filterPokemons(query: query);
          },
          surfaceTintColor:
              isDark ? WidgetStatePropertyAll(colors.onErrorContainer) : null,
          hintStyle: const WidgetStatePropertyAll(TextStyle(fontSize: 20)),
          hintText: S.of(context).buscar,
          leading: img.getSvgImage(img.searchIcon, color: colors.onSurface),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 18),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Text(
        S.of(context).encuentraTuPokemon,
        style: textStyle.displayMedium
            ?.copyWith(fontWeight: FontWeight.bold, fontSize: 40),
      ),
    );
  }
}
