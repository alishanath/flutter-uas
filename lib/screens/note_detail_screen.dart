import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/note_provider.dart';
import '../models/note_model.dart';

class NoteDetailScreen extends StatefulWidget {
  @override
  _NoteDetailScreenState createState() => _NoteDetailScreenState();
}

class _NoteDetailScreenState extends State<NoteDetailScreen> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  String? _noteId;

  @override
  void didChangeDependencies() {
    final noteId = ModalRoute.of(context)?.settings.arguments as String?;
    if (noteId != null) {
      final note = Provider.of<NoteProvider>(context, listen: false).findById(noteId);
      _titleController.text = note.title;
      _contentController.text = note.content;
      _noteId = noteId;
    }
    super.didChangeDependencies();
  }

  void _saveNote() {
    if (_titleController.text.isEmpty || _contentController.text.isEmpty) {
      return;
    }
    if (_noteId == null) {
      final newNote = Note(
        id: DateTime.now().toString(),
        title: _titleController.text,
        content: _contentController.text,
        color: Provider.of<NoteProvider>(context, listen: false).getRandomColor(),
      );
      Provider.of<NoteProvider>(context, listen: false).addNote(newNote);
    } else {
      final updatedNote = Note(
        id: _noteId!,
        title: _titleController.text,
        content: _contentController.text,
        color: Provider.of<NoteProvider>(context, listen: false).findById(_noteId!).color,
      );
      Provider.of<NoteProvider>(context, listen: false).updateNote(_noteId!, updatedNote);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_noteId == null ? 'Add Note' : 'Edit Note'),
        backgroundColor: Colors.yellow[700],
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: 'Content',
                border: OutlineInputBorder(),
              ),
              maxLines: 10,
            ),
          ],
        ),
      ),
    );
  }
}
