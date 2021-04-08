import 'package:sandtonchurchapp/models/event.dart';

Map<DateTime, List<dynamic>> groupEvents(List<EventModel> allEvents) {
  Map<DateTime, List<dynamic>> data = {};

  allEvents.forEach((event) {
    int duration = event.endDate.day - event.startDate.day;
    //when there's a repeating event for multiple days
    if (duration > 0) {
      for (int d = 0; d < duration; d++) {
        DateTime currentDay = event.startDate.add(Duration(days: d));
        DateTime date =
            DateTime(currentDay.year, currentDay.month, currentDay.day, 12);
        if (data[date] == null) data[date] = [];

        //create unique notificationid from month and day numbers
        event.notificationId = int.parse(currentDay.month.toString() + currentDay.day.toString());
        data[date].add(event);
      }
      return;
    }

    //single day event
    DateTime date = DateTime(
        event.startDate.year, event.startDate.month, event.startDate.day, 12);
    if (data[date] == null) data[date] = [];

    event.notificationId = int.parse(event.startDate.month.toString() + event.startDate.day.toString());
    data[date].add(event);
  });

  // print(data);
  return data;
}
