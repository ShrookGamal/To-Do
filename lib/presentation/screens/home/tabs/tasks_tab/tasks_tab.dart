import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:to_do/core/utils/colors_manager.dart';
import 'package:to_do/presentation/screens/home/tabs/tasks_tab/widgets/task_item.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: ColorsManager.blue, height: 40),
        Column(
          children: [
            buildCalenderTimeLine(),
            SizedBox(height: 8),
            TaskItem(),
          ],
        ),
      ],
    );
  }

  buildCalenderTimeLine() => EasyDateTimeLine(
        initialDate: DateTime.now(),
        onDateChange: (selectedDate) {},
        headerProps: const EasyHeaderProps(
          showHeader: false,
          monthPickerType: MonthPickerType.switcher,
          dateFormatter: DateFormatter.fullDateDayAsStrMY(),
        ),
        dayProps: EasyDayProps(
          height: 75,
          width: 50,
          dayStructure: DayStructure.dayStrDayNum,
          activeDayStyle: DayStyle(
            dayNumStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: ColorsManager.blue),
            dayStrStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: ColorsManager.blue),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          inactiveDayStyle: DayStyle(
            dayNumStyle: TextStyle(fontSize: 12),
            dayStrStyle: TextStyle(fontSize: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          todayStyle: DayStyle(
            dayNumStyle: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
            dayStrStyle: TextStyle(
                fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              color: Colors.red,
            ),
          ),
        ),
      );
}
