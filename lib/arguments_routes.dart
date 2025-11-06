import 'package:flutter/material.dart';

class ArgumentsExample extends StatelessWidget {
  const ArgumentsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        if (settings.name == PassArgumentsScreen.routeName) {
          final args = settings.arguments as Arguments;
          return MaterialPageRoute(
            builder: (context) {
              return PassArgumentsScreen(
                title: args.title,
                message: args.message,
              );
            },
          );
        }
        assert(false, 'Implementation for ${settings.name} is missing.');
        return null;
      },
      title: 'Arguments in named routes',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      routes: {
        ExtractArgumentsScreen.routeName: (context) => ExtractArgumentsScreen(),
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GeekForGeeks'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text("Extracts arguments"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  ExtractArgumentsScreen.routeName,
                  arguments: Arguments(
                    'Extract Arguments Screen',
                    'Extracted in the build method.',
                  ),
                );
              },
            ),
            ElevatedButton(
              child: const Text("Accepts arguments"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  PassArgumentsScreen.routeName,
                  arguments: Arguments(
                    'Accept Arguments Screen',
                    'Extracted in the onGenerateRoute function.',
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ExtractArgumentsScreen extends StatelessWidget {
  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    final Arguments args =
        ModalRoute.of(context)!.settings.arguments as Arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.title),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Center(child: Text(args.message)),
    );
  }
}

class PassArgumentsScreen extends StatelessWidget {
  static const routeName = '/passArguments';

  final String title;
  final String message;

  const PassArgumentsScreen({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Center(child: Text(message)),
    );
  }
}

class Arguments {
  final String title;
  final String message;

  Arguments(this.title, this.message);
}
