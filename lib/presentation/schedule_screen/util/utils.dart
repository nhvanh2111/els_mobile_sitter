import 'dart:collection';

import 'package:table_calendar/table_calendar.dart';

import '../../../core/models/schedule_models/schedule_item_data_model.dart';

/// Example event class.
class Event {
  final ScheduleItemDataModel item;

  const Event(this.item);

// @override
// String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
// final kEvents = LinkedHashMap<DateTime, List<Event>>(
//   equals: isSameDay,
//   hashCode: getHashCode,
// // )..addAll(_kEventSource);
// )..addAll({
//     DateTime.now(): [
//       const Event('a'),
//       const Event('b'),
//     ],
//   DateTime.now().add(Duration(days: 1)): [
//     const Event('a'),
//     const Event('b'),
//   ],
//   });



int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);
