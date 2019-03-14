import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  // A widget's main job is to provide a build method
  // that describes how to display the widget in terms of other, lower-level widgets
  @override
  Widget build(BuildContext context) {
    // The app itself is a widget
    return new MaterialApp(
      title: 'Welcome to Flutter',
      // The Scaffold widget, from the Material library, provides a default app bar,
      // a title, and a body property that holds the widget tree for the home screen
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        // The Center widget aligns its widget subtree to the center of the screen
        body: const Center(
          child: const Text('Hello World'),
        ),
      ),
    );
  }
}
