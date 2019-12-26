import 'package:flutter/material.dart';
import '../model/Note.dart';
import '../database_helper.dart';
import 'package:intl/intl.dart';

class NoteDetail extends StatefulWidget {
  
   final String appBarTitle;
   final Note note;

   NoteDetail(this.note,this.appBarTitle);

   @override
   State<StatefulWidget> createState(){
     return NoteDetailState(this.note, this.appBarTitle);
   }
}

class NoteDetailState extends State<NoteDetail> {
  static var _priorities = ["Club Leader","Team Leader",];
  DatabaseHelper helper = DatabaseHelper();
  String appBarTitle;
  Note note;
   
  NoteDetailState(this.note,this.appBarTitle);

  //1. Declare some text editing controller
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //7 provide a textstyle based on apptitlebar and note itself
    TextStyle textStyle = Theme.of(context).textTheme.title;

    titleController.text = note.title; //in case user is coming baack and note value is filled up
    descriptionController.text = note.description;

    return WillPopScope(
      onWillPop: (){
        moveToLastScreen();
      },
      child: Scaffold(
        backgroundColor: Colors.grey[400],
        appBar: AppBar(
          title: Text(appBarTitle),
          backgroundColor: Colors.purple[300], 
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              moveToLastScreen();
            },
          ),
        ),
        body: Padding(
            padding: EdgeInsets.all(10.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 5.0),
                    //dropdown menu
                    child: new ListTile(
                      leading: const Icon(Icons.low_priority),
                      title: DropdownButton(
                          items: _priorities.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(dropDownStringItem,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red)),
                            );
                          }).toList(),
                          value: getPriorityAsString(note.priority),
                          onChanged: (valueSelectedByUser) {
                            setState(() {
                              updatePriorityAsInt(valueSelectedByUser);
                            });
                          }),
                    ),
                  ),
                  // Second Element
                  Padding(
                    padding:
                        EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0),
                    child: TextField(
                      controller: titleController,
                      style: textStyle,
                      onChanged: (value) {
                        updateTitle();
                      },
                      decoration: InputDecoration(
                        labelText: 'Title',
                        labelStyle: textStyle,
                        icon: Icon(Icons.title),
                      ),
                    ),
                  ),

                  // Third Element
                  Padding(
                    padding:
                        EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0),
                    child: TextField(
                      controller: descriptionController,
                      style: textStyle,
                      onChanged: (value) {
                        updateDescription();
                      },
                      decoration: InputDecoration(
                        labelText: 'Details',
                        icon: Icon(Icons.details),
                      ),
                    ),
                  ),

                  // Fourth Element
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            textColor: Colors.white,
                            color: Colors.green,
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Save',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                debugPrint("Save button clicked");
                                _save();
                              });
                            },
                          ),
                        ),
                        Container(
                          width: 5.0,
                        ),
                        Expanded(
                          child: RaisedButton(
                            textColor: Colors.white,
                            color: Colors.red[400],
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Delete',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () {
                              setState(() {
                                _delete();
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      ),
    );
    
  }
  
  void updateTitle(){
    //user typing in text will be saved in title
    note.title = titleController.text;
  }
  void updateDescription(){
    //user typing in text will be saved in title
    note.description = descriptionController.text;
  }




  //3 how u want to save it..first move back to the screen and then save it 
  void _save() async{
    moveToLastScreen();
    
    note.date = DateFormat.yMMMd().format(DateTime.now());
    int result;
    //first case is if ide is present it means we are updating the note
    if(note.id!=null){
      result = await helper.updateNote(note);
    }else {
      result = await helper.insertNote(note);
    }

    //if result is correctly saved or not
    if(result!=0)
    {
      _showAlertDialog('Status', 'Note Saved Succfully');
    }else{
      _showAlertDialog('Status', 'Problem Saving Note');
    }

  }
  
  //4..delete
  void _delete() async{
    moveToLastScreen();
    //below if means that user has clicked it but not doing anything
    if(note.id==null){
     _showAlertDialog('Status', 'First add a note');
     return;
    }
    int result = await helper.deleteNote(note.id);
    //next we neede to check whether result has something or not
    if(result!=0)
    {
      _showAlertDialog('Status', 'Note Deleted Successfully');
    }else{
      _showAlertDialog('Status', 'Problem Deleting Note');
    }

  }

  //5.. convert to int to save into database

  void updatePriorityAsInt(String value){
    switch (value) {
      case 'Club Leader':
        note.priority =1;
        break;
      case 'Team Leader':
        note.priority = 2;
        break;
    }
  }

  //6 convert int to string to show user
  //when user is trying to edit it and we need to fetch the value from database ..which we give priority as 1 or 2
  // and we are going to convert 1 and 2 into high adn low
  String getPriorityAsString(int value){
    String priority;
    switch (value) {
      case 1:
        priority = _priorities[0];
        break;
      case 2:
        priority = _priorities[1];
        break;
      
    }
    return priority;
  }

  void moveToLastScreen(){
    Navigator.pop(context, true);
  }




  //2 create a helper method..

  void _showAlertDialog(String title, String message){
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );

    showDialog(context: context, builder: (_) => alertDialog);
  }
}