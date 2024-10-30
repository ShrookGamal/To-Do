
/*
toFormattedDate (DateTime date)
{
  DateFormat formatter = DateFormat.yMMMMd('en_US');
  formatter.format(date);
}
*/

extension DateFormat on DateTime {
  String toFormattedDate() => ' $day / $month / $year';
}
