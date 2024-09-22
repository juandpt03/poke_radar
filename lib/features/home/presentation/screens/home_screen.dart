import 'package:flutter/material.dart';
import 'package:poke_radar/core/core.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ImageManager img = ServiceLocator().get();
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundImage: AssetImage(img.avatar),
            ),
          ),
        ],
      ),
      drawer: const Drawer(),
      body: const SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            _Title(),
            _SearchBar(),
            _PokemonList(),
          ],
        ),
      ),
    );
  }
}

class _PokemonList extends StatelessWidget {
  const _PokemonList();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 32, left: 18, right: 18),
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 8,
            mainAxisSpacing: 9,
          ),
          itemCount: 10,
          itemBuilder: (context, index) {
            return const _PokemonCard();
          },
        ),
      ),
    );
  }
}

class _PokemonCard extends StatelessWidget {
  const _PokemonCard();
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final colors = Theme.of(context).colorScheme;
    final ImageManager img = ServiceLocator().get();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 40),
        child: SearchBar(
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
