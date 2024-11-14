import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:to_do/core/utils/colors_manager.dart';
import 'package:to_do/database_manager/models/todo_dm.dart';
import 'package:to_do/presentation/screens/home/tabs/tasks_tab/widgets/task_item.dart';

import '../../../../../database_manager/models/users_dm.dart';
import '../../../../../providers/settings_provider.dart';

class TasksTab extends StatefulWidget {
  const TasksTab({super.key});

  @override
  State<TasksTab> createState() => TasksTabState();
}

class TasksTabState extends State<TasksTab> {
  List<TodoDM> todosList = [];
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTodoFromFireStore();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return Stack(
      children: [
        Container(color: ColorsManager.blue, height: 100.h),
        Column(
          children: [
            buildCalenderTimeLine(provider),
            SizedBox(height: 15.h),
            Expanded(
                child: ListView.builder(
              itemBuilder: (context, index) => TaskItem(
                todo: todosList[index],
                onDeletedTask: () {
                  getTodoFromFireStore();
                },
              ),
              itemCount: todosList.length,
            ))
          ],
        ),
      ],
    );
  }

  buildCalenderTimeLine(SettingsProvider provider) => EasyDateTimeLine(
        initialDate: DateTime.now(),
        onDateChange: (date) {
          selectedDate = date;
          getTodoFromFireStore();
        },
        headerProps: EasyHeaderProps(
          showHeader: true,
          monthPickerType: MonthPickerType.switcher,
          dateFormatter: DateFormatter.fullDateDayAsStrMY(),
          monthStyle: TextStyle(
              color:
                  provider.isLight() ? Colors.white : ColorsManager.darkBlack,
              fontWeight: FontWeight.w500,
              fontSize: 16),
          selectedDateStyle: TextStyle(
              color:
                  provider.isLight() ? Colors.white : ColorsManager.darkBlack,
              fontWeight: FontWeight.w500,
              fontSize: 16),
        ),
        dayProps: EasyDayProps(
          height: 79.h,
          width: 58.w,
          dayStructure: DayStructure.dayStrDayNum,
          activeDayStyle: DayStyle(
            dayNumStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: ColorsManager.blue),
            dayStrStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: ColorsManager.blue),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: provider.isLight()
                  ? Theme.of(context).colorScheme.onPrimary
                  : ColorsManager.darkBlack,
            ),
          ),
          inactiveDayStyle: DayStyle(
            dayNumStyle: TextStyle(
                fontSize: 12,
                color: provider.isLight() ? ColorsManager.black : Colors.white),
            dayStrStyle: TextStyle(
                fontSize: 12,
                color: provider.isLight() ? ColorsManager.black : Colors.white),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              color: provider.isLight()
                  ? Theme.of(context).colorScheme.onPrimary
                  : ColorsManager.darkBlack,
            ),
          ),
          todayStyle: const DayStyle(
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

  getTodoFromFireStore() async {
    CollectionReference todoCollection = FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(UserDM.currentUser!.id)
        .collection(TodoDM.collectionName);
    QuerySnapshot collectionSnapshot = await todoCollection.get();
    List<QueryDocumentSnapshot> documentSnapShot = collectionSnapshot.docs;
    List<TodoDM> toDos = documentSnapShot.map(
      (docSnapShot) {
        Map<String, dynamic> json = docSnapShot.data() as Map<String, dynamic>;
        TodoDM todoTasks = TodoDM.fromFireStore(json);
        return todoTasks;
      },
    ).toList();

    todosList = toDos
        .where((todo) =>
            todo.dateTime.day == selectedDate.day &&
            todo.dateTime.month == selectedDate.month &&
            todo.dateTime.year == selectedDate.year)
        .toList();
    setState(() {});
  }
}
