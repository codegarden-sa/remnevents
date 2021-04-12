import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sandtonchurchapp/constants/constants.dart';
import 'package:sandtonchurchapp/models/event.dart';
import 'package:sandtonchurchapp/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference eventCollection =
      Firestore.instance.collection('events');
  // final CollectionReference allEventCollection =
  //     Firestore.instance.collection('events');
  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  List<EventModel> _eventListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      String startHour = DateFormat('j').format(doc['startDate'].toDate());
      String endHour = DateFormat('j').format(doc['endDate'].toDate());

      // print(doc.documentID);
      return EventModel(
        id: doc.documentID,
        title: doc['title'],
        department: doc['department'],
        description: doc['description'],
        startDate: doc['startDate']?.toDate(),
        endDate: doc['endDate']?.toDate(),
        startHour: startHour,
        endHour: endHour,
        status: doc['status'],
        venue: doc['venue'],
        //TODO: //get new events with date times
        // createdAt: DateTime.fromMillisecondsSinceEpoch(doc['createdAt'] ?? DateTime.now()),
        // modifiedAt: DateTime.fromMillisecondsSinceEpoch(doc['modifiedAt'] ?? DateTime.now()),
      );
    }).toList();
  }

  UserDetails _userInfoFromSnapshot(DocumentSnapshot snapshot) {
    print(':: DATABASE :: mapping user details');
    return UserDetails(
        uid: uid,
        name: snapshot.data['name'],
        surname: snapshot.data['surname'],
        email: snapshot.data['email'],
        cellNumber: snapshot.data['cellNumber'],
        status: snapshot.data['status']);
  }

  Stream<List<EventModel>> get events {
    return eventCollection.snapshots().map(_eventListFromSnapshot);
  }

  Stream<List<EventModel>> get approvedEvents {
    try {
      return eventCollection
          .where('status', isEqualTo: AppConstants.APPROVED)
          .where('startDate', isGreaterThanOrEqualTo: DateTime.now())
          .orderBy('startDate', descending: true)
          .snapshots()
          .map(_eventListFromSnapshot);
    } on Exception catch (e) {
      print('error getting events from firebase');
      print(e);
      return null;
    }
  }

  Stream<List<EventModel>> get pendingEvents {
    try {
      return eventCollection
          .where('status', isEqualTo: AppConstants.PENDING)
          .snapshots()
          .map(_eventListFromSnapshot);
    } on Exception catch (e) {
      print('error getting events from firebase');
      print(e);
      return null;
    }
  }

  Stream<List<EventModel>> get leaderEvents {
    try {
      return eventCollection
          .where('userId', isEqualTo: uid)
          .snapshots()
          .map(_eventListFromSnapshot);
    } on Exception catch (e) {
      print('error getting events from firebase');
      print(e);
      return null;
    }
  }

  Future updateUserDetails(String name, String surname, String cellNumber,
      String email, String status) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'surname': surname,
      'cellNumber': cellNumber,
      'email': email,
      'status': status,
    });
  }

  Future updateEvent(String id, String status) async {
    //update UI after status update.
    return await eventCollection
        .document(id)
        .updateData({'status': status})
        .then((event) => 'updated')
        .catchError((error) => error);
  }

  Future bookEvent(String title, String description, String department,
      DateTime startDate, DateTime endDate) async {
    return await eventCollection
        .document()
        .setData({
          'title': title,
          'description': description,
          'department': department,
          'venue': AppConstants.VENUE,
          'status': AppConstants.PENDING,
          'startDate': startDate,
          'endDate': endDate,
          'createdAt': DateTime.now(),
          'modifiedAt': DateTime.now(),
          'userId': uid
        })
        .then((event) => 'event added')
        .catchError((error) => error);
  }

  Stream<UserDetails> get userDetails {
    try {
      return userCollection
          .document(uid)
          .snapshots()
          .map(_userInfoFromSnapshot)
          .asBroadcastStream(); //allow for morethan one listener
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  Future refreshUserStatus() async {
    Stream<UserDetails> userDetails = DatabaseService(uid: uid).userDetails;
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    print(':: Database :: about to refresh');

    return userDetails.listen(
        (userData) {
          sharedPreferences.setString('uid', uid);
          print(':: Database :: inserting name ' + userData.name);
          sharedPreferences.setString('name', userData.name);

          sharedPreferences.setString('status', userData.status);
          print(
              'Inserting/Refreshing user status [status]:: ' + userData.status);

          return userData.status;
        },
        onError: (error) {
          print('Error when getting user details ' + error.toString());
        },
        cancelOnError: false,
        onDone: () {
          print('Done getting user details');
        });
  }
}
