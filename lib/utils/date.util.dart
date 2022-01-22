import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const String _timeMask = 'kk:mm';
const String _dateMask = 'dd/MM/yyyy';
const String _datetimeMask = '$_dateMask $_timeMask';

mixin DateUtil {
  static final DateTime firstDayOfYear = DateTime(DateTime.now().year).toLocal();
  static final DateTime lastDayOfYear = DateTime(DateTime.now().year, 12, 31, 23, 59, 59).toLocal();

  /// Date Time as String
  static String dateTimeToString(
    DateTime? date, {
    bool dateOnly = false,
    bool timeOnly = false,
  }) {
    final String mask = timeOnly
        ? _timeMask
        : dateOnly
            ? _dateMask
            : _datetimeMask;

    return date == null ? '' : DateFormat(mask).format(date.toLocal());
  }

  /// Date Time as String from String
  static String stringDateToString(
    String? string, {
    bool dateOnly = false,
    bool timeOnly = false,
  }) {
    return string == null || string.isEmpty
        ? ''
        : dateTimeToString(
            DateTime.parse(string),
            dateOnly: dateOnly,
            timeOnly: timeOnly,
          );
  }

  /// Weekdays from List String
  static String weekdays(
    List<int> days,
  ) {
    String result = '';

    final Map<int, String> weekdays = <int, String>{
      0: 'Dom',
      1: 'Seg',
      2: 'Ter',
      3: 'Qua',
      4: 'Qui',
      5: 'Sex',
      6: 'Sab',
    };

    for (int day in days) {
      result += '${weekdays[day]!}${day != days.last ? ', ' : ''}';
    }

    return result.trim();
  }

  /// Get next weekday from a base date and weekday
  static DateTime nextWeekday(DateTime date, int wDay) {
    final int weekday = date.weekday;

    // se dia da semana da data base for menor que wDay, entao adiciona
    // diferenca ao dia senao pula pra proxima semana e pega o dia
    final int days = weekday <= wDay ? wDay - weekday : (7 - weekday) + wDay;
    return date.add(Duration(days: days));
  }

  /// Get every month day of year from a base date and day
  static List<DateTime> weekdaysOfYear(DateTime date, List<int> wDays) {
    final List<DateTime> weekdays = <DateTime>[];
    DateTime weekday = DateTime(date.year, date.month, date.day);
    bool shouldContinue = true;

    while (shouldContinue) {
      for (int wDay in wDays) {
        weekday = nextWeekday(weekday, wDay);

        if (weekday.year > date.year) {
          shouldContinue = false;
          break;
        } else {
          weekdays.add(weekday);
          weekday = weekday.add(const Duration(days: 1));
        }
      }
    }

    return weekdays;
  }

  /// Get next month day from a base date and month day
  static DateTime nextMonthDay(DateTime date, int mDay) {
    int year = date.year;
    int month = date.month;

    // se dia da data base maior que dia entao pega proximo mes
    if (date.day > mDay) {
      month += 1;

      // se mes maior que 11 (novembro) entao pega proximo ano
      if (date.month > 11) {
        year += 1;
      }
    }

    return DateTime(year, month, mDay).toLocal();
  }

  /// Get every month day of year from a base date and day
  static List<DateTime> monthDaysOfYear(DateTime date, int mDay) {
    final List<DateTime> monthDays = <DateTime>[];
    DateTime monthDay = DateTime(date.year, date.month, date.day);
    bool shouldContinue = true;

    // metodo recursivo pra pegar mesmo dia do mes de todos meses do ano
    while (shouldContinue) {
      monthDay = nextMonthDay(monthDay, mDay);

      if (monthDay.year > date.year) {
        shouldContinue = false;
      } else {
        monthDays.add(monthDay);
        monthDay = DateTime(date.year, monthDay.month + 1, mDay);
      }
    }

    return monthDays;
  }

  static String getDaysTo(DateTime? date, {bool mustShowDays = true}) {
    String getDiffDays(int? deadline) {
      return '${deadline!.abs()} ${deadline > 1 || deadline < -1 ? 'dias' : 'dia'}';
    }

    final int? deadline = date != null ? date.difference(DateTime.now()).inDays : null;
    return deadline == null
        ? 'indeterminado'
        : deadline == 0
            ? 'Expira hoje'
            : deadline < 0
                ? 'Atrasado${mustShowDays ? ' em ${getDiffDays(deadline)}' : ''}'
                : getDiffDays(deadline);
  }

  static double toDouble(TimeOfDay myTime) => myTime.hour + myTime.minute / 60.0;
}
