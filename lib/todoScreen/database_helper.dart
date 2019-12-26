//we need this file because we dont want it in our ui part so all the heavy lifting duty
//like creating..deleting note will be done here...in notedetail and note_lst we wll call it..

//two method to be used factory and future..
//factory is singleton object--> which runs once at a time


import '../todoScreen/model/Note.dart'; //this is the object will be retrieving and saving in the database
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';//writing into file
import 'package:path_provider/path_provider.dart';

class DatabaseHelper{
  
  //these two are used to talk to the database
  static DatabaseHelper _databaseHelper; //this is singleton
  static Database _database; //singleton

  //5
  String noteTable = 'note_table'; 
  String colID = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colPriority = 'priority';
  String colDate = 'date';

  DatabaseHelper._createInstance(); //named constructuot responsible for creaating the database..

  //6 .. u want to create a database again and again whenever somebody saves a thing..or u want to just invoke on db
  //so factory is used ..
 //singleton object to get a database instance only once
  factory DatabaseHelper(){
    if(_databaseHelper == null){
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }
  //above will execute only once..

  //inititalise the db
  //future will return database
  //custom getter for database

  Future<Database> get database async{
    if(_database == null){
      _database = await initializeDatabase();
    }
    return _database;

  }
  
  //finding the database and opening that file
  //actual initialisation is done here
  Future<Database>initializeDatabase() async {
    
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'notes.db';

    var notesDatabase = await openDatabase(
      path,version: 1, onCreate: _createDb
    );
    return notesDatabase;
  }
  
  //create the database
  //this runs for very first time when the database is invoked
  void _createDb(Database db, int newVersion) async {
     await db.execute(
      'CREATE TABLE $noteTable ($colID INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDescription TEXT, $colPriority INTEGER, $colDate TEXT)'); 
  }
  //now perform fetch operation to get all note object
  //this is used to get the value from the database
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;
    //below is same as ...db.rawquery(SELECT * from notetable order by $ colpriprp...)
    var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    return result;
  }

 //7 future will be in integer format to check whteher the operation was succefull or not
 //someone should be aware of note class and sending object of the note class
  Future<int> insertNote(Note note) async{
    //we need referance to the database
      Database db = await this.database;
      var result = await db.insert(noteTable, note.toMap());
      return result;
      //note object is getting values from ui.. 
  }
  Future<int> updateNote(Note note) async{
    Database db = await this.database;
    var result = await db.update(noteTable, note.toMap(),
    where: '$colID = ?', whereArgs: [note.id]);
    return result;
  }
  Future<int> deleteNote(int id) async{
    Database db = await this.database;
    var result = await db.rawDelete('DELETE FROM $noteTable where $colID = $id');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $noteTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }
  //9.finally we are converting everthing from notelist into map list because map is going to get displayed on ui not notelist
  Future<List<Note>> getNoteList() async{
    // get a map list from db that we have defined
     var noteMapList = await getNoteMapList();
     //we are counting it because we want to loop through it
     int count = noteMapList.length;

     List<Note> noteList = List<Note>();
     for(var i=0; i<count; i++)
     {
       noteList.add(Note.fromMapObject(noteMapList[i]));
     }
     return noteList;
     
  }

}


