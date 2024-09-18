import 'package:intl/intl.dart';
import 'package:remnevents/constants/constants.dart';
import 'package:remnevents/models/event.dart';
import 'package:remnevents/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({required this.uid});

  final CollectionReference eventCollection =
      FirebaseFirestore.instance.collection('events');
  // final CollectionReference allEventCollection =
  //     Firestore.instance.collection('events');
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');

  List<EventModel> _eventListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      String startHour = DateFormat('j').format(doc['startDate'].toDate());
      String endHour = DateFormat('j').format(doc['endDate'].toDate());

      // print(doc.documentID);
      return EventModel(
        id: doc.id,
        title: doc['title'],
        department: doc['department'],
        description: doc['description'],
        startDate: doc['startDate']?.toDate(),
        endDate: doc['endDate']?.toDate(),
        startHour: startHour,
        endHour: endHour,
        status: doc['status'],
        venue: doc['venue'],
        createdAt: doc['createdAt']?.toDate() ?? DateTime.now(),
        modifiedAt: doc['modifiedAt']?.toDate() ?? DateTime.now(),
        userId: doc['userId'] ?? '', // Add this line
        notificationId: doc['notificationId'] ?? doc.id, // Add this line
        notificationTime: doc['notificationTime']?.toDate() ?? DateTime.now(), // Add this line
      );
    }).toList();
  }

  UserDetails _userInfoFromSnapshot(DocumentSnapshot snapshot) {
    print(':: DATABASE :: mapping user details');
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return UserDetails(
        uid: uid ?? '',
        name: data['name'] as String? ?? '',
        surname: data['surname'] as String? ?? '',
        email: data['email'] as String? ?? '',
        cellNumber: data['cellNumber'] as String? ?? '',
        status: data['status'] as String? ?? '');
  }

  Stream<List<EventModel>> get events {
    return eventCollection.snapshots().map(_eventListFromSnapshot);
  }

  Stream<List<EventModel>> get approvedEvents {
    try {
      return eventCollection
          .where('status', isEqualTo: AppConstants.APPROVED)
          // .where('startDate', isGreaterThanOrEqualTo: DateTime.now())
          .orderBy('startDate', descending: true)
          .snapshots()
          .map(_eventListFromSnapshot);
    } on Exception catch (e) {
      print('error getting events from firebase');
      print(e);
      return Stream.value([]);  // Return an empty list stream instead of null
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
      return Stream.value([]);  // Return an empty list stream instead of null
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
      return Stream.value([]);  // Return an empty list stream instead of null
    }
  }

  Future updateUserDetails(String name, String surname, String cellNumber,
      String email, String status) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'surname': surname,
      'cellNumber': cellNumber,
      'email': email,
      'status': status,
    });
  }

  Future updateEvent(String id, String status) async {
    return await eventCollection
        .doc(id)
        .update({'status': status})
        .then((event) => 'updated')
        .catchError((error) => error);
  }

  Future bookEvent(String title, String description, String department,
      DateTime startDate, DateTime endDate) async {
    return await eventCollection
        .doc()
        .set({
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
          .doc(uid)
          .snapshots()
          .map(_userInfoFromSnapshot)
          .asBroadcastStream(); //allow for morethan one listener
    } catch (error) {
      print(error.toString());
      return Stream.value(UserDetails(uid: '', name: '', surname: '', email: '', cellNumber: '', status: ''));
    }
  }

  Future refreshUserStatus() async {
    Stream<UserDetails> userDetails = DatabaseService(uid: uid).userDetails;
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    print(':: Database :: about to refresh');

    return userDetails.listen(
        (userData) {
          sharedPreferences.setString('uid', uid ?? '');
          print(':: Database :: inserting name ' + userData.name);
          sharedPreferences.setString('name', userData.name);

          sharedPreferences.setString('status', userData.status);
          print(
              'Inserting/Refreshing user status [status]:: ' + userData.status);
        },
        onError: (error) {
          print('Error when getting user details ' + error.toString());
        },
        cancelOnError: false,
        onDone: () {
          print('Done getting user details');
        });
  }

  Future<Map<DateTime, List<EventModel>>> getEvents() async {
    try {
      QuerySnapshot snapshot = await eventCollection.get();
      List<EventModel> events = _eventListFromSnapshot(snapshot);
      
      Map<DateTime, List<EventModel>> eventMap = {};
      for (var event in events) {
        DateTime date = DateTime(event.startDate.year, event.startDate.month, event.startDate.day);
        eventMap.putIfAbsent(date, () => []).add(event);
      }
      
      return eventMap;
    } catch (e) {
      print('Error fetching events: $e');
      return {};
    }
  }
}
