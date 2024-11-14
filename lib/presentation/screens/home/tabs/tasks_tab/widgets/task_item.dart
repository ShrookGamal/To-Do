import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:to_do/core/utils/colors_manager.dart';
import 'package:to_do/core/utils/date_style.dart';
import 'package:to_do/database_manager/models/todo_dm.dart';

import '../../../../../../core/utils/text_styles.dart';
import '../../../../../../database_manager/models/users_dm.dart';
import '../../../../../../providers/settings_provider.dart';
import 'edit_task.dart';

class TaskItem extends StatefulWidget {
  TaskItem({super.key, required this.todo, required this.onDeletedTask});

  TodoDM todo;

  Function onDeletedTask;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    bool isLight = provider.isLight();
    return Container(
      margin: REdgeInsets.all(8),
      decoration: BoxDecoration(
          color: provider.isLight()
              ? Theme.of(context).colorScheme.onPrimary
              : ColorsManager.darkBlack,
          borderRadius: BorderRadius.circular(15)),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: AppLocalizations.of(context)!.delete,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              onPressed: (BuildContext context) {
                deleteTaskFromFireStore(widget.todo);
                widget.onDeletedTask();
              },
            ),
            SlidableAction(
              backgroundColor: ColorsManager.blue,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: AppLocalizations.of(context)!.edit,
              onPressed: (BuildContext context) {
                if (widget.todo.isDone == false) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditTask(
                                todoDM: widget.todo,
                              )));
                }
              },
            ),
          ],
        ),
        child: Container(
          height: 115.h,
          padding: REdgeInsets.all(10),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  width: 4.w,
                  decoration: BoxDecoration(
                      color: widget.todo.isDone
                          ? ColorsManager.green
                          : Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(10)),
                ),
                SizedBox(width: 15.w),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.todo.title,
                      style: widget.todo.isDone
                          ? AppTextStyles.doneTaskTitle
                          : AppTextStyles.taskTitle,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      widget.todo.description,
                      style: widget.todo.isDone
                          ? AppTextStyles.doneTaskDes
                          : AppTextStyles.taskDescription(isLight),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.timer_outlined,
                          color: provider.isLight()
                              ? ColorsManager.black
                              : Colors.white,
                        ),
                        Text(
                          widget.todo.dateTime.toFormattedDate(),
                          style: TextStyle(
                              color: provider.isLight()
                                  ? ColorsManager.black
                                  : Colors.white),
                        )
                      ],
                    )
                  ],
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    onTapDone();
                    setState(() {});
                  },
                  child: Container(
                      padding:
                          REdgeInsets.symmetric(horizontal: 12, vertical: 3),
                      decoration: BoxDecoration(
                          color: widget.todo.isDone
                              ? Colors.transparent
                              : Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(10)),
                      child: widget.todo.isDone
                          ? Text(
                              AppLocalizations.of(context)!.doneTask,
                              style: AppTextStyles.doneTaskTitle,
                            )
                          : Icon(
                              Icons.check,
                              color: Theme.of(context).colorScheme.onPrimary,
                              size: 35,
                            )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  deleteTaskFromFireStore(TodoDM todoDM) async {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(UserDM.currentUser!.id)
        .collection(TodoDM.collectionName);
    DocumentReference documentReference =
        collectionReference.doc(widget.todo.id);
    await documentReference.delete();
  }

  Future<void> onTapDone() async {
    widget.todo.isDone = true;
    await FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(UserDM.currentUser!.id)
        .collection(TodoDM.collectionName)
        .doc(widget.todo.id)
        .update({'isDone': true});
  }
}
