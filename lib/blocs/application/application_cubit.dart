import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:trello/blocs/bloc.dart';
import 'package:trello/configs/config.dart';
import 'package:trello/database/provider.dart';
import 'package:trello/models/model.dart';
import 'package:trello/utils/utils.dart';
import 'package:flutter/material.dart';

enum ApplicationState { loading, completed }

class ApplicationCubit extends Cubit<ApplicationState> {
  ApplicationCubit() : super(ApplicationState.loading);

  ///On Setup Application
  void onSetup() async {
    ///Setup SharedPreferences
    await Preferences.setPreferences();

    ///Load database
    await DatabaseProvider.createDatabase();

    ///Read/Save Device Information
    await Application.setDevice();

    ///Get old Theme & Font & Language
    final oldTimeZone = UtilPreferences.getBool(Preferences.localTimeZone);
    final oldTheme = UtilPreferences.getString(Preferences.theme);
    final oldFont = UtilPreferences.getString(Preferences.font);
    final oldLanguage = UtilPreferences.getString(Preferences.language);
    final oldDarkOption = UtilPreferences.getString(Preferences.darkOption);

    DarkOption? darkOption;
    String? font;
    ThemeModel? theme;

    ///Set timezone
    if (oldTimeZone == false) {
      Application.localTimeZone = false;
    }

    ///Setup Language
    if (oldLanguage != null) {
      AppBloc.languageCubit.onUpdate(Locale(oldLanguage));
    }

    ///Find font support available [Dart null safety issue]
    try {
      font = AppTheme.fontSupport.firstWhere((item) {
        return item == oldFont;
      });
    } catch (e) {
      UtilLogger.log("ERROR", e);
    }

    if (oldTheme != null) {
      try {
        theme = ThemeModel.fromJson(jsonDecode(oldTheme));
      } catch (e) {
        UtilLogger.log("ERROR", e);
      }
    }

    ///check old dark option
    if (oldDarkOption != null) {
      switch (oldDarkOption) {
        case 'off':
          darkOption = DarkOption.alwaysOff;
          break;
        case 'on':
          darkOption = DarkOption.alwaysOn;
          break;
        default:
          darkOption = DarkOption.dynamic;
      }
    }

    ///Setup Theme & Font with dark Option
    AppBloc.themeCubit.onChangeTheme(
      theme: theme,
      font: font,
      darkOption: darkOption,
    );

    ///Authentication begin check
    await AppBloc.authenticationCubit.onCheck();

    ///Done
    emit(ApplicationState.completed);
  }

  ///On Change Timezone
  void onChangeTimeZone(bool localTimeZone) async {
    emit(ApplicationState.loading);
    Application.localTimeZone = localTimeZone;
    await UtilPreferences.setBool(
      Preferences.localTimeZone,
      localTimeZone,
    );
    await Future.delayed(const Duration(milliseconds: 500));
    emit(ApplicationState.completed);
  }
}
