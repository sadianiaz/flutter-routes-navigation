import 'package:flutter/material.dart';

// Task model
class Task {
  final String taskName;
  final String description;

  Task(this.taskName, this.description);
}

// Home screen that shows the task list
class TodosScreen extends StatelessWidget {
  final List<Task> tasks;

  const TodosScreen({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passing Data Example'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(tasks[index].taskName),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(task: tasks[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Detail screen that receives data
class DetailScreen extends StatelessWidget {
  final Task task;

  const DetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(task.taskName),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(task.description, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
