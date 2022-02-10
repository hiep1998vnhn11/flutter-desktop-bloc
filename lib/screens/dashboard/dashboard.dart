import 'package:trello/utils/translate.dart';
import 'package:flutter/material.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() {
    return _DashBoardState();
  }
}

class _DashBoardState extends State<DashBoard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'dashboard',
        ),
      ),
      body: Center(
        child: Text(
          'dashboard',
        ),
      ),
    );
  }
}
