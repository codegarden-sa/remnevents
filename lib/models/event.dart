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

  EventModel(
      {this.id,
      this.title,
      this.department,
      this.description,
      this.startDate,
      this.endDate,
      this.startHour,
      this.endHour,
      this.status,
      this.venue,
      this.createdAt,
      this.modifiedAt,
      this.userId});

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
