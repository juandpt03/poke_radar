import 'package:flutter/material.dart';
import 'package:poke_radar/core/core.dart';

class Translator {
  Translator._internal();

  static final Translator _instance = Translator._internal();

  factory Translator() => _instance;

  String translate({
    required BuildContext context,
    required String name,
  }) {
    if (name == 'hp') {
      return S.of(context).vida;
    } else if (name == 'attack') {
      return S.of(context).ataque;
    } else if (name == 'defense') {
      return S.of(context).defensa;
    } else if (name == 'special-attack') {
      return S.of(context).ataqueEspecial;
    } else if (name == 'special-defense') {
      return S.of(context).defensaEspecial;
    } else if (name == 'speed') {
      return S.of(context).velocidad;
    } else {
      return name;
    }
  }
}
