import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note_app/models/Notes.dart';
import 'package:flutter_note_app/pages/add_page.dart';
import 'package:flutter_note_app/provider/note_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    NoteProvider noteProvider = Provider.of<NoteProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Note App")),
      body: (noteProvider.isloading == false)
          ? SafeArea(
              child: (noteProvider.notes.length > 0)
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemCount: noteProvider.notes.length,
                      itemBuilder: (context, index) {
                        Note currentNote = noteProvider.notes[index];
                        return GestureDetector(
                          onTap: () {
                            //on update functoin
                            Navigator.push(
                                context,
                                CupertinoPageRoute(
                                    builder: (context) => AddNewNotePage(
                                          isUpdate: true,
                                          note: currentNote,
                                        )));
                          },
                          onLongPress: () {
                            //onDelete functoin
                            noteProvider.deleteNote(currentNote);

                            /*              const snackdemo = SnackBar(
                  content: Text('Hii this is GFG\'s SnackBar'),
                  backgroundColor: Colors.green,
                  elevation: 10,
                  behavior: SnackBarBehavior.floating,
                  margin: EdgeInsets.all(5),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackdemo);
      
           */
                            final snackBar = SnackBar(
                              content: const Text('Note deleted'),
                              action: SnackBarAction(
                                label: '',
                                onPressed: () {
                                  // Some code to undo the change.
                                },
                              ),
                            );

                            // Find the ScaffoldMessenger in the widget tree
                            // and use it to show a SnackBar.
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          },
                          child: Container(
                            margin: EdgeInsets.all(10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.grey, width: 2)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentNote.title!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  currentNote.content!,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text("No Data Founded"),
                    ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (context) => AddNewNotePage(
                  isUpdate: false,
                ),
              ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
