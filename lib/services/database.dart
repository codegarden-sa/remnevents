import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sandtonchurchapp/constants/constants.dart';
import 'package:sandtonchurchapp/models/event.dart';
import 'package:sandtonchurchapp/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference eventCollection =
      Firestore.instance.collection('bookings');
  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  List<EventModel> _eventListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      // print
      print(doc);
      return EventModel(
        id: '2',
        title: doc['title'],
        description: doc['description'],
        eventDate: doc['eventDate']?.toDate(),
      );
    }).toList();
  }

  UserDetails _userInfoFromSnapshot(DocumentSnapshot snapshot) {
    print('email ===>>> '+ snapshot.data['email']);
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
      String startDate, String endDate, String startTime, String endTime) async {
    return await userCollection.document(uid).setData({
      'title': title,
      'description': description,
      'department': department,
      'venue': AppConstants.VENUE,
      'status': AppConstants.EVENT_STATUS,
      'startDate':startDate,
      'endDate': endDate,
      'startTime': startTime,
      'endTime' : endTime
    });
  }

  Stream<UserDetails> get userDetails {
    print(uid);
    return userCollection.document(uid).snapshots().map(_userInfoFromSnapshot);
  }

  


}
