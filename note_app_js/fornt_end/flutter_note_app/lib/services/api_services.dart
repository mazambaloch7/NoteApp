import 'dart:convert';
import 'dart:developer';

import 'package:flutter_note_app/main.dart';
import 'package:flutter_note_app/models/Notes.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  static String _baseUrl = "https://damp-stream-53441.herokuapp.com/notes";

  // adding the new note in the note
  static Future<void> addNote(Note note) async {
    Uri requestUri = Uri.parse(_baseUrl + "/add");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    // log("${decoded.toString()}");
    logger.d(decoded.toString());
    log(decoded.toString());
  }

  // for the deleteing the message
  static Future<void> deleteNote(Note note) async {
    Uri requestUri = Uri.parse(_baseUrl + "/delete");
    var response = await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    logger.d("delete fuction response :  ${decoded.toString()}");
    log(decoded.toString());
  }

  /*static Future<List<Note>> fetchNotes(String userid) async {
    Uri requestUri = Uri.parse(_baseUrl + "/delete");
    var response = await http.post(requestUri, body: {"userid": userid});
    var decoded = jsonDecode(response.body);

    List<Note> notes = [];
    for (var noteMap in decoded) {
      Note newNote = Note.fromMap(noteMap);
      notes.add(newNote);
    }
    return notes;

    */ /*
    logger.d("datafatching the list :  ${decoded.toString()}");
    return [];
*/ /*
  }*/

  static Future<List<Note>> fetchNotes(String userid) async {
    Uri requestUri = Uri.parse(_baseUrl + "/list");
    var response = await http.post(requestUri, body: {"userid": userid});
    var decoded = jsonDecode(response.body);

    List<Note> notes = [];
    for (var noteMap in decoded) {
      Note newNote = Note.fromMap(noteMap);
      notes.add(newNote);
      log("message list of the notes in the for loop ${notes}");
    }
    log(decoded.toString());
    log("message list of the notes out side of the nodes ${notes}");

    return notes;
  }
}
