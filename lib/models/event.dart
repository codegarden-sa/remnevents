import 'package:firebase_helpers/firebase_helpers.dart';

class EventModel extends DatabaseItem {
  final String id;
  final String title;
  final String description;
  final DateTime eventDate;
  final String status;
  final String userId;

  EventModel(
      {this.id,
      this.title,
      this.description,
      this.eventDate,
      this.status,
      this.userId})
      : super(id);

  factory EventModel.fromMap(Map data) {
    return EventModel(
      title: data['title'],
      description: data['description'],
      eventDate: data['eventDate'],
      // status: data['status'],
    );
  }

  factory EventModel.fromDS(String id, Map<String, dynamic> data) {
    return EventModel(
      id: id,
      title: data['title'],
      description: data['description'],
      eventDate: data['eventDate']?.toDate(),
      // status: data['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "eventDate": eventDate,
      "id": id,
    };
  }

  @override
  String toString() {
    return 'Event: title: {$title}, description: {$description}, date: {$eventDate}, status : {$status}';
  }
}
