import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_radar/core/services/client/client.dart';
import 'package:poke_radar/features/home/domain/domain.dart';
import 'package:poke_radar/features/home/infrastructure/datasources/poke_api_datasource.dart';
import 'package:poke_radar/features/home/infrastructure/repositories/pokemon_repository_impl.dart';
import 'package:poke_radar/features/home/presentation/providers/providers.dart';

final pokemonsProvider = StateNotifierProvider<PokemonsNotifier, PokemonsState>(
  (ref) => PokemonsNotifier(
    pokemonUseCases: ref.read(getPokemonUsecaseProvider),
  ),
);

final getPokemonUsecaseProvider = Provider<PokemonUseCases>(
  (ref) => PokemonUseCasesImpl(
    repository: PokemonRepositoryImpl(
      datasource: PokeApiDatasource(client: Client.client),
    ),
  ),
);
