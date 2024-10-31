import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do/core/utils/colors_manager.dart';
import 'package:to_do/core/utils/date_style.dart';

import '../../../../../../core/utils/text_styles.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(15)),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)),
              onPressed: (BuildContext context) {},
            ),
            SlidableAction(
              backgroundColor: ColorsManager.blue,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
              onPressed: (BuildContext context) {},
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          child: IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  width: 4,
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(10)),
                ),
                SizedBox(width: 8),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Task Title ',
                      style: AppTextStyles.taskTitle,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Task Description ',
                      style: AppTextStyles.taskDescription,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      DateTime.now().toFormattedDate(),
                      style: AppTextStyles.DateLabelTextStyle,
                    ),
                  ],
                ),
                Spacer(),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                    decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(10)),
                    child: Icon(
                      Icons.check,
                      color: Theme.of(context).colorScheme.onPrimary,
                      size: 33,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
