import 'package:flutter/cupertino.dart';

class Todo {
  final int? id;
  final int? taskId;
  final String? title;
  final int? isDone;
  Todo({Key? key, this.id, this.taskId, this.title, this.isDone});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'taskId': taskId,
      'title': title,
      'isDone': isDone,
    };
  }
}
