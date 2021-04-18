import 'package:easy_english/services/auth.dart';
import 'package:easy_english/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomInset : false,
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 48),
              Icon(Icons.person_outlined, color: Colors.deepPurple[200], size: 140),
              SizedBox(height: 13),
              Text("Welcome to Easy English!", style: TextStyle(
                color: Colors.deepPurple[600],
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: "OrelegaOne-Regular",
              ),),
              Text("Sign in to continue", style: TextStyle(
                height: 5,
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.deepPurple[200],

              ),
              ),

              Container(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20.0),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: ' Enter email',
                          fillColor: Colors.deepPurple[100],
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white, width: 2.0),
                              borderRadius:
                              BorderRadius.all(Radius.circular(30))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.deepPurple[100],
                                  width: 2.2)),
                        ),
                        validator: (val) =>
                        val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                        decoration: InputDecoration(
                          hintText: ' Enter password',
                          fillColor: Colors.deepPurple[100],
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white, width: 2.0),
                              borderRadius:
                              BorderRadius.all(Radius.circular(30))),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.deepPurple[100],
                                  width: 2.2)),
                        ),
                        validator: (val) => val.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),

                      SizedBox(
                        height: 40.0,
                        width: double.infinity,



                      ),

                      ElevatedButton(

                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                          primary: Colors.deepPurple[400], // background
                          onPrimary: Colors.white, // foreground

                        ),
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result =
                            await _auth.signInWithEmailAndPassword(
                                email, password);
                            if (result == null) {
                              setState(() {
                                error = 'Could not sign in!';
                                loading = false;
                              });
                            }
                          }
                        },
                      ),



                      SizedBox(height: 15.0),
                      Text(
                        error,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14.0,
                        ),
                      ),


                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text("Haven't acount?"),

                          SizedBox(
                            height: 30,

                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: <Widget>[
                                FlatButton.icon(
                                    onPressed: () {
                                      widget.toggleView();
                                    },

                                    icon: Icon(Icons.person, color: Colors.deepPurple[300]),
                                    label: Text('Register now',
                                        style: TextStyle(color: Colors.deepPurple[300]),
                                        textDirection: TextDirection.ltr,

                                        textAlign: TextAlign.center)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
