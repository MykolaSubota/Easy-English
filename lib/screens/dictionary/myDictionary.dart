import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_english/models/word.dart';
import 'package:easy_english/models/user.dart';
import 'package:easy_english/screens/dictionary/words_list.dart';
import 'package:easy_english/screens/tasks/quick-test.dart';
import 'package:easy_english/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class MyDictionary extends StatefulWidget {
  @override
  _MyDictionaryState createState() => _MyDictionaryState();
}

class _MyDictionaryState extends State<MyDictionary> {
  String word;
  String translation;
  String synonyms;


  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamProvider<List<Word>>.value(
      value: DatabaseService(uid: user.uid).words,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[300],
          elevation: 2,
          title: Text('My Dictionary'),
        ),
        body: WordsList(),
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22.0),
          tooltip: 'Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
              child: Icon(Icons.add),
              backgroundColor: Colors.Colors.deepPurple[200],
              elevation: 0.0,
              label: 'Add new word',
              labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                  fontSize: 16.0
              ),
              onTap: () {
                return Alert(
                    context: context,
                    title: 'Add new word',
                    content: Form(
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'new word',
                            ),
                            onChanged: (val) {
                              setState(() {
                                word = val;
                              });
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'translation',
                            ),
                            onChanged: (val) {
                              setState(() {
                                translation = val;
                              }); },
                          ),

                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'synonyms',
                            ),
                            onChanged: (val) {
                              setState(() {
                                synonyms = val;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    buttons: [
                      DialogButton(child: Text('Add', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), color: Colors.lightBlue[900], radius: BorderRadius.all(Radius.circular(20)), onPressed: () {
                        if( word != null && translation != null && synonyms != null)
                          Firestore.instance.collection('words').document(user.uid).collection('words').document(word)
                              .setData(
                              {
                                'word': word,
                                'translate': translation,
                                'synonyms': synonyms,
                              }
                          );
                        Navigator.pop(context);
                      },)
                    ]
                ).show();
              },
            ),
            SpeedDialChild(
              child: Icon(Icons.check),
              backgroundColor: Colors.green,
              label: 'Test yourself',
              labelStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0
              ),
              onTap: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => QuickTest()),
                );
              }
            )
          ],
        ),

      ),
    );
  }
}
