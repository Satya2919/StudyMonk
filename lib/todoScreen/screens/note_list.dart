import 'package:flutter/material.dart';
import 'dart:async';
import '../database_helper.dart';
import '../model/Note.dart';
import 'note_details.dart';
import 'package:sqflite/sqflite.dart';
import 'package:kf_drawer/kf_drawer.dart';

//so these screen is basically to display floating action button that will take us to next screen

class NoteList extends KFDrawerContent {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count =0;

  @override
  Widget build(BuildContext context) {
    // last part
    if(noteList==null){
      noteList = List<Note>();
      updateListView();
    }
    return Scaffold(
       appBar: AppBar(
         title: Text('TODO',textAlign: TextAlign.center,),
         backgroundColor: Colors.purple[200],
         leading: IconButton(
             alignment: Alignment.center,
              icon: Icon(
                  Icons.menu,
                 color: Colors.black,
                ),
                 onPressed: widget.onMenuPressed,
               ),
       ),
       body: Center(
         child: noteList.isEmpty
             ? Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                  Container(
                      height: 200,
                      child: Image.asset(
                        'assets/images/clipboard1.png',
                        fit: BoxFit.cover,
                      )),
               ],
             )
             :getNoteListView(),
       ),
       floatingActionButton: FloatingActionButton(
         backgroundColor: Colors.blue,
         child: Icon(Icons.add),
         onPressed: (){
           navigateToDetail(Note('','',2), 'Add Note'); // that argument ..go to note.dart and see wt u r passing
           //9. we can say that we are fooling out application because details will be filled in the next screen
         },
       ),

    );
    
  }

  //after 5
  ListView getNoteListView(){
    return ListView.builder(
        itemCount: count,
        itemBuilder: (context, position){
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)
              ),
              color: Colors.blueAccent,
              elevation: 4.0,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage("https://learncodeonline.in/mascot.png"),
                ),
                title: Text(this.noteList[position].title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                )
                ),
                subtitle: Text(this.noteList[position].date,
                style: TextStyle(
                  color: Colors.white
                ),
                ),
                trailing: GestureDetector(
                  child: Icon(Icons.open_in_new, color: Colors.white),
                  onTap: () {
                    navigateToDetail(this.noteList[position], 'Edit Todo');
                  },
              ),
              )
          );
        },
    );
  }
  
  void navigateToDetail(Note note, String title) async {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context){
        
        return NoteDetail(note, title);

    }));

    if(result == true){
      //TODO update the view
      updateListView();
    }
  }
  // afrer notedetail  ..so here actually we are updating our notelist
  void updateListView(){
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    //now based on what coming up in the future we can provide a then case
    //if we get a database
    dbFuture.then((database){
       Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
       noteListFuture.then((noteList){
         setState(() {
          this.noteList = noteList;
          this.count = noteList.length; 
         });
       });
    });

   //5 now all vthe values will be stored into the listview
  }


}