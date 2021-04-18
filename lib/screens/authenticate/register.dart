import 'package:easy_english/shared/loading.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_english/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
              Text("Register to continue", style: TextStyle(
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
                      SizedBox(height: 90.0),
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
                        obscureText: true,
                        validator: (val) => val.length < 6
                            ? 'Enter a password 6+ chars long'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(height: 40.0),
                      RaisedButton(
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        color: Colors.deepPurple[400],
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(18.0)),
                        ),
                        child: Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result =
                            await _auth.registerWithEmailAndPassword(
                                email, password);
                            if (result == null) {
                              setState(() {
                                error = 'Please, suply a valid email!';
                                loading = false;
                              });
                            }
                          }
                        },
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14.0,
                        ),
                      )
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
