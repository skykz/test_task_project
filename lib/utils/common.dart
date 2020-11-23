import 'package:intl/intl.dart';

getTime(String time) {
  DateTime tempDate = new DateFormat("hh:mm:ss").parse(time);
  return (tempDate.hour - DateTime.now().hour).abs();
}
