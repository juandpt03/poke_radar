import 'package:flutter/material.dart';
import 'package:poke_radar/core/core.dart';

class ErrorPokemonGrid extends StatelessWidget {
  final HttpRequestFailure error;

  const ErrorPokemonGrid({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(error.toString()),
    );
  }
}
