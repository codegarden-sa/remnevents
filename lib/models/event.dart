import 'package:firebase_helpers/firebase_helpers.dart';

class EventModel extends DatabaseItem {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final String userId;

  EventModel(
      {this.id,
      this.title,
      this.description,
      this.startDate,
      this.endDate,
      this.status,
      this.userId})
      : super(id);

  factory EventModel.fromMap(Map data) {
    return EventModel(
      title: data['title'],
      description: data['description'],
      startDate: data['startDate'],
      endDate: data['endDate'],
      status: data['status'],
      // status: data['status'],
    );
  }

  factory EventModel.fromDS(String id, Map<String, dynamic> data) {
    return EventModel(
      id: id,
      title: data['title'],
      description: data['description'],
      startDate: data['startDate']?.toDate(),
      endDate: data['endDate']?.toDate(),
      status: data['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "startDate": startDate,
      "endDate": endDate,
      "status": status,
      "id": id,
    };
  }

  @override
  String toString() {
    return 'Event: title: {$title}, description: {$description}, date: {$endDate}, status : {$status}';
  }
}
