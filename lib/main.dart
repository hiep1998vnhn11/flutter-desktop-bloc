import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:trello/app.dart';
import 'package:trello/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:window_size/window_size.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    UtilLogger.log('BLOC EVENT', event);
    super.onEvent(bloc, event);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    UtilLogger.log('BLOC ERROR', error);
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    UtilLogger.log('BLOC TRANSITION', transition);
    super.onTransition(bloc, transition);
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle("Spotify");
    setWindowMinSize(const Size(800, 600));
  }
  BlocOverrides.runZoned(
    () => runApp(
      const App(),
    ),
    blocObserver: AppBlocObserver(),
  );
}
