import 'package:flutter/material.dart';
import 'package:portflolio/views/main_dashboard.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final PageStorageBucket bucket = PageStorageBucket();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PageStorage(// preserves the state of widgets when they are destroyed and rebuilt, especially in cases like navigation, tabs, or scrolling.
        bucket: bucket, // → stores the saved states
        child: const MainDashBoard(),
      ),
    );
  }
}

