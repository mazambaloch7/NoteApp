import 'package:flutter/material.dart';
import 'package:flutter_note_app/provider/note_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/Notes.dart';

class AddNewNotePage extends StatefulWidget {
  final bool isUpdate;
  final Note? note;

  const AddNewNotePage({Key? key, required this.isUpdate, this.note})
      : super(key: key);

  @override
  State<AddNewNotePage> createState() => _AddNewNotePageState();
}

class _AddNewNotePageState extends State<AddNewNotePage> {
  FocusNode noteFocuse = FocusNode();

  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  void addNewNote() {
    Note newNote = Note(
        id: const Uuid().v1(),
        userid: "AzamKhan",
        title: titleController.text,
        content: contentController.text,
        dateAdded: DateTime.now());
    Provider.of<NoteProvider>(context, listen: false).addNote(newNote);
    Navigator.pop(context);
  }

  void updateNoteFun() {
    widget.note!.title = titleController.text;
    widget.note!.content = contentController.text;
    widget.note!.dateAdded = DateTime.now();
    Provider.of<NoteProvider>(context, listen: false).updateNote(widget.note!);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      titleController.text = widget.note!.title!;
      contentController.text = widget.note!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new Note"),
        actions: [
          IconButton(
              onPressed: () {
                if (widget.isUpdate) {
                  //update function
                  updateNoteFun();
                } else {
                  //add function
                  addNewNote();
                }
              },
              icon: Icon(Icons.check))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                autofocus: (widget.isUpdate == true) ? false : true,
                onSubmitted: (value) {
                  if (value != "") {
                    noteFocuse.requestFocus();
                  }
                },
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                  hintText: "Title",
                ),
              ),
              Expanded(
                child: TextField(
                  controller: contentController,
                  focusNode: noteFocuse,
                  maxLines: null,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      hintText: "Description", border: InputBorder.none),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
