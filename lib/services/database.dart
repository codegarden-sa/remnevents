import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sandtonchurchapp/models/event.dart';

class DatabaseService {
  final CollectionReference eventCollection =
      FirebaseFirestore.instance.collection('bookings');

  List<EventModel> _eventListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
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

  Stream<List<EventModel>> get events {
    return eventCollection.snapshots()
    .map(_eventListFromSnapshot);
  }
}
