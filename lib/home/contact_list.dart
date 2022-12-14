import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({super.key});

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerFont = const TextStyle(fontSize: 18);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Universal App'), actions: [
        IconButton(
          onPressed: _pushSaved,
          icon: const Icon(Icons.list),
        ),
      ]),
      body: ListView.builder(
          padding: const EdgeInsets.all(16.0),
          itemBuilder: (context, i) {
            if (i.isOdd) return const Divider();
            final index = i ~/ 2;
            if (index >= _suggestions.length) {
              _suggestions.addAll(generateWordPairs().take(10));
            }
            final alreadSaved = _saved.contains(_suggestions[index]);
            return ListTile(
              leading: const Icon(Icons.face),
              title: Text(
                _suggestions[index].asPascalCase,
                style: _biggerFont,
              ),
              subtitle:
                  const Text('4123 Bringhan Drive, Charlotte - NC, 28002'),
              isThreeLine: true,
              trailing: Icon(
                alreadSaved ? Icons.favorite : Icons.favorite_border,
                color: alreadSaved ? Colors.red : null,
                semanticLabel: alreadSaved ? 'Remove from saved' : 'Save',
              ),
              onTap: () {
                setState(() {
                  if (alreadSaved) {
                    _saved.remove(_suggestions[index]);
                  } else {
                    _saved.add(_suggestions[index]);
                  }
                });
              },
            );
          }),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      // Add lines from here...
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
                  context: context,
                  tiles: tiles,
                ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ), // ...to here.
    );
  }
}
