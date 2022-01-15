import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login_page/screen/login.dart';

class RegisterScreen extends StatelessWidget {
  static String idScreen = "register";
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "REGISTER",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.red, fontSize: 36),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(height: size.height * 0.03),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: nameTextEditingController,
              decoration: InputDecoration(
                labelText: "Name",
                prefixIcon: Icon(Icons.person),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.03),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: phoneTextEditingController,
              decoration: InputDecoration(
                labelText: "Mobile Number",
                prefixIcon: Icon(Icons.phone),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.03),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: emailTextEditingController,
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(Icons.email),
              ),
            ),
          ),
          SizedBox(height: size.height * 0.03),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              controller: passwordTextEditingController,
              decoration: InputDecoration(
                labelText: "Password",
                prefixIcon: Icon(Icons.password),
              ),
              obscureText: true,
            ),
          ),
          SizedBox(height: size.height * 0.05),
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: RaisedButton(
              onPressed: () {
                if (nameTextEditingController.text.length < 3) {
                  displayToastMessage(
                      'Name must be atleast 3 charecters', context);
                } else if (!emailTextEditingController.text.contains('@')) {
                  displayToastMessage('Email address is not vaild', context);
                } else if (phoneTextEditingController.text.isEmpty) {
                  displayToastMessage('Phone Number is mandatory', context);
                } else if (passwordTextEditingController.text.length < 7) {
                  displayToastMessage(
                      'Password must be atleast 6 charecters', context);
                } else {
                  registerNewUser(context);
                }
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80.0)),
              textColor: Colors.white,
              padding: const EdgeInsets.all(0),
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                width: size.width * 0.5,
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.circular(80.0),
                  color: Colors.red,
                ),
                padding: const EdgeInsets.all(0),
                child: Text(
                  "SIGN UP",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: GestureDetector(
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginScreen()))
              },
              child: Text(
                "Already Have an Account? Sign in",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void registerNewUser(BuildContext context) async {
    final FirebaseUser firebaseUser =
        (await _firebaseAuth.createUserWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text).catchError(errMsg){
                  displayToastMessage('Error:' + errMsg.toString(), context);
                })
            .user;
    if (firebaseUser != null) {
    } else {}
  }

  displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }
}
