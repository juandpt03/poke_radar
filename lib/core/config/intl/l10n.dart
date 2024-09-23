// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Find Your Pokemon`
  String get encuentraTuPokemon {
    return Intl.message(
      'Find Your Pokemon',
      name: 'encuentraTuPokemon',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get buscar {
    return Intl.message(
      'Search',
      name: 'buscar',
      desc: '',
      args: [],
    );
  }

  /// `Height`
  String get altura {
    return Intl.message(
      'Height',
      name: 'altura',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get peso {
    return Intl.message(
      'Weight',
      name: 'peso',
      desc: '',
      args: [],
    );
  }

  /// `Moves`
  String get movimentos {
    return Intl.message(
      'Moves',
      name: 'movimentos',
      desc: '',
      args: [],
    );
  }

  /// `Statistics`
  String get estadsticas {
    return Intl.message(
      'Statistics',
      name: 'estadsticas',
      desc: '',
      args: [],
    );
  }

  /// `Hp`
  String get vida {
    return Intl.message(
      'Hp',
      name: 'vida',
      desc: '',
      args: [],
    );
  }

  /// `Attack`
  String get ataque {
    return Intl.message(
      'Attack',
      name: 'ataque',
      desc: '',
      args: [],
    );
  }

  /// `Defense`
  String get defensa {
    return Intl.message(
      'Defense',
      name: 'defensa',
      desc: '',
      args: [],
    );
  }

  /// `Sp Attack`
  String get ataqueEspecial {
    return Intl.message(
      'Sp Attack',
      name: 'ataqueEspecial',
      desc: '',
      args: [],
    );
  }

  /// `Sp Defense`
  String get defensaEspecial {
    return Intl.message(
      'Sp Defense',
      name: 'defensaEspecial',
      desc: '',
      args: [],
    );
  }

  /// `Speed`
  String get velocidad {
    return Intl.message(
      'Speed',
      name: 'velocidad',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get configuraciones {
    return Intl.message(
      'Settings',
      name: 'configuraciones',
      desc: '',
      args: [],
    );
  }

  /// `Change Language`
  String get cambiarIdioma {
    return Intl.message(
      'Change Language',
      name: 'cambiarIdioma',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get ingls {
    return Intl.message(
      'English',
      name: 'ingls',
      desc: '',
      args: [],
    );
  }

  /// `Spanish`
  String get espaol {
    return Intl.message(
      'Spanish',
      name: 'espaol',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get idioma {
    return Intl.message(
      'Language',
      name: 'idioma',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get modoOscuro {
    return Intl.message(
      'Dark Mode',
      name: 'modoOscuro',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'es'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
