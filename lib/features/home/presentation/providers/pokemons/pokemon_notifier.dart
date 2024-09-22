import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_radar/features/home/domain/use_cases/pokemon_use_cases.dart';
import 'package:poke_radar/features/home/presentation/providers/pokemons/pokemon_state.dart';

class PokemonsNotifier extends StateNotifier<PokemonState> {
  final PokemonUseCases _pokemonUseCases;

  PokemonsNotifier({
    required PokemonUseCases pokemonUseCases,
  })  : _pokemonUseCases = pokemonUseCases,
        super(PokemonState.loading()) {
    getPokemons();
  }

  Future<void> getPokemons() async {
    final response = await _pokemonUseCases.getPokemons(
      offset: state.offset,
      limit: state.limit,
    );

    state = response.when(
      left: (error) => PokemonState.error(error: error),
      right: (pokemons) => state.maybeMap(
        orElse: () => PokemonState.success(
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
}
