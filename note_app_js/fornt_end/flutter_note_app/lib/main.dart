import 'package:flutter/material.dart';
import 'package:flutter_note_app/pages/home_page.dart';
import 'package:flutter_note_app/provider/note_provider.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

Logger logger = Logger();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NoteProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false, title: 'OS', home: HomePage()),
    );
  }
}
