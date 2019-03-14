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
      title: 'Startup Name Generator',
      home: RandomWords(),
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
  // Prefixing an identifier with an underscore enforces privacy in the Dart language.
  // Keeps generated word pairs.
  final List<WordPair> _suggestions = <WordPair>[];

  // Stores the word pairings that the user favorited
  // (set does not allow duplicates).
  final Set<WordPair> _saved = new Set<WordPair>();

  // Needed to make font larger.
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    // Notice that state builds widget.
    // The Scaffold widget, from the Material library, provides a default app bar,
    // a title, and a body property that holds the widget tree for the home screen.
    return Scaffold (
      appBar: AppBar(
        title: Text('Startup Name Generator'),
      ),
      body: _buildSuggestions(),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        // The itemBuilder callback is called once per suggested
        // word pairing, and places each suggestion into a ListTile
        // row. For even rows, the function adds a ListTile row for
        // the word pairing. For odd rows, the function adds a
        // Divider widget to visually separate the entries. Note that
        // the divider may be difficult to see on smaller devices.
        itemBuilder: (BuildContext _context, int i) {
          // Add a one-pixel-high divider widget before each row
          // in the ListView.
          if (i.isOdd) {
            return Divider();
          }

          // The syntax "i ~/ 2" divides i by 2 and returns an
          // integer result.
          // For example: 1, 2, 3, 4, 5 becomes 0, 1, 1, 2, 2.
          // This calculates the actual number of word pairings
          // in the ListView,minus the divider widgets.
          final int index = i ~/ 2;
          // If you've reached the end of the available word
          // pairings...
          if (index >= _suggestions.length) {
            // ...then generate 10 more and add them to the
            // suggestions list.
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        }
    );
  }

  Widget _buildRow(WordPair pair) {
    // Check to ensure that a word pairing has not already been added to favorites.
    final bool alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      // This adds an icon at the end of the list item
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
    );
  }
}

// This is stateful widget
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}

