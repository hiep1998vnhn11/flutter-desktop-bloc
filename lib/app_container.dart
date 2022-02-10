import 'dart:async';

import 'package:trello/blocs/bloc.dart';
import 'package:trello/screens/screen.dart';
import 'package:flutter/material.dart';

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
      body: IndexedStack(
        children: const <Widget>[DashBoard(), Account()],
        index: selectedIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            label: 'dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: 'account',
          ),
        ],
        selectedFontSize: 12,
        unselectedFontSize: 10,
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}
