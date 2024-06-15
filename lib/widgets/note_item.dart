import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/note_model.dart';
import '../providers/note_provider.dart';

class NoteItem extends StatelessWidget {
  final Note note;

  NoteItem({required this.note});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: note.color,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 6),
            Text(note.content),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  icon: Icon(Icons.edit, size: 20),
                  onPressed: () {
                    Navigator.of(context).pushNamed(
                      '/note-detail',
                      arguments: note.id,
                    );
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, size: 20),
                  onPressed: () {
                    Provider.of<NoteProvider>(context, listen: false).removeNoteById(note.id);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
