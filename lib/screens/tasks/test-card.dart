import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_english/models/user.dart';

class TestCard extends StatefulWidget {
  @override
  _TestCardState createState() => _TestCardState();
}
  int count;
class _TestCardState extends State<TestCard> {

  Future getWords() async {
    final user = Provider.of<User>(context);
    var firestore = Firestore.instance;

    QuerySnapshot wordsSnap = await firestore.collection('words').document(user.uid).collection('words').getDocuments();
    count = wordsSnap.documents.length;
    return wordsSnap.documents;

  }


  var random = new Random();
  
  bool randBool() {
    return random.nextBool();
  }

  List<bool> rightAnswers = [];
  List<bool> userAnswers = [];
  
  int randIndex(index) {
    if(randBool()) {
      rightAnswers.add(true);
      return index;
    }
    else {
      rightAnswers.add(false);
      return random.nextInt(9);
    }
  }

  String checkResults(List l1, List l2) {
    String res = '';
    int result = 0;
    for( int i = 0; i <count; i++){
      if(l1[i] == l2[i]){
        result += 1;
      }
    }
    res = '$result / $count';
    return res;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        elevation: 2,
        title: Text('Quick Test'),
        actions: <Widget>[
          FlatButton (
            color: Colors.white,
            textColor: Colors.deepPurple[300],
            child: Text('Check'),
            onPressed:() => showDialog(
              context: context,
              builder: (context) => myAlert(),
            )
          )
        ],
      ),
      body: FutureBuilder(
        future: getWords(),
          builder: (context, snapchot ){
          return ListView.builder(
            itemCount: count,
              itemBuilder: (context, index){
                  return SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(10,10,10,0),
//                    height: 150,
                    //title: Text(snapchot.data[index].data["word"]),

                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: new BorderSide(color: Colors.deepPurple[200], width: 2.0),
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      color: Colors.white,
                      elevation: 2,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        // !!!!!
                        // коментар ЖЕНІ ToDo
                        // ці карточки треба зробити вужчими і по центру,
                        //я пробувала то зробити сама, але вони все рівно ідуть за шириною контейнера
                        // !!!!
                        children: <Widget>[
                          new ListTile(
                            title: Text(snapchot.data[index].data["word"], style:TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text(snapchot.data[randIndex(index)].data["translate"], style:TextStyle(fontWeight: FontWeight.bold)),
                            onTap: () {
                              print(rightAnswers);

                            },
                          ),
                          ButtonBar(
                            children: <Widget>[
                              FlatButton(

                                child: Text('Wrong',style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                                onPressed: (){
                                  userAnswers.add(false);
                                },
                              ),
                              FlatButton(

                                child: Text('Right', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                                onPressed: () {
                                  userAnswers.add(true);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
              });
      }
     ),
    );
  }

  //ToDo
  //зробти цей алєрт хоч трохи презентабельним
  Widget myAlert() {
    return  AlertDialog(
      title: Text(
        'Your result is',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 21.0,
        ),
      ),
      content: Text(
        checkResults(rightAnswers, userAnswers).toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 19.0,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok ;)', style: TextStyle(color: Colors.deepPurple[200],)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

}

