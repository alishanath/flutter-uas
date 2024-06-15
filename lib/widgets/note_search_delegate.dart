import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import '../widgets/note_item.dart';

class NoteSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);
    final results = noteProvider.searchNotes(query);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          return NoteItem(note: results[index]);
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final noteProvider = Provider.of<NoteProvider>(context);
    final suggestions = noteProvider.searchNotes(query);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          return NoteItem(note: suggestions[index]);
        },
      ),
    );
  }
}
