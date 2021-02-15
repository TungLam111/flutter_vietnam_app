// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../main.dart';

class LocalizationService {
  LocalizationService(this.locale);

  final Locale locale;

  /// See README 7.c for a word on localizedLocales.
  /// These are locales where we have custom crowdin language codes like pt-BR
  /// to support Brazilian Portuguese with a particular country, say Brazil.
  static const localizedLocales = ['pt-BR', 'es-ES', 'sv-SE', 'vi-VN'];

  /*Future<LocalizationService> load() {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    String localeName = Intl.canonicalizedLocale(name);

    if (localizedLocales.contains(locale.languageCode)) {
      localeName = locale.languageCode;
    }

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new LocalizationService(locale);
    });
  }*/

  /* static LocalizationService of(BuildContext context) {
    StreamSubscription _onLoggedInUserChangeSubscription;
    var openbookProvider = OpenbookProvider.of(context);
    _onLoggedInUserChangeSubscription =
        openbookProvider.userService.loggedInUserChange.listen((User newUser) {
      String _userLanguageCode = newUser != null && newUser.hasLanguage()
          ? newUser.language.code
          : null;
      Locale _currentLocale = Localizations.localeOf(context);
      if (_userLanguageCode != null &&
          supportedLanguages.contains(_userLanguageCode) &&
          _userLanguageCode != _currentLocale.languageCode) {
        Locale supportedMatchedLocale = supportedLocales.firstWhere(
            (Locale locale) => locale.languageCode == _userLanguageCode);
        print(
            'Overriding locale $_currentLocale with user locale: $supportedMatchedLocale');
        MyApp.setLocale(context, supportedMatchedLocale);
      }
      _onLoggedInUserChangeSubscription.cancel();
    });

    return Localizations.of<LocalizationService>(context, LocalizationService);
  }*/

   Locale getLocale() {
    return locale;
  }
}