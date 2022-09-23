import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_note_app/main.dart';
import 'package:flutter_note_app/models/Notes.dart';
import 'package:flutter_note_app/services/api_services.dart';

class NoteProvider extends ChangeNotifier {
  bool isloading = false;

  List<Note> notes = [];

  NoteProvider() {
    fetchNotes();
  }

  void sortNot() {
    notes.sort(
      (a, b) => b.dateAdded!.compareTo(a.dateAdded!),
    );
  }

  void addNote(Note note) {
    notes.add(note);
    sortNot();
    notifyListeners();
    ApiServices.addNote(note);
  }

  void updateNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;
    sortNot();
    notifyListeners();
    ApiServices.addNote(note);
  }

  void deleteNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    sortNot();
    notifyListeners();
    ApiServices.deleteNote(note);
    logger.d("Note deleted on the long press ");
    log("message: note detelte ");
  }

  void fetchNotes() async {
    notes = await ApiServices.fetchNotes("AzamKhan");
    isloading = false;
    sortNot(); 
    notifyListeners();
    log("message: note gets in the list forms ");
    logger.d("datafatching   list :   ${notes}");
  }
}
