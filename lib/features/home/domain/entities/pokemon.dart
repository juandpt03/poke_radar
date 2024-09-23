class Pokemon {
  final int id;
  final String name;
  final String imageUrl;
  final PokemonInfo? info;
  final String backGroundColor;
  final bool isFavorite;

  Pokemon({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.backGroundColor,
    this.info,
    this.isFavorite = false,
  });

  Pokemon copyWith({
    int? id,
    String? name,
    String? imageUrl,
    PokemonInfo? info,
    String? backGroundColor,
    bool? isFavorite,
  }) =>
      Pokemon(
        id: id ?? this.id,
        name: name ?? this.name,
        imageUrl: imageUrl ?? this.imageUrl,
        info: info ?? this.info,
        backGroundColor: backGroundColor ?? this.backGroundColor,
        isFavorite: isFavorite ?? this.isFavorite,
      );
}

class PokemonInfo {
  final double height;
  final double weight;
  final List<String> moves;
  final List<Stat> stats;

  PokemonInfo({
    required this.height,
    required this.weight,
    required this.moves,
    required this.stats,
  });
}

class Stat {
  final String name;
  final int baseStat;
  final int effort;

  Stat({
    required this.name,
    required this.baseStat,
    required this.effort,
  });
}
