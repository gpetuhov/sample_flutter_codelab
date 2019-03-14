import 'package:flutter/material.dart';

// Import external packages like this to use them
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

// The app itself is a widget.
// Stateless widgets are immutable, meaning that their properties can't change—all values are final.
class MyApp extends StatelessWidget {

  // A widget's main job is to provide a build method
  // that describes how to display the widget in terms of other, lower-level widgets
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      // The Scaffold widget, from the Material library, provides a default app bar,
      // a title, and a body property that holds the widget tree for the home screen
      home: new Scaffold(
        appBar: new AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        // The Center widget aligns its widget subtree to the center of the screen
        body: Center(
          child: RandomWords(),
        ),
      ),
    );
  }
}

// Stateful widgets maintain state that might change during the lifetime of the widget.
// Implementing a stateful widget requires at least two classes:
// 1) a StatefulWidget class that creates an instance of 2) a State class.
// The StatefulWidget class is, itself, immutable,
// but the State class persists over the lifetime of the widget.

// This is the state of RandomWords widget
// (notice that Dart can contain many classes in one file).
class RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    // Create a pair of random words (using english_words package)
    final WordPair wordPair = WordPair.random();
    // Notice that state builds widget
    return Text(wordPair.asPascalCase);
  }
}

// This is stateful widget
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

