import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_radar/features/home/domain/domain.dart';
import 'package:poke_radar/features/home/presentation/providers/pokemons/pokemons_state.dart';

class PokemonsNotifier extends StateNotifier<PokemonsState> {
  final PokemonUseCases _pokemonUseCases;

  PokemonsNotifier({
    required PokemonUseCases pokemonUseCases,
  })  : _pokemonUseCases = pokemonUseCases,
        super(PokemonsState.loading()) {
    getPokemons();
  }

  Future<void> getPokemons() async {
    final response = await _pokemonUseCases.getPokemons(
      offset: state.offset,
      limit: state.limit,
    );

    state = response.when(
      left: (error) => PokemonsState.error(error: error),
      right: (pokemons) => state.maybeMap(
        orElse: () => PokemonsState.success(
          pokemons: pokemons,
          offset: state.offset + state.limit,
        ),
        success: (state) => state.copyWith(
          pokemons: [...state.pokemons, ...pokemons],
          offset: state.offset + state.limit,
        ),
      ),
    );
  }

  void setSelectedPokemon({
    required Pokemon pokemon,
  }) {
    state = state.maybeMap(
      orElse: () => state,
      success: (state) => state.copyWith(pokemon: pokemon),
    );
  }

  void toggleFavoritePokemon() {
    state = state.maybeMap(
      orElse: () => state,
      success: (state) => state.copyWith(
        pokemon:
            state.pokemon?.copyWith(isFavorite: !state.pokemon!.isFavorite),
        pokemons: [
          ...state.pokemons.map(
            (p) => p.id == state.pokemon!.id
                ? p.copyWith(isFavorite: !p.isFavorite)
                : p,
          ),
        ],
        filteredPokemons: [
          ...state.filteredPokemons.map(
            (p) => p.id == state.pokemon!.id
                ? p.copyWith(isFavorite: !p.isFavorite)
                : p,
          ),
        ],
      ),
    );
  }

  void toggleFavoritePokemons({required int id}) {
    state = state.maybeMap(
      orElse: () => state,
      success: (state) => state.copyWith(
        pokemons: [
          ...state.pokemons.map(
            (p) => p.id == id ? p.copyWith(isFavorite: !p.isFavorite) : p,
          ),
        ],
        filteredPokemons: [
          ...state.filteredPokemons.map(
            (p) => p.id == id ? p.copyWith(isFavorite: !p.isFavorite) : p,
          ),
        ],
      ),
    );
  }

  Future<void> getPokemonInfo() async {
    final id = state.pokemon?.id;
    if (id == null) return;
    final response = await _pokemonUseCases.getPokemonInfo(id: id);

    state = response.when(
      left: (error) => PokemonsState.error(error: error),
      right: (info) => state.maybeMap(
        orElse: () => state,
        success: (state) =>
            state.copyWith(pokemon: state.pokemon?.copyWith(info: info)),
      ),
    );
  }

  void filterPokemons({required String query}) {
    state = state.maybeMap(
      orElse: () => state,
      success: (state) => state.copyWith(
        filteredPokemons: query.isEmpty
            ? []
            : state.pokemons
                .where(
                    (p) => p.name.toLowerCase().contains(query.toLowerCase()))
                .toList(),
      ),
    );
  }
}
