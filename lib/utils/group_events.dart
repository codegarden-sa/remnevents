import 'package:sandtonchurchapp/models/event.dart';

Map<DateTime, List<dynamic>> groupEvents(List<EventModel> allEvents) {
  Map<DateTime, List<dynamic>> data = {};
  allEvents.forEach((event) {
    // print('group events ....');
    // print(event.startHour);
    DateTime date = DateTime(
        event.startDate.year, event.startDate.month, event.startDate.day, 12);
    // DateTime date = DateTime(12, 03, 16, 12);
    if (data[date] == null) data[date] = [];
    data[date].add(event);
  });
  return data;
}
