import 'package:poke_radar/core/core.dart';
import 'package:poke_radar/features/home/domain/entities/pokemon.dart';

typedef GetPokemons = Future<Either<HttpRequestFailure, List<Pokemon>>>;
typedef GetPokemonInfo = Future<Either<HttpRequestFailure, PokemonInfo>>;

abstract class PokemonDatasource {
  GetPokemons getPokemons({int offset = 0, int limit = 10});
  GetPokemonInfo getPokemonInfo({required int id});
}
