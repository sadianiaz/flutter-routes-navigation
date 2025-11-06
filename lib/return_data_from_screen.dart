import 'package:flutter/material.dart';

// Entry point of the app
void main() {
  runApp(const ReturnDataExample());
}

// Wrapper class for returning data example
class ReturnDataExample extends StatelessWidget {
  const ReturnDataExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Returning Data',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GeeksForGeeks'),
        backgroundColor: Colors.green,
      ),
      body: const Center(child: SelectionButton()),
    );
  }
}

class SelectionButton extends StatelessWidget {
  const SelectionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
      ),
      onPressed: () {
        _navigateAndDisplaySelection(context);
      },
      child: const Text('Launch Option Screen'),
    );
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SelectionScreen()),
    );

    // Safely show returned result using ScaffoldMessenger
    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$result")));
  }
}

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Option'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.green,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context, 'You selected Option 1');
                },
                child: const Text('Option 1'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.green,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context, 'You selected Option 2');
                },
                child: const Text('Option 2'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
