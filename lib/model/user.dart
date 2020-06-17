import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class User{
  String userID;
  String userEmail;
  String userPassword;
  DateTime userCreatedAt;

  User.guest(this.userID);

  User.account(this.userEmail,this.userPassword);

  User({@required this.userID, @required this.userEmail});

  Map<String,dynamic> toMap(){
    return {
      'userID' : userID,
      'userEmail' : userEmail ?? '',
      'userPassword' : userPassword ?? '',
      'userCreatedAt' : userCreatedAt ?? FieldValue.serverTimestamp(),
    };
  }

  User.fromMap(Map<String,dynamic> map):
    userID = map['userID'],
    userEmail = map['userEmail'],
    userPassword = map['userPassword'],
    userCreatedAt = (map['userCreatedAt'] as Timestamp).toDate();
}