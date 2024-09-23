import 'package:flutter/material.dart';

class MovesDetails extends StatelessWidget {
  final List<String> moves;

  const MovesDetails({super.key, required this.moves});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: [
            colors.tertiary.withOpacity(0.1),
            colors.secondary.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.1, 0.6],
        ),
      ),
      child: SingleChildScrollView(
        child: Wrap(
          runAlignment: WrapAlignment.spaceEvenly,
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: moves
              .map(
                (move) => Chip(
                  backgroundColor: colors.onSurface.withOpacity(0.2),
                  labelStyle: TextStyle(color: colors.onSurface, fontSize: 16),
                  label: Text(move),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
