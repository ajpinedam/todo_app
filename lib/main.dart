import 'package:flutter/material.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: TodoListScren(),
    );
  }
}

class TodoListScren extends StatefulWidget {
  const TodoListScren({super.key});

  @override
  State<TodoListScren> createState() => _TodoListScrenState();
}

class _TodoListScrenState extends State<TodoListScren> {
  List<String> todos = [];
  TextEditingController textFieldController = TextEditingController();

  void addTodoItem(String todoItem) {
    if (todoItem.isNotEmpty) {
      setState(() {
        todos.add(todoItem);
        textFieldController.clear();
      });
    }
  }

  void removeTodoItem(int index) {
    setState(() {
      todos.removeAt(index);
    });
  }

  //Futures

  Future<void> displayText(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add new todo'),
          content: TextField(
            controller: textFieldController,
            decoration: InputDecoration(hintText: 'Enter your to-do'),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                addTodoItem(textFieldController.text);
                Navigator.pop(context);
              },
              child: Text('Add to-do'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To-do List')),
      body:
          todos.isEmpty
              ? Center(child: Text('No to-dos yet! Click + button to add'))
              : ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(todos[index]),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => removeTodoItem(index),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => displayText(context),
        tooltip: 'Add Todo',
        child: Icon(Icons.add),
      ),
    );
  }
}
