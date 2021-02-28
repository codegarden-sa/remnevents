import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:sandtonchurchapp/constants/constants.dart';
import 'package:sandtonchurchapp/models/event.dart';
import 'package:sandtonchurchapp/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference approvedEventCollection =
      Firestore.instance.collection('events');
  final CollectionReference allEventCollection =
      Firestore.instance.collection('events');
  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  List<EventModel> _eventListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      String startHour = DateFormat('j').format(doc['startDate'].toDate());
      String endHour = DateFormat('j').format(doc['endDate'].toDate());
     return EventModel(
        title: doc['title'],
        department: doc['department'],
        description: doc['description'],
        startDate: doc['startDate']?.toDate(),
        endDate: doc['endDate']?.toDate(),
        startHour: startHour,
        endHour: endHour,
        status: doc['status'],
        venue: doc['venue'],
        createdAt: DateTime.fromMillisecondsSinceEpoch(doc['createdAt'] ?? 0),
        modifiedAt: DateTime.fromMillisecondsSinceEpoch(doc['modifiedAt'] ?? 0),
      );
    }).toList();
  }

  UserDetails _userInfoFromSnapshot(DocumentSnapshot snapshot) {
    return UserDetails(
        uid: uid,
        name: snapshot.data['name'],
        surname: snapshot.data['surname'],
        email: snapshot.data['email'],
        cellNumber: snapshot.data['cellNumber'],
        status: snapshot.data['status']);
  }

  Stream<List<EventModel>> get events {
    print('about to stream list');
    return allEventCollection.snapshots().map(_eventListFromSnapshot);
  }

  Stream<List<EventModel>> get approvedEvents {
    print('stream approved list');
    return approvedEventCollection
        .where('status', isEqualTo: 'approved')
        .snapshots()
        .map((ev)=> _eventListFromSnapshot(ev));
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

  Future bookEvent(String title, String description, String department,
      DateTime startDate, DateTime endDate) async {
    return await allEventCollection
        .document()
        .setData({
          'title': title,
          'description': description,
          'department': department,
          'venue': AppConstants.VENUE,
          'status': AppConstants.VIEWER,
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
    print(uid);
    return userCollection.document(uid).snapshots().map(_userInfoFromSnapshot);
  }
}
