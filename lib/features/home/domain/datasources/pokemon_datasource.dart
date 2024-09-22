import 'package:poke_radar/core/core.dart';
import 'package:poke_radar/features/home/domain/entities/pokemon.dart';

typedef GetPokemons = Future<Either<HttpRequestFailure, List<Pokemon>>>;

abstract class PokemonDatasource {
  GetPokemons getPokemons({int offset = 0, int limit = 10});
}
