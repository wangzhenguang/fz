import 'package:flutter/material.dart';
import 'package:hello_flutter/RandomWords.dart';
import 'package:english_words/english_words.dart';

class RandowmWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);
  final _saved = new Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("startUp name generator"),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: _pushSave)
        ],
      ),
      body: _buildSuggestions(),
    );

//    return _buildSuggestions();
  }

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, i) { // todo 这里的多条数据是如何确定的
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair wordPair) {
    final alreadySave = _saved.contains(wordPair);

    return new ListTile(
      title: new Text(
        wordPair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySave ? Icons.favorite : Icons.favorite_border,
        color: alreadySave ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySave)
            _saved.remove(wordPair);
          else
            _saved.add(wordPair);
        });
      },
    );
  }

  void _pushSave() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      final titles = _saved.map((pair) {
        return new ListTile(
          title: new Text(
            pair.asPascalCase,
            style: _biggerFont,
          ),
        );
      });
      final divided =
          ListTile.divideTiles(tiles: titles, context: context).toList();
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("save suggestions"),
        ),
        body: new ListView(children: divided),
      );
    }));
  }
}
