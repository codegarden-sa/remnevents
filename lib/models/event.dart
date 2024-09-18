class EventModel {
  final String id;
  final String title;
  final String department;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final String startHour;
  final String endHour;
  String status;
  final String venue;
  final DateTime createdAt;
  DateTime modifiedAt;
  final String userId;
  int notificationId;
  int notificationTime;
  EventModel({
    required this.id,
    required this.title,
    required this.department,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.startHour,
    required this.endHour,
    required this.status,
    required this.venue,
    required this.createdAt,
    required this.modifiedAt,
    required this.userId,
    required this.notificationId,
    required this.notificationTime,
  });

  // factory EventModel.fromMap(Map data) {
  //   return EventModel(
  //     title: data['title'],
  //     description: data['description'],
  //     startDate: data['startDate'],
  //     endDate: data['endDate'],
  //     status: data['status'],
  //     // status: data['status'],
  //   );
  // }

  // factory EventModel.fromDS(String id, Map<String, dynamic> data) {
  //   return EventModel(
  //     id: id,
  //     title: data['title'],
  //     description: data['description'],
  //     startDate: data['startDate']?.toDate(),
  //     endDate: data['endDate']?.toDate(),
  //     status: data['status'],
  //   );
  // }

  // Map<String, dynamic> toMap() {
  //   return {
  //     "title": title,
  //     "description": description,
  //     "startDate": startDate,
  //     "endDate": endDate,
  //     "status": status,
  //     "id": id,
  //   };
  // }

  // @override
  // String toString() {
  //   return 'Evt: title: {$title}, description: {$description}, date: {$endDate}, status : {$status}, create : {$createdAt}';
  // }
}
