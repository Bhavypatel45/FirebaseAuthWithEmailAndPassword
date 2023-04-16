import 'dart:math';

class UserModel {
  String? uid;
  String? email;
  String? firstname;
  String? secondname;

  UserModel({this.uid, this.email, this.firstname, this.secondname});

  factory UserModel.fromMap(map){
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstname: map['firstName'],
      secondname: map['secondName'],
    );
  }

  Map<String, dynamic> toMap() {
    return{
      'uid': uid,
      'email': email,
      'firstName': firstname,
      'secondName': secondname,
    };
  }
}