import "package:flutter/material.dart";

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoHome(),
    );
  }
}

class TodoHome extends StatefulWidget {
  @override
  TodoHomeState createState() => TodoHomeState();
}

class TodoHomeState extends State<TodoHome> {
  final List<Map<String, dynamic>> tasks = [];
  final TextEditingController controller = TextEditingController();
  void addTask() {
    if (controller.text.isNotEmpty) {
      setState(() {
        tasks.add({
        "task": controller.text,
        "isCompleted": false,
        }
      );
        controller.clear();
      });
    }
  }

  void toggleTask(int index) {
    setState(() {
      tasks[index]["isCompleted"] = !tasks[index]["isCompleted"];
    });
  }

  void deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TO DO Task"),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: "You'r Task",
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: addTask,
            child: Text("Add Task"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(
                    task["task"],
                    style: TextStyle(
                      decoration: task["isCompleted"]
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                  leading: Checkbox(
                    value: task["isCompleted"],
                    onChanged: (value) {
                      toggleTask(index);
                    },
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => deleteTask(index),
                  ),
                  
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
