import 'package:flutter/material.dart';
import 'package:provider_todo_app/models/todo.dart';

class EditTodoPage extends StatefulWidget {
  const EditTodoPage({Key? key, required this.todo, required this.onEditTodo})
      : super(key: key);
  final Function onEditTodo;
  final Todo todo;

  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final formKey = GlobalKey<FormState>();
  String newTask = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Todo'),
      ),
      body: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: Container(
          padding: const EdgeInsets.all(12.0),
          child: Column(children: [
            const Text(
              'Edit Todo',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              initialValue: widget.todo.task,
              decoration: const InputDecoration(
                label: Text('Edit Todo'),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value != null && value.length < 2) {
                  return 'Enter at least 2 characters!';
                }
                if (value != null && value.length > 18) {
                  return 'You can\'t enter more than 18 characters';
                }
                if (value == widget.todo.task) {
                  return 'Edit your todo before proceeding ahead!';
                }
                return null;
              },
              onChanged: (value) {
                newTask = value;
              },
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                final isValid = formKey.currentState!.validate();
                if (isValid) {
                  widget.onEditTodo(newTask);
                }
              },
              child: const Center(
                child: Text('Click to edit'),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
