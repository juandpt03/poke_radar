import 'package:poke_radar/features/home/domain/domain.dart';
import 'package:poke_radar/features/home/domain/entities/pokemon.dart';

class PokemonModel {
  final int id;
  final String name;
  final String imageUrl;
  final String backGroundColor;
  final PokemonInfoModel? info;

  PokemonModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.backGroundColor,
    this.info,
  });

  factory PokemonModel.fromJson(Map<String, dynamic> json) {
    final url = json['url'] as String;
    final id = int.parse(url.split('/').where((e) => e.isNotEmpty).last);
    final imageUrl =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';

    return PokemonModel(
      id: id,
      name: json['name'] ?? 'unknown',
      imageUrl: imageUrl,
      backGroundColor:
          '0xFF${(id * 0x12345678).toRadixString(16).substring(0, 6)}',
    );
  }

  Pokemon toEntity() => Pokemon(
        id: id,
        name: name,
        imageUrl: imageUrl,
        backGroundColor: backGroundColor,
        info: info?.toEntity(),
      );
}

class PokemonInfoModel {
  final String name;
  final int weight;
  final int height;
  final List<MoveModel> moves;
  final List<StatModel> stats;

  PokemonInfoModel({
    required this.stats,
    required this.moves,
    required this.name,
    required this.height,
    required this.weight,
  });

  factory PokemonInfoModel.fromJson(Map<String, dynamic> json) =>
      PokemonInfoModel(
        moves: List<MoveModel>.from(
            json["moves"].map((x) => MoveModel.fromJson(x))),
        name: json["name"] ?? 'unknown',
        stats: List<StatModel>.from(
            json["stats"].map((x) => StatModel.fromJson(x))),
        height: json["height"],
        weight: json["weight"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "moves": List<dynamic>.from(moves.map((x) => x.toJson())),
        "name": name,
        "stats": List<dynamic>.from(stats.map((x) => x.toJson())),
        "weight": weight,
      };

  PokemonInfo toEntity() => PokemonInfo(
        height: (double.tryParse(height.toString()) ?? 0.0) / 10,
        weight: (double.tryParse(weight.toString()) ?? 0.0) / 10,
        moves: moves.take(8).map((e) => e.move.name).toList(),
        stats: stats
            .map(
              (e) => Stat(
                name: e.stat.name,
                baseStat: e.baseStat,
                effort: e.effort,
              ),
            )
            .toList(),
      );
}

class SpeciesModel {
  final String name;
  final String url;

  SpeciesModel({
    required this.name,
    required this.url,
  });

  factory SpeciesModel.fromJson(Map<String, dynamic> json) => SpeciesModel(
        name: json["name"] ?? 'unknown',
        url: json["url"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}

class MoveModel {
  final SpeciesModel move;

  MoveModel({
    required this.move,
  });

  factory MoveModel.fromJson(Map<String, dynamic> json) => MoveModel(
        move: SpeciesModel.fromJson(json["move"]),
      );

  Map<String, dynamic> toJson() => {
        "move": move.toJson(),
      };
}

class StatModel {
  final int baseStat;
  final int effort;
  final SpeciesModel stat;

  StatModel({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  factory StatModel.fromJson(Map<String, dynamic> json) => StatModel(
        baseStat: json["base_stat"] ?? 0,
        effort: json["effort"] ?? 0,
        stat: SpeciesModel.fromJson(json["stat"]),
      );

  Map<String, dynamic> toJson() => {
        "base_stat": baseStat,
        "effort": effort,
        "stat": stat.toJson(),
      };
}
