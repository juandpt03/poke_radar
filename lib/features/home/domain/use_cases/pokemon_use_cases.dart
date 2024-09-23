import 'package:poke_radar/features/home/domain/domain.dart';

abstract class PokemonUseCases {
  GetPokemons getPokemons({int offset = 0, int limit = 10});
  GetPokemonInfo getPokemonInfo({required int id});
}

class PokemonUseCasesImpl extends PokemonUseCases {
  final PokemonRepository _repository;

  PokemonUseCasesImpl({required PokemonRepository repository})
      : _repository = repository;

  @override
  GetPokemons getPokemons({int offset = 0, int limit = 10}) =>
      _repository.getPokemons(offset: offset, limit: limit);

  @override
  GetPokemonInfo getPokemonInfo({required int id}) =>
      _repository.getPokemonInfo(id: id);
}
