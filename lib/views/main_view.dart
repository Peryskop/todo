import 'package:flutter/material.dart';
import 'package:toduelist/views/all_lists_view.dart';
import 'package:toduelist/views/archives_view.dart';

class MainView extends StatefulWidget {
  static const routeName = "/main";
  MainView({Key key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static List<Widget> _widgets = <Widget>[
    AllLists(),
    Archives(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgets.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: 'Lists',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_turned_in_outlined),
            label: 'Archives',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: Theme.of(context).buttonColor,
        selectedItemColor: Theme.of(context).accentColor,
      ),
    );
  }
}
