import 'package:dio/dio.dart';
import 'package:poke_radar/core/core.dart';
import 'package:poke_radar/features/home/domain/domain.dart';
import 'package:poke_radar/features/home/infrastructure/models/pokemon_model.dart';

class PokeApiDatasource implements PokemonDatasource {
  final Dio client;

  PokeApiDatasource({required this.client});

  @override
  GetPokemons getPokemons({int offset = 0, int limit = 10}) async {
    try {
      final response = await client.get(
        queryParameters: {"offset": offset, "limit": limit},
        pokemonsListPath,
      );
      if (response.statusCode == 200) {
        final List<Pokemon> pokemons =
            List<Pokemon>.from(response.data["results"].map(
          (x) => PokemonModel.fromJson(x).toEntity(),
        ));

        return Either.right(pokemons);
      }
      throw HttpRequestFailure.fromCode(response.statusCode);
    } catch (e) {
      final failure = HttpRequestFailure.fromException(e);
      return Either.left(failure);
    }
  }

  @override
  GetPokemonInfo getPokemonInfo({required int id}) async {
    try {
      final response = await client.get("$pokemonsListPath/$id");
      if (response.statusCode == 200) {
        final pokemon = PokemonInfoModel.fromJson(response.data).toEntity();
        return Either.right(pokemon);
      }
      throw HttpRequestFailure.fromCode(response.statusCode);
    } catch (e) {
      final failure = HttpRequestFailure.fromException(e);
      return Either.left(failure);
    }
  }
}
