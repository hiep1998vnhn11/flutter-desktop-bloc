import 'package:bloc/bloc.dart';
import 'package:trello/app.dart';
import 'package:trello/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  BlocOverrides.runZoned(() => null, blocObserver: AppBlocObserver());
  // WidgetsFlutterBinding.ensureInitialized();
  // Bloc.observer = AppBlocObserver();
  runApp(const App());
}
