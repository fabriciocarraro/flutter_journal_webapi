/// Gera dia da semana em português
class WeekDay {
  DateTime date;
  late String short;
  late String long;

  WeekDay(this.date) {
    int weekday = date.weekday;
    switch (weekday) {
      case 7:
        short = "Sun";
        long = "Sunday";
        break;
      case 1:
        short = "Mon";
        long = "Monday";
        break;
      case 2:
        short = "Tue";
        long = "Tuesday";
        break;
      case 3:
        short = "Wed";
        long = "Wednesday";
        break;
      case 4:
        short = "Thu";
        long = "Thursday";
        break;
      case 5:
        short = "Fri";
        long = "Friday";
        break;
      case 6:
        short = "Sat";
        long = "Saturday";
        break;
    }
  }

  @override
  String toString() {
    return "${long}, "
        "${date.day}  |  "
        "${date.month}  |  "
        "${date.year}";
  }
}
