import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauthwithemail/Screens/Home_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Ragistration_Screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  // from key
  final _formkey = GlobalKey<FormState>();

  // edit controller
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();

  final _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {

    final emailFild = TextFormField(
      autocorrect: false,
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if(value!.isEmpty){
          return ("Please enter your Email");
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
            .hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        return null;
      },
      onSaved: (value){
        emailController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.email),
        contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
        hintText: "Enter Email",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        )
      ),
    );

    final passwordField = TextFormField(
      autocorrect: false,
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if(value!.isEmpty){
          return ("Password is require");
        }
        if(!regex.hasMatch(value)){
          return("please enter valid password(min 6 character)");
        }
        return null;
      },
      onSaved: (value){
        passwordController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
          hintText: "Enter Password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    final loginButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20,15,20,15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          signIn(emailController.text, passwordController.text);
        },
        child: Text("Login", textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),),
      ),

    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    SizedBox(height: 200,
                      child: Image.asset("assets/logo.png",
                      fit: BoxFit.contain,),
                    ),
                    SizedBox(height: 45,),
                    emailFild,
                    SizedBox(height: 25,),
                    passwordField,
                    SizedBox(height: 35,),
                    loginButton,
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't Have an account? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => RagisterScreen()));
                          },
                          child: Text("SignUp", style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                          ),),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signIn(String email, String password) async
  {
    if(_formkey.currentState!.validate()){
      await _auth.signInWithEmailAndPassword(email: email, password: password).then((uid) =>
      {
        Fluttertoast.showToast(msg: "Login Successfull"),
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()))
      }).catchError((e){
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

}


