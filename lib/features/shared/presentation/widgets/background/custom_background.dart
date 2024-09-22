import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  final Color? color;
  final Widget? child;
  const CustomBackground({super.key, this.child, this.color});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Opacity(
      opacity: 0.5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              color ?? colors.surface.withOpacity(0.5),
              Colors.transparent
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: const [0.1, 0.5],
          ),
        ),
        child: child,
      ),
    );
  }
}
