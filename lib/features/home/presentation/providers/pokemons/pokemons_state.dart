import 'package:poke_radar/core/core.dart';
import 'package:poke_radar/features/home/domain/domain.dart';

sealed class PokemonsState {
  const PokemonsState();

  factory PokemonsState.loading() => const PokemonsLoading();
  factory PokemonsState.success({
    required List<Pokemon> pokemons,
    List<Pokemon> filteredPokemons = const [],
    int offset = 0,
    int limit = 10,
  }) =>
      PokemonsSuccess(
        pokemons: pokemons,
        filteredPokemons: filteredPokemons,
        offset: offset,
        limit: limit,
      );

  factory PokemonsState.error({required HttpRequestFailure error}) =>
      PokemonsError(error: error);

  T when<T>(
      {required T Function() loading,
      required T Function({
        List<Pokemon> pokemons,
        Pokemon? pokemon,
        int offset,
        int limit,
      }) success,
      required T Function(HttpRequestFailure error) error}) {
    if (this is PokemonsLoading) {
      return loading();
    } else if (this is PokemonsSuccess) {
      return success(
        pokemon: (this as PokemonsSuccess).pokemon,
        pokemons: (this as PokemonsSuccess).pokemons,
        offset: (this as PokemonsSuccess).offset,
        limit: (this as PokemonsSuccess).limit,
      );
    } else if (this is PokemonsError) {
      return error((this as PokemonsError).error);
    } else {
      throw Exception();
    }
  }

  T map<T>(
      {required T Function(PokemonsLoading) loading,
      required T Function(PokemonsSuccess) success,
      required T Function(PokemonsError) error}) {
    if (this is PokemonsLoading) {
      return loading(this as PokemonsLoading);
    } else if (this is PokemonsSuccess) {
      return success(this as PokemonsSuccess);
    } else if (this is PokemonsError) {
      return error(this as PokemonsError);
    } else {
      throw Exception();
    }
  }

  T maybeMap<T>(
      {T Function(PokemonsLoading)? loading,
      T Function(PokemonsSuccess)? success,
      T Function(PokemonsError)? error,
      required T Function() orElse}) {
    if (this is PokemonsLoading) {
      return loading != null ? loading(this as PokemonsLoading) : orElse();
    } else if (this is PokemonsSuccess) {
      return success != null ? success(this as PokemonsSuccess) : orElse();
    } else if (this is PokemonsError) {
      return error != null ? error(this as PokemonsError) : orElse();
    } else {
      throw Exception();
    }
  }
}

class PokemonsLoading extends PokemonsState {
  const PokemonsLoading();
}

class PokemonsSuccess extends PokemonsState {
  final List<Pokemon> pokemons;
  final List<Pokemon> filteredPokemons;
  final int offset;
  final int limit;
  final Pokemon? pokemon;

  const PokemonsSuccess({
    required this.pokemons,
    this.filteredPokemons = const [],
    required this.offset,
    required this.limit,
    this.pokemon,
  });

  PokemonsSuccess copyWith({
    List<Pokemon>? pokemons,
    List<Pokemon>? filteredPokemons,
    Pokemon? pokemon,
    int? offset,
    int? limit,
  }) {
    return PokemonsSuccess(
      pokemons: pokemons ?? this.pokemons,
      filteredPokemons: filteredPokemons ?? this.filteredPokemons,
      pokemon: pokemon ?? this.pokemon,
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
    );
  }
}

class PokemonsError extends PokemonsState {
  final HttpRequestFailure error;
  const PokemonsError({
    required this.error,
  });

  PokemonsError copyWith({
    HttpRequestFailure? error,
  }) {
    return PokemonsError(
      error: error ?? this.error,
    );
  }
}

extension PokemonsStateX on PokemonsState {
  bool get isLoading => this is PokemonsLoading;
  bool get isSuccess => this is PokemonsSuccess;
  bool get isError => this is PokemonsError;

  int get offset => maybeMap(orElse: () => 0, success: (state) => state.offset);
  int get limit => maybeMap(orElse: () => 10, success: (state) => state.limit);
  Pokemon? get pokemon =>
      maybeMap(orElse: () => null, success: (state) => state.pokemon);
}
