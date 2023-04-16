import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauthwithemail/model/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection("users").doc(user!.uid).get().then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Welcome"), centerTitle: true,),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 150,
                child: Image.asset("assets/logo.png",
                  fit: BoxFit.contain,),
              ),
              Text("Wlcome Back", style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
              SizedBox(height: 30,),
              Text("${loggedInUser.firstname} ${loggedInUser.secondname}",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),),
              Text("${loggedInUser.email}",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),),
              SizedBox(height: 40,),
              ActionChip(label: Text("Logout"), onPressed: () {
                logout(context);
              },)
            ],
          ),
        ),
      ),
    );
  }
  
  Future<void> logout(BuildContext context) async{
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}
