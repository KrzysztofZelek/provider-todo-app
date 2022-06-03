import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_todo_app/models/todo.dart';
import 'package:provider_todo_app/provider/todo_provider.dart';
import 'package:provider_todo_app/screens/add_todo_page.dart';
import 'package:provider_todo_app/screens/edit_todo_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodoProvider>(context);
    final todos = provider.todos;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('TODO App'),
      ),
      body: todos.isEmpty
          ? const Center(
              child: Text(
                'No TODOs addet yet!',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : buildTodo(todos),
      floatingActionButton: Consumer<TodoProvider>(
        builder: (context, value, child) => FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => AddTodoPage(
                onAddTodo: (todoName) {
                  value.addTodo(todoName);
                  Navigator.pop(context);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildTodo(List<Todo> todos) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: todos.length,
      itemBuilder: ((context, index) {
        final todo = todos[index];
        return Consumer<TodoProvider>(
          builder: (context, value, child) => ListTile(
            title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    todo.task,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => EditTodoPage(
                                    todo: todo,
                                    onEditTodo: (newTodo) {
                                      value.removeTodo(todo);
                                      value.addTodo(newTodo);
                                      Navigator.pop(context);
                                    },
                                  )));
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      IconButton(
                        onPressed: () {
                          value.removeTodo(todo);
                        },
                        icon: const Icon(Icons.delete),
                      ),
                    ],
                  )
                ]),
            trailing: Checkbox(
              value: todo.isDone,
              onChanged: (_) {
                value.toggleDone(todo);
              },
            ),
          ),
        );
      }),
    );
  }
}
