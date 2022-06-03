import 'package:flutter/cupertino.dart';
import 'package:provider_todo_app/models/todo.dart';

class TodoProvider extends ChangeNotifier {
  final List<Todo> _todos = [];

  toggleDone(Todo todo) {
    todo.isDone = !todo.isDone;
    notifyListeners();

    return todo.isDone;
  }

  addTodo(String task) {
    _todos.add(Todo(task: task));
    notifyListeners();
  }

  removeTodo(Todo todo) {
    _todos.remove(todo);
    notifyListeners();
  }

  List<Todo> get todos => _todos;
}
