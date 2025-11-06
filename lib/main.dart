import 'package:flutter/material.dart';
import 'named_routes.dart';
import 'multipages_application.dart';
import 'return_data_from_screen.dart';
import 'routes_navigation.dart';
import 'arguments_routes.dart';
import 'url.dart';
import 'retrive_data.dart';
import 'websocket.dart';
import 'avoiding_junk.dart';
import 'fetching_data.dart';
import 'sending_data.dart';
import 'send_data_screen.dart';
import 'deleting_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Navigation Examples',
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  void _push(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    final examples = [
      {'title': 'Named Routes ', 'page': const NamedRoutesExample()},
      {
        'title': 'Multipage Navigator Example',
        'page': const MultiPageExample(),
      },
      {'title': 'Return Data Form Screen', 'page': const ReturnDataExample()},
      {
        'title': 'Routes And Navigation',
        'page': const RoutesNavigationExample(),
      },
      {'title': 'Arguments In Named Routes', 'page': const ArgumentsExample()},
      {'title': 'URL In Flutter', 'page': const UrlLauncherExample()},
      {
        'title': 'Retrieve Data For TextFields In Flutter',
        'page': const RetrieveDataExample(),
      },
      {'title': 'WebSocket', 'page': const WebSocketExample()},
      {
        'title': 'Avoiding Junk',
        'page': const HomePage(title: 'Avoiding Junk File'),
      },
      {
        'title': 'Fetching Data From Internet',
        'page': const FetchDataExample(),
      },
      {'title': 'Delete Data From Internet', 'page': const DeleteDataScreen()},
      {'title': 'Send Data To Internet', 'page': const CreateDataScreen()},
      {
        'title': 'Send Data To Screen',
        'page': TodosScreen(
          tasks: List.generate(
            10,
            (i) => Task('Task $i', 'Task Description $i'),
          ),
        ),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Examples'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: examples.length,
        itemBuilder: (context, index) {
          final item = examples[index];
          return ListTile(
            title: Text(item['title'] as String),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => _push(context, item['page'] as Widget),
          );
        },
      ),
    );
  }
}
