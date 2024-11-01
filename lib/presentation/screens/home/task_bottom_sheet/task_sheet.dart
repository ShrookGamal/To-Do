import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:to_do/core/utils/date_style.dart';
import '../../../../core/utils/text_styles.dart';

class TaskSheet extends StatefulWidget {
  const TaskSheet({super.key});

  @override
  State<TaskSheet> createState() => _TaskSheetState();
}

class _TaskSheetState extends State<TaskSheet> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 412.w,
      height: 350.h,
      padding: REdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Add New Task',
              textAlign: TextAlign.center,
              style: AppTextStyles.taskSheetTitleTextStyle),
          SizedBox(
            height: 8.h,
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Enter Your Task',
                hintStyle: AppTextStyles.hintTextStyle),
          ),
          SizedBox(
            height: 8.h,
          ),
          TextFormField(
            decoration: InputDecoration(
                hintText: 'Enter Your Task Description',
                hintStyle: AppTextStyles.hintTextStyle),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            'Select Date ',
            style: AppTextStyles.dateLabelTextStyle,
          ),
          SizedBox(
            height: 8.h,
          ),
          InkWell(
              onTap: () {
                showTaskDatePicker();
              },
              child: Text(
                selectedDate.toFormattedDate(),
                textAlign: TextAlign.center,
                style: AppTextStyles.hintTextStyle,
              )),
          Spacer(),
          ElevatedButton(
              onPressed: () {},
              child: Text('Add', style: AppTextStyles.elevatedButtonText))
        ],
      ),
    );
  }

  void showTaskDatePicker() async {
    selectedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365))) ??
        selectedDate;
    setState(() {});
  }
}
