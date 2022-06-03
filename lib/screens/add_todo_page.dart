import 'package:flutter/material.dart';

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key, required this.onAddTodo}) : super(key: key);

  final Function onAddTodo;

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  final formKey = GlobalKey<FormState>();
  String todoName = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: formKey,
        child: Column(
          children: [
            const Text(
              'Add Todo',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10.0),
            TextFormField(
              decoration: const InputDecoration(
                label: Text('Add Todo name'),
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value != null && value.length < 2) {
                  return 'Enter at least 2 characters!';
                }
                if (value != null && value.length > 18) {
                  return 'You can\'t enter more than 18 characters';
                }
                return null;
              },
              onChanged: (value) {
                todoName = value;
              },
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                final isValid = formKey.currentState!.validate();
                if (isValid) {
                  widget.onAddTodo(todoName);
                }
              },
              child: const Center(
                child: Text(
                  'Add Todo',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
