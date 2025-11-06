import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Function to trigger the build process
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const UrlLauncherExample());
}

class UrlLauncherExample extends StatelessWidget {
  const UrlLauncherExample({Key? key}) : super(key: key);

  // Function to launch URL in the browser
  Future<void> _launchURLBrowser() async {
    final url = Uri.parse("https://www.geeksforgeeks.org/");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  // Function to launch URL in the app
  Future<void> _launchURLApp() async {
    final url = Uri.parse("https://www.geeksforgeeks.org/");
    if (!await launchUrl(url, mode: LaunchMode.inAppWebView)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Geeks for Geeks'),
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
        ),
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Welcome to GFG!',
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _launchURLBrowser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Open in Browser'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _launchURLApp,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Open in App'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
