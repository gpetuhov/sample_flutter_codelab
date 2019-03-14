import 'package:flutter/material.dart';

// Import external packages like this to use them
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

// The app itself is a widget.
// Stateless widgets are immutable, meaning that their properties can't change—all values are final.
class MyApp extends StatelessWidget {
  // A widget's main job is to provide a build method
  // that describes how to display the widget in terms of other, lower-level widgets
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Startup Name Generator',
      // This changes the theme of the app
      // (if not specified, default theme is used, which is dependent on physical device).
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
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
  final Set<WordPair> _saved = Set<WordPair>();

  // Needed to make font larger.
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    // Notice that state builds widget.
    // The Scaffold widget, from the Material library, provides a default app bar,
    // a title, and a body property that holds the widget tree for the home screen.
    return Scaffold(
      appBar: AppBar(
        title: Text('Startup Name Generator'),
        // This adds action icons to the toolbar
        // (some widgets, such as action, take an array of widgets (children),
        // as indicated by the square brackets [] )
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ],
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
        });
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
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        // Calling setState() triggers a call to the build() method for the State object,
        // resulting in an update to the UI.
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  // This opens new page that displays favorites.
  // In Flutter pages (screens) are called Routes.
  // Navigator manages a stack containing the app's routes.
  // We don't have to start new activity like in native Android app.
  // All Flutter routes are displayed inside a single activity.
  void _pushSaved() {
    // Note that the Navigator adds a "Back" button to the app bar.
    Navigator.of(context).push(
      // The content for the new page is built in MaterialPageRoute's
      // builder property, in an anonymous function.
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          // Here we generate ListTile rows from the set of favorites
          final Iterable<ListTile> tiles = _saved.map(
            (WordPair pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );

          // The divideTiles() method of ListTile adds horizontal spacing
          // between each ListTile. The divided variable holds the final rows,
          // converted to a list.
          final List<Widget> divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          // The builder property returns a Scaffold, containing the app bar for the new route,
          // named "Saved Suggestions." The body of the new route consists of a ListView
          // containing the ListTiles rows; each row is separated by a divider.
          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}

// This is stateful widget
class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => new RandomWordsState();
}
