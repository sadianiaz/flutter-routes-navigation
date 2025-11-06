import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateDataScreen extends StatefulWidget {
  const CreateDataScreen({super.key});

  @override
  State<CreateDataScreen> createState() => _CreateDataScreenState();
}

class _CreateDataScreenState extends State<CreateDataScreen> {
  final TextEditingController _controller = TextEditingController();
  Future<Album>? _futureAlbum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Data to Internet'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        child: (_futureAlbum == null)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: 'Enter Title'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Create Data'),
                    onPressed: () {
                      setState(() {
                        _futureAlbum = createAlbum(_controller.text);
                      });
                    },
                  ),
                ],
              )
            : FutureBuilder<Album>(
                future: _futureAlbum,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      'Created: ${snapshot.data!.title}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  return const CircularProgressIndicator();
                },
              ),
      ),
    );
  }
}

Future<Album> createAlbum(String title) async {
  final http.Response response = await http.post(
    Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'title': title}),
  );

  if (response.statusCode == 201) {
    return Album.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to create album.');
  }
}

class Album {
  final int id;
  final String title;

  Album({required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(id: json['id'], title: json['title']);
  }
}
