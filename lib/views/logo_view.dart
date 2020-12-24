import 'package:flutter/material.dart';

import 'package:toduelist/custom/background.dart';
import 'package:toduelist/views/main_view.dart';

class LogoView extends StatefulWidget {
  static const routeName = "/";
  LogoView({Key key}) : super(key: key);

  @override
  _LogoViewState createState() => _LogoViewState();
}

class _LogoViewState extends State<LogoView> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, MainView.routeName);
    });

    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: Background.gradientBackground(
        Theme.of(context).primaryColor,
        Theme.of(context).accentColor,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Image.asset('assets/toduelist_200x200.png'),
        ),
      ),
    );
  }
}
