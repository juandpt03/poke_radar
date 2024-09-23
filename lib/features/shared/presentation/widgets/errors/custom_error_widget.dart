import 'package:flutter/material.dart';
import 'package:poke_radar/core/core.dart';
import 'package:poke_radar/features/shared/shared.dart';

class CustomErrorWidget extends StatelessWidget {
  final HttpRequestFailure error;
  final VoidCallback onRetry;

  const CustomErrorWidget({
    super.key,
    required this.error,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.titleLarge?.copyWith();
    final titleTextStyle = Theme.of(context)
        .textTheme
        .displayMedium
        ?.copyWith(fontWeight: FontWeight.bold, color: colors.errorContainer);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).ups,
              style: titleTextStyle,
            ),
            const SizedBox(height: 16),
            Text(
              error.when(
                network: () => S.of(context).errorDeRedPorFavorRevisaTuConexin,
                notFound: () => S.of(context).recursoNoEncontrado,
                server: () =>
                    S.of(context).problemaConElServidorPorFavorIntentaMsTarde,
                unauthorized: () =>
                    S.of(context).accesoNoAutorizadoPorFavorIniciaSesin,
                badRequest: () =>
                    S.of(context).solicitudIncorrectaPorFavorIntentaDeNuevo,
                local: () => S.of(context).algoSaliMalPorFavorIntentaDeNuevo,
                forbidden: () => S.of(context).accesoProhibido,
              ),
              style: textStyle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            CustomFilledButton(
              onPressed: onRetry,
              text: S.of(context).reintentar,
            ),
          ],
        ),
      ),
    );
  }
}
