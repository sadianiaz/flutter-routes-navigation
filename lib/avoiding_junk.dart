import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Function to fetch data from the API
Future<List<Photo>> fetchPhotos(http.Client client) async {
  final response = await client.get(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1/photos'),
  );

  // Use compute() to parse data in a separate isolate (avoids junk/lag)
  return compute(parsePhotos, response.body);
}

// Function to parse JSON response
List<Photo> parsePhotos(String responseBody) {
  final List<dynamic> parsed = jsonDecode(responseBody);
  return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
}

// Photo model class
class Photo {
  final int id;
  final String title;
  final String thumbnailUrl;

  Photo({required this.id, required this.title, required this.thumbnailUrl});

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] as int,
      title: json['title'] as String,
      // Correct thumbnail URL
      thumbnailUrl: json['thumbnailUrl'] as String,
    );
  }
}

// Main function
void main() => runApp(const MyApp());

// Root widget
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Fetch Data Example';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: HomePage(title: appTitle),
    );
  }
}

// Home Page Widget
class HomePage extends StatelessWidget {
  final String title;
  const HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Photo>>(
        future: fetchPhotos(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error loading data!'));
          } else if (snapshot.hasData) {
            return PhotosGrid(photos: snapshot.data!);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

// Grid view to display images
class PhotosGrid extends StatelessWidget {
  final List<Photo> photos;
  const PhotosGrid({super.key, required this.photos});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: photos.length,
      itemBuilder: (context, index) {
        final photo = photos[index];
        return Card(
          margin: const EdgeInsets.all(8),
          elevation: 4,
          child: Column(
            children: [
              Expanded(
                child: Image.network(photo.thumbnailUrl, fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(6),
                child: Text(
                  photo.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
