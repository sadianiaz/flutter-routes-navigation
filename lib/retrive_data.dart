import "package:flutter/material.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Retrieve Data Example',
      home: RetrieveDataExample(),
    );
  }
}

class RetrieveDataExample extends StatefulWidget {
  const RetrieveDataExample({Key? key}) : super(key: key);

  @override
  _RetrieveDataExampleState createState() => _RetrieveDataExampleState();
}

class _RetrieveDataExampleState extends State<RetrieveDataExample> {
  // Variable to store input value
  late String title;
  String text = "No Value Entered";

  // Function to update text
  void _setText() {
    setState(() {
      text = title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GeeksforGeeks'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Enter Title'),
              onChanged: (value) => title = value,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _setText,
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.green),
                foregroundColor: WidgetStateProperty.all(Colors.white),
                elevation: WidgetStateProperty.all(6),
              ),
              child: const Text('Submit'),
            ),
            const SizedBox(height: 20),
            Text(text, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
