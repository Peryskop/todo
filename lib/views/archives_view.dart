import 'package:flutter/material.dart';

import 'package:toduelist/custom/fade_in.dart';
import 'package:toduelist/custom/background.dart';
import 'package:toduelist/models/Task.dart';
import 'package:toduelist/utils/dbprovider.dart';

class Archives extends StatefulWidget {
  Archives({Key key}) : super(key: key);

  @override
  _ArchivesState createState() => _ArchivesState();
}

class _ArchivesState extends State<Archives> with TickerProviderStateMixin {
  FadeIn _fadeIn = FadeIn();
  DbProvider dbProvider = DbProvider();
  List<Task> _tasks = List<Task>();

  @override
  void initState() {
    super.initState();
    _fadeIn.prepareController(this);
    dbProvider
        .fetchDoneTasks()
        .then((value) => setState(() => _tasks.addAll(value)));
  }

  @override
  Widget build(BuildContext context) {
    _fadeIn.forward();
    return Container(
      decoration: Background.gradientBackground(
        Theme.of(context).primaryColor,
        Theme.of(context).accentColor,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          title: Image.asset('assets/toduelist_200x38.png'),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 0.0),
          child: FadeTransition(
            opacity: _fadeIn.Animation(),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
                    child: Row(children: [
                      Expanded(child: Text(_tasks[index].body)),
                      FlatButton(
                        color: Colors.red[400],
                        onPressed: () {
                          _tasks[index].done = 1;
                          dbProvider.deleteTask(
                            _tasks[index].id,
                          );
                          getTasks();
                        },
                        child: Text('Delete'),
                      ),
                    ]),
                  ),
                );
              },
              itemCount: _tasks.length,
            ),
          ),
        ),
      ),
    );
  }

  void getTasks() {
    _tasks.clear();
    dbProvider
        .fetchDoneTasks()
        .then((value) => setState(() => _tasks.addAll(value)));
  }
}
