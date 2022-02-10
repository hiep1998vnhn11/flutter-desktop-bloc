import 'package:trello/app_container.dart';
import 'package:trello/blocs/bloc.dart';
import 'package:trello/configs/config.dart';
import 'package:trello/screens/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    AppBloc.applicationCubit.onSetup();
  }

  @override
  void dispose() {
    AppBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: AppBloc.providers,
      child: BlocBuilder<LanguageCubit, dynamic>(
        builder: (context, _) {
          return BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, theme) {
              return BlocBuilder<AuthenticationCubit, AuthenticationState>(
                builder: (context, auth) {
                  return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: theme.lightTheme,
                    darkTheme: theme.darkTheme,
                    onGenerateRoute: Routes.generateRoute,
                    home: Scaffold(
                      body: BlocListener<MessageBloc, MessageState>(
                        listener: (context, message) {
                          if (message is MessageShow) {
                            SnackBarAction? action;
                            if (message.action != null) {
                              action = SnackBarAction(
                                label: 'OK',
                                onPressed: message.onPressed!,
                              );
                            }
                            final snackBar = SnackBar(
                              content: const Text(
                                'Canvel',
                              ),
                              action: action,
                              duration: Duration(
                                seconds: message.duration ?? 1,
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              snackBar,
                            );
                          }
                        },
                        child: BlocBuilder<ApplicationCubit, ApplicationState>(
                          builder: (context, application) {
                            if (application == ApplicationState.completed) {
                              if (auth == AuthenticationState.fail) {
                                return const SignIn();
                              }
                              if (auth == AuthenticationState.success) {
                                return const AppContainer();
                              }
                            }
                            return const SplashScreen();
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
