import 'package:poke_radar/features/home/domain/domain.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonDatasource datasource;

  PokemonRepositoryImpl({required this.datasource});
  @override
  GetPokemons getPokemons({int offset = 0, int limit = 10}) =>
      datasource.getPokemons(offset: offset, limit: limit);

  @override
  GetPokemonInfo getPokemonInfo({required int id}) =>
      datasource.getPokemonInfo(id: id);
}
