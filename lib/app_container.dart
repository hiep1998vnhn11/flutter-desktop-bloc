import 'dart:async';

import 'package:trello/blocs/bloc.dart';
import 'package:trello/screens/screen.dart';
import 'package:flutter/material.dart';
import './widgets/widget.dart';

class AppContainer extends StatefulWidget {
  const AppContainer({Key? key}) : super(key: key);

  @override
  _AppContainerState createState() {
    return _AppContainerState();
  }
}

class _AppContainerState extends State<AppContainer>
    with WidgetsBindingObserver {
  late StreamSubscription signSubscription;
  late StreamSubscription<String> onMessage;
  late StreamSubscription<String> onMessageOpenedApp;

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    ///AppState add observer
    WidgetsBinding.instance!.addObserver(this);

    ///SignOut event
    signSubscription = AppBloc.signCubit.stream.listen((state) {
      if (state == SignState.signOut) {
        Navigator.popUntil(
          context,
          ModalRoute.withName(Navigator.defaultRouteName),
        );
      }
    });
  }

  @override
  void dispose() {
    onMessage.cancel();
    onMessageOpenedApp.cancel();
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  ///Handle AppState
  @override
  void didChangeAppLifecycleState(state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {}
  }

  ///On change tab bottom menu
  void onItemTapped(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          Container(
            width: 250,
          ),
          const Expanded(
            child: Setting(),
          ),
          Container(
            width: 250,
            color: Colors.red,
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 100,
        color: Theme.of(context).primaryColor,
        child: const BottomBar(),
      ),
    );
  }
}
