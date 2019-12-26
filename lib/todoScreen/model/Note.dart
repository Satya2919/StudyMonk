//1
class Note{
 
  int _id;
  String _title;
  String _description;
  String _date;
  int _priority;

  //2.constructor
  // id is there because we wont pass id as it is genearated by the database
  Note(this._title,this._date,this._priority,[this._description]);

  //3 we have used many builder like listview builder...so at the time o editing we can call it as
  //class is already created but we still want to call it to edit it further.
  Note.withId(this._id,this._title,this._date,this._priority,[this._description]);

  //3.getters 
  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get date => _date;
  int get priority => _priority;

  //4.setter
  set title(String newTitle)
  {
    if(newTitle.length<=255){
      this._title = newTitle;
    }
  }
  set description(String newDescription)
  {
    if(newDescription.length<=255){
      this._description = newDescription;
    }
  }
  set date(String newDate)
  {
      this._date = newDate; 
  }
  set priority(int newPriority)
  {
    if(newPriority >= 1 && newPriority<=2){
      this._priority = newPriority;
    }
  }
  
 //5one problem till now is that we need to separately fill the value hence create map so that in one call everything just happens
//used to save and retrieve from db
//used to create note object into map object
Map<String, dynamic> toMap(){
  var map = Map<String,dynamic>(); //its like creating an object
  //we we use this method at two places..one when directly directly create an object
  //the next when we need to edit..if id is not null means id is alredy present in db
  //8 ..u will see this id..descroption is the column of table..
  if(id!=null){
    map['id'] = _id;
  }
  map['title'] = _title;
  map['description'] = _description;
  map['priority'] = _priority;
  map['date'] = _date;
  return map;
}

//so it will expect u to pass a map and it will insert the value into the equivalent best places
//map object to note object
Note.fromMapObject(Map<String, dynamic> map){
  this._id = map['id'];
  this._title = map['title'];
  this._description = map['description'];
  this._priority = map['priority'];
  this._date = map['date'];
}




}