class Task {
  int id;
  String body;
  int done;

  Task({this.id, this.body, this.done});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'body': body,
      'done': done,
    };
  }
}
