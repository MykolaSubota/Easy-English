import 'package:engapp/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:engapp/screens/navDrawer.dart';
import 'a1.dart';
import 'a2.dart';
import 'b1.dart';
import 'b2.dart';
import 'c1.dart';
import 'c2.dart';

final AuthService _auth = AuthService();

class Levels extends StatefulWidget {
  @override
  _LevelsState createState() => _LevelsState();
}

class _LevelsState extends State<Levels> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('Daily English'),
          backgroundColor: Colors.lightBlue[900],
          elevation: 0.0,
          actions: <Widget>[
            TextButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: Text(
                'Log out',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextButton(
                child: Text(
                  "A1",
                  style: TextStyle(color: Colors.blue, fontSize: 18.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => A1()),
                  );
                },
              ),
              TextButton(
                child: Text(
                  "A2",
                  style: TextStyle(color: Colors.blue, fontSize: 18.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => A2()),
                  );
                },
              ),
              TextButton(
                child: Text(
                  "B1",
                  style: TextStyle(color: Colors.blue, fontSize: 18.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => B1()),
                  );
                },
              ),
              TextButton(
                child: Text(
                  "B2",
                  style: TextStyle(color: Colors.blue, fontSize: 18.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => B2()),
                  );
                },
              ),
              TextButton(
                child: Text(
                  "C1",
                  style: TextStyle(color: Colors.blue, fontSize: 18.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => C1()),
                  );
                },
              ),
              TextButton(
                child: Text(
                  "C1",
                  style: TextStyle(color: Colors.blue, fontSize: 18.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => C2()),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
