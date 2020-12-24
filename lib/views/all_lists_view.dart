import 'package:flutter/material.dart';

import 'package:toduelist/custom/fade_in.dart';
import 'package:toduelist/custom/background.dart';
import 'package:toduelist/models/Task.dart';
import 'package:toduelist/utils/dbprovider.dart';

class AllLists extends StatefulWidget {
  AllLists({Key key}) : super(key: key);

  @override
  _AllListsState createState() => _AllListsState();
}

class _AllListsState extends State<AllLists> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final formController = TextEditingController();
  DbProvider dbProvider = DbProvider();
  FadeIn _fadeIn = FadeIn();
  List<Task> _tasks = List<Task>();

  @override
  void initState() {
    super.initState();
    _fadeIn.prepareController(this);
    dbProvider
        .fetchTasks()
        .then((value) => setState(() => _tasks.addAll(value)));
  }

  @override
  void dispose() {
    formController.dispose();
    super.dispose();
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
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: FadeTransition(
                opacity: _fadeIn.Animation(),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                        child: Dialog(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    controller: formController,
                                    decoration: InputDecoration(
                                        hintText: 'Enter task',
                                        contentPadding: EdgeInsets.fromLTRB(
                                            5.0, 0, 0, 5.0)),
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Please enter task';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                FlatButton(
                                  color: Theme.of(context).accentColor,
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      var task = Task(
                                        id: null,
                                        body: formController.text,
                                        done: 0,
                                      );
                                      formController.clear();
                                      dbProvider.addTask(task);
                                      Navigator.pop(context);
                                      getTasks();
                                    }
                                  },
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        context: context);
                  },
                  child: Icon(
                    Icons.add_circle_outline,
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              ),
            ),
          ],
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
                        color: Colors.green[400],
                        onPressed: () {
                          _tasks[index].done = 1;
                          dbProvider.updateTask(
                            _tasks[index].id,
                            _tasks[index],
                          );
                          getTasks();
                        },
                        child: Text('Done'),
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
        .fetchTasks()
        .then((value) => setState(() => _tasks.addAll(value)));
  }
}
