import 'package:flutter/material.dart';
import '../models/note_model.dart';
import 'dart:math';

class NoteProvider with ChangeNotifier {
  List<Note> _notes = [];

  List<Color> _colors = [
    Colors.red[100]!,
    Colors.blue[100]!,
    Colors.green[100]!,
    Colors.yellow[100]!,
    Colors.orange[100]!,
    Colors.purple[100]!,
    Colors.pink[100]!,
  ];

  List<Note> get notes => _notes;

  void addNote(Note note) {
    _notes.add(note);
    notifyListeners();
  }

  void removeNoteById(String id) {
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }

  void updateNote(String id, Note newNote) {
    final noteIndex = _notes.indexWhere((note) => note.id == id);
    if (noteIndex >= 0) {
      _notes[noteIndex] = newNote;
      notifyListeners();
    }
  }

  Note findById(String id) {
    return _notes.firstWhere((note) => note.id == id);
  }

  Color getRandomColor() {
    final random = Random();
    return _colors[random.nextInt(_colors.length)];
  }

  List<Note> searchNotes(String query) {
    return _notes.where((note) {
      final titleLower = note.title.toLowerCase();
      final contentLower = note.content.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) || contentLower.contains(searchLower);
    }).toList();
  }
}
