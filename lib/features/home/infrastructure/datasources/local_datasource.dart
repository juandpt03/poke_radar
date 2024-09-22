import 'package:poke_radar/features/home/domain/domain.dart';

class LocalDatasource implements PokemonDatasource {
  @override
  GetPokemons getPokemons({int offset = 0, int limit = 10}) {
    throw UnimplementedError();
  }
}
