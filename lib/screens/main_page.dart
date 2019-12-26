import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';

class MainPage extends KFDrawerContent {
  MainPage({
    Key key,
  });

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue[100],
                      offset: Offset(0.0, 2.0),
                      blurRadius: 6.0
                    )
                  ]
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.asset(
                    'images/space.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              IconButton(
                padding: EdgeInsets.symmetric(horizontal: 23.0, vertical: 40.0),
                icon: Icon(Icons.menu),
                iconSize: 30.0,
                color: Colors.black,
                onPressed: widget.onMenuPressed,
              ),
              Container(
                margin: EdgeInsets.only(top: 70,left: 20),
                child: Row(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(10.0, 30.0, 20.0, 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orangeAccent[100],
                          offset: Offset(0.0, 2.0),
                          blurRadius: 6.0
                    )
                      ], 
                      ),
                      child: Image.asset('images/monk.png')
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[ 
                        Row(
                          children: <Widget>[
                            Text('Hi Satyam ',
                            style: TextStyle(
                              fontSize: 20.0,
                            ),
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              iconSize: 20.0,
                              color: Colors.black,
                              onPressed: () => {},
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text('Star Commander',
                        style: TextStyle(
                           fontSize: 16.0
                        ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Positioned(
                 bottom: -20,
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container( 
                      height: 120.0,
                      child: Image.asset('images/star.png')
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 70),
                      child: Card(
                       elevation: 5,
                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(15.0)
                       ),
                         child: Container(
                            margin: EdgeInsets.all(20),
                            child: Text('Points'),
                         )
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: ListView(
              children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              height: 150,
              width: 100,
              child: Card(
                elevation: 30,
                color: Colors.yellow[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  
                  children: <Widget>[
                    Container(
                      child: Image.asset('images/college.png',
                      height: 300),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 40, 10, 0),
                          height: 20,
                          child: Text('College LeaderBoard',
                          style: TextStyle(
                            fontSize: 17
                          ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Rank: ')
                      ],
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              height: 150,
              width: 100,
              child: Card(
                elevation: 30,
                color: Colors.orangeAccent[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  
                  children: <Widget>[
                    Container(
                      child: Image.asset('images/club.png',
                      height: 300),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 40, 10, 0),
                          height: 20,
                          child: Text('Club LeaderBoard',
                          style: TextStyle(
                            fontSize: 17
                          ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Rank: ')
                      ],
                    )
                  ],
                ),
              ),
            ),
             Container(
              margin: EdgeInsets.all(10),
              height: 150,
              width: 100,
              child: Card(
                elevation: 30,
                color: Colors.greenAccent[100],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  
                  children: <Widget>[
                    Container(
                      child: Image.asset('images/team.png',
                      height: 300),
                    ),
                    Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 40, 10, 0),
                          height: 20,
                          child: Text('Team LeaderBoard',
                          style: TextStyle(
                            fontSize: 17
                          ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Rank: ')
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
            ),
          )
         
        ],
      ),
    );
  }
}
