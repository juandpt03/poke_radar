import 'package:poke_radar/features/home/domain/domain.dart';

abstract class PokemonRepository {
  GetPokemons getPokemons({int offset = 0, int limit = 10});
}
