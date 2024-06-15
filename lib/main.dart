import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/note_provider.dart';
import './screens/home_screen.dart';
import './screens/note_detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => NoteProvider(),
      child: MaterialApp(
        title: 'Google Keep Clone',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.yellow,
          ).copyWith(
            secondary: Colors.orange,
          ),
        ),
        home: HomeScreen(),
        routes: {
          '/note-detail': (ctx) => NoteDetailScreen(),
        },
      ),
    );
  }
}
