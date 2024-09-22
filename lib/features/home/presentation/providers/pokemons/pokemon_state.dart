import 'package:poke_radar/core/core.dart';
import 'package:poke_radar/features/home/domain/domain.dart';

sealed class PokemonState {
  const PokemonState();

  factory PokemonState.loading() => const Loading();
  factory PokemonState.success({
    required List<Pokemon> pokemons,
    int offset = 0,
    int limit = 10,
  }) =>
      Success(
        pokemons: pokemons,
        offset: offset,
        limit: limit,
      );

  factory PokemonState.error({required HttpRequestFailure error}) =>
      Error(error: error);

  T when<T>(
      {required T Function() loading,
      required T Function(List<Pokemon> pokemons) success,
      required T Function(HttpRequestFailure error) error}) {
    if (this is Loading) {
      return loading();
    } else if (this is Success) {
      return success((this as Success).pokemons);
    } else if (this is Error) {
      return error((this as Error).error);
    } else {
      throw Exception();
    }
  }

  T map<T>(
      {required T Function(Loading) loading,
      required T Function(Success) success,
      required T Function(Error) error}) {
    if (this is Loading) {
      return loading(this as Loading);
    } else if (this is Success) {
      return success(this as Success);
    } else if (this is Error) {
      return error(this as Error);
    } else {
      throw Exception();
    }
  }

  T maybeMap<T>(
      {T Function(Loading)? loading,
      T Function(Success)? success,
      T Function(Error)? error,
      required T Function() orElse}) {
    if (this is Loading) {
      return loading != null ? loading(this as Loading) : orElse();
    } else if (this is Success) {
      return success != null ? success(this as Success) : orElse();
    } else if (this is Error) {
      return error != null ? error(this as Error) : orElse();
    } else {
      throw Exception();
    }
  }
}

class Loading extends PokemonState {
  const Loading();
}

class Success extends PokemonState {
  final List<Pokemon> pokemons;

  final int offset;
  final int limit;

  const Success({
    required this.pokemons,
    required this.offset,
    required this.limit,
  });

  Success copyWith({
    List<Pokemon>? pokemons,
    int? offset,
    int? limit,
  }) {
    return Success(
      pokemons: pokemons ?? this.pokemons,
      offset: offset ?? this.offset,
      limit: limit ?? this.limit,
    );
  }
}

class Error extends PokemonState {
  final HttpRequestFailure error;
  const Error({
    required this.error,
  });

  Error copyWith({
    HttpRequestFailure? error,
  }) {
    return Error(
      error: error ?? this.error,
    );
  }
}

extension PokemonStateX on PokemonState {
  bool get isLoading => this is Loading;
  bool get isSuccess => this is Success;
  bool get isError => this is Error;

  int get offset => maybeMap(orElse: () => 0, success: (state) => state.offset);
  int get limit => maybeMap(orElse: () => 10, success: (state) => state.limit);
}
