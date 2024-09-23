import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_radar/core/core.dart';
import 'package:poke_radar/features/home/presentation/providers/providers.dart';
import 'package:poke_radar/features/shared/shared.dart';

class ErrorPokemonGrid extends ConsumerWidget {
  final HttpRequestFailure error;

  const ErrorPokemonGrid({super.key, required this.error});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomErrorWidget(
      error: error,
      onRetry: () async {
        await ref.read(pokemonsProvider.notifier).getPokemons();
      },
    );
  }
}
