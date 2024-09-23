import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:poke_radar/core/core.dart';
import 'package:poke_radar/features/shared/shared.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Drawer(
      child: Column(
        children: [
          _DrawerHeader(),
          _LanguageSelector(),
          Divider(),
          _ThemeModeSwitch(),
          Divider(),
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader();

  @override
  Widget build(BuildContext context) {
    final img = ServiceLocator().get<ImageManager>();
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context)
        .textTheme
        .titleLarge
        ?.copyWith(fontWeight: FontWeight.bold, color: Colors.white);

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            isDarkMode ? colors.surface.withOpacity(0.2) : colors.secondary,
            isDarkMode
                ? colors.secondary.withOpacity(0.1)
                : colors.secondary.withOpacity(0.7),
          ],
          stops: const [0.1, 0.6],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(img.avatar),
            ),
            Text(S.of(context).configuraciones, style: textStyle),
          ],
        ),
      ),
    );
  }
}

class _LanguageSelector extends ConsumerWidget {
  const _LanguageSelector();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final currentLanguage = ref.watch(languageProvider);
    final textStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        );

    final isEnglishSelected = currentLanguage.languageCode == 'en';
    final isSpanishSelected = currentLanguage.languageCode == 'es';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Text(
              S.of(context).idioma,
              style: textStyle,
            ),
            const Spacer(),
            ToggleButtons(
              isSelected: [isEnglishSelected, isSpanishSelected],
              onPressed: (int index) {
                final selectedLocale =
                    index == 0 ? const Locale('en') : const Locale('es');
                ref
                    .read(languageProvider.notifier)
                    .updateLocale(selectedLocale);
              },
              borderRadius: BorderRadius.circular(16),
              selectedColor: colors.onSecondary,
              fillColor: colors.secondary,
              color: colors.onSurface,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(S.of(context).ingls),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(S.of(context).espaol),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeModeSwitch extends ConsumerWidget {
  const _ThemeModeSwitch();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeProvider);
    final colors = Theme.of(context).colorScheme;
    final textStyle = Theme.of(context).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            S.of(context).modoOscuro,
            style: textStyle,
          ),
          Switch(
            activeColor: colors.secondary,
            value: currentThemeMode == ThemeMode.dark,
            onChanged: (bool isDarkMode) => ref
                .read(themeProvider.notifier)
                .toggleTheme(isDarkMode ? ThemeMode.dark : ThemeMode.light),
          ),
        ],
      ),
    );
  }
}
