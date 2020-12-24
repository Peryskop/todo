import 'package:flutter/material.dart';
import 'package:toduelist/views/logo_view.dart';
import 'package:toduelist/views/main_view.dart';

void main() {
  runApp(Toduelist());
}

class Toduelist extends StatelessWidget {
  const Toduelist({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        LogoView.routeName: (context) => LogoView(),
        MainView.routeName: (context) => MainView(),
      },
      debugShowCheckedModeBanner: false,
      title: 'Toduelist',
      theme: ThemeData(
        primaryColor: Color(0xffc7d4ff),
        accentColor: Color(0xff4a5ea1),
        secondaryHeaderColor: Color(0xff1a2752),
      ),
    );
  }
}
