import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_alarm/model/alarm.dart';
import 'package:currency_alarm/model/symbols.dart';
import 'package:currency_alarm/model/user.dart';
import 'package:flutter/cupertino.dart';

class FirestoreService {
  final Firestore _firestoreDB = Firestore.instance;

  Future<bool> saveUser(User user, String password) async {
    try {
      user.userPassword = password;
      await _firestoreDB
          .collection("users")
          .document(user.userID)
          .setData(user.toMap());

      DocumentSnapshot _snapshot =
          await _firestoreDB.document("users/${user.userID}").get();

      Map _snapshotMap = _snapshot.data;
      User _snapshotUser = User.fromMap(_snapshotMap);

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> saveAlarm(String userID, Alarm alarm) async {
    try {
      await _firestoreDB
          .collection("users")
          .document(userID)
          .collection("alarms")
          .document(alarm.exchangeTitle + " " + alarm.exchangeType)
          .setData(alarm.toMap());

      await _firestoreDB
          .collection("users")
          .document("alarmList")
          .collection(userID)
          .document(alarm.exchangeSymbol + " " + alarm.exchangeType)
          .setData(alarm.toMapWithUserID(userID));

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteAlarm(String userID, Alarm alarm) async {
    try {
      await _firestoreDB
          .collection("users")
          .document(userID)
          .collection("alarms")
          .document(alarm.exchangeTitle + " " + alarm.exchangeType)
          .delete();

      await _firestoreDB
          .collection("users")
          .document("alarmList")
          .collection(userID)
          .document(alarm.exchangeSymbol + " " + alarm.exchangeType)
          .setData(alarm.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<User> readUser(String userID) async {
    DocumentSnapshot _snapshotUser =
        await _firestoreDB.collection("users").document(userID).get();
    Map<String, dynamic> _snapshotMap = _snapshotUser.data;
    return User.fromMap(_snapshotMap);
  }

  Future<List<Alarm>> readAlarm(String userID) async {
    QuerySnapshot _snapshotAlarm = await _firestoreDB
        .collection("users")
        .document(userID)
        .collection("alarms")
        .getDocuments();
    if (_snapshotAlarm.documents.isNotEmpty) {
      debugPrint("DATABASE ALARM COUNT: " +
          _snapshotAlarm.documents.length.toString());
      List<Alarm> alarmList = new List<Alarm>(_snapshotAlarm.documents.length);
      for (int i = 0; i < _snapshotAlarm.documents.length; i++) {
        Map<String, dynamic> _snapshotMap = _snapshotAlarm.documents[i].data;
        debugPrint(_snapshotMap['exchangeType']);
        alarmList[i] = Alarm.fromMap(_snapshotMap);
      }
      return alarmList;
    } else {
      List<Alarm> alarmList = new List<Alarm>();
      alarmList.add(Alarm("EMPTY", "", "", "", flags[0]));
      return alarmList;
    }
  }
}
