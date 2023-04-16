import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebaseauthwithemail/Screens/Home_Screen.dart';
import 'package:firebaseauthwithemail/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RagisterScreen extends StatefulWidget {
  const RagisterScreen({Key? key}) : super(key: key);

  @override
  _RagisterScreenState createState() => _RagisterScreenState();
}

class _RagisterScreenState extends State<RagisterScreen> {

  //our Form key
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;

  final FirstNameEditingController = new TextEditingController();
  final SecondNameEditingController = new TextEditingController();
  final EmailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final conformpasswordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {

    final firstNameField = TextFormField(
      autocorrect: false,
      controller: FirstNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = new RegExp(r'^.{3,}$');
        if(value!.isEmpty){
          return ("Name is require");
        }
        if(!regex.hasMatch(value)){
          return("enter valid name(min 3 character)");
        }
        return null;
      },
      onSaved: (value){
        FirstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
          hintText: "Enter Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    final secondnamefield = TextFormField(
      autocorrect: false,
      controller: SecondNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if(value!.isEmpty){
          return ("Name is require");
        }
        return null;
      },
      onSaved: (value){
        SecondNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.person),
          contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
          hintText: "Enter Name",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    final emailFild = TextFormField(
      autocorrect: false,
      controller: EmailEditingController,
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
        EmailEditingController.text = value!;
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

    final passwordfield = TextFormField(
      autocorrect: false,
      controller: passwordEditingController,
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
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
          hintText: "Enter password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    final conformpasswordfield = TextFormField(
      autocorrect: false,
      controller: conformpasswordEditingController,
      obscureText: true,
      validator: (value) {
        if(conformpasswordEditingController.text != passwordEditingController.text){
          return ("Password is does not match");
        }
        return null;
      },
      onSaved: (value){
        conformpasswordEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.vpn_key),
          contentPadding: EdgeInsets.fromLTRB(20,15,20,15),
          hintText: "Enter confor m password",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );

    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.redAccent,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20,15,20,15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: (){
          signUp(EmailEditingController.text, passwordEditingController.text);
        },
        child: Text("SignUp", textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),),
      ),

    );




    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.red,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(36.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    SizedBox(height: 200,
                      child: Image.asset("assets/logo.png",
                        fit: BoxFit.contain,),
                    ),
                    SizedBox(height: 45,),
                    firstNameField,
                    SizedBox(height: 25,),
                    secondnamefield,
                    SizedBox(height: 25,),
                    emailFild,
                    SizedBox(height: 25,),
                    passwordfield,
                    SizedBox(height: 25,),
                    conformpasswordfield,
                    SizedBox(height: 35,),
                    signUpButton,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }


  void signUp(String email, String password) async{
    if(_formKey.currentState!.validate()){
        await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) => {
          postDetailsToFirestore(),
        }).catchError((e){
          Fluttertoast.showToast(msg: e!.message);
        });
    }
  }

  postDetailsToFirestore() async{
     FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
     User? user = _auth.currentUser;

     UserModel userModel = UserModel();

     userModel.email = user!.email;
     userModel.uid = user.uid;
     userModel.firstname = FirstNameEditingController.text;
     userModel.secondname = SecondNameEditingController.text;

     await firebaseFirestore.collection("users").doc(user.uid).set(userModel.toMap());

     Fluttertoast.showToast(msg: "Account created Succesfully");

     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen()), ((route) => false));
  }
}
