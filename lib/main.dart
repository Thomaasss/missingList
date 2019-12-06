// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tableau d\'appel',
      theme: ThemeData(          // Add the 3 lines from here... 
        primaryColor: Colors.deepOrange[300],
      ),    
      home: RandomWords(),
    );
  }
}

// Class
// Stateful widget : Mutable
// 1) A StatefulWidget class that creates an instance of
// 2) a State Class

class RandomWordsState extends State<RandomWords> { // RandomWordsState = Immutable
  
  @override

  final _suggestions = <WordPair>[];
  final Set<WordPair> _saved = Set<WordPair>();   // "Set" because elements can be saved only one time (not the case for "List").
  final _biggerFont = const TextStyle(fontSize: 18.0);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des élèves'),
        actions: <Widget>[      // Add 3 lines from here...
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],     
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
      Navigator.of(context).push(
        MaterialPageRoute<void>(   // Add 20 lines from here...
      builder: (BuildContext context) {
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
        final List<Widget> divided = ListTile
          .divideTiles(
            context: context,
            tiles: tiles,
          )
          .toList();
          return Scaffold(         // Add 6 lines from here...
          appBar: AppBar(
            title: Text('Liste des absents'),
          ),
          body: ListView(children: divided),
        );     
      },
    ),              
  );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i.isOdd) return Divider(); /*2*/

          final index = i ~/ 2; /*3*/
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10)); /*4*/
          }
          return _buildRow(_suggestions[index]);
    });
  }

  Widget _buildRow(WordPair pair) {
    final bool alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(   // Add the lines from here... 
        alreadySaved ? Icons.assignment_turned_in : Icons.assignment_turned_in,
        color: alreadySaved ? Colors.green : null,
      ),    
      onTap: () {      // Add 9 lines from here...
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else { 
            _saved.add(pair); 
          } 
        });
      },                // ... to here.
    );
  }
}

class RandomWords extends StatefulWidget { // RandomWords = Mutable
  
  @override
  RandomWordsState createState() => RandomWordsState();

}
