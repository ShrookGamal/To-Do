import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:to_do/core/utils/colors_manager.dart';
import 'package:to_do/core/utils/date_style.dart';
import 'package:to_do/core/utils/text_styles.dart';

import '../../../../../../core/utils/dialog_utils/dialog_util.dart';
import '../../../../../../database_manager/models/todo_dm.dart';
import '../../../../../../database_manager/models/users_dm.dart';
import '../../../../../../providers/settings_provider.dart';

class EditTask extends StatefulWidget {
  final TodoDM todoDM;

  EditTask({super.key, required this.todoDM});

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  late TodoDM todoDM;
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDesController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    todoDM = widget.todoDM;
    taskTitleController.text = todoDM.title;
    taskDesController.text = todoDM.description;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    bool isLight = provider.isLight();
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
        toolbarHeight: 100.h,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: 352.w,
          height: 617.h,
          color: provider.isLight() ? Colors.white : ColorsManager.darkBlack,
          padding: REdgeInsets.all(20),
          margin: REdgeInsets.symmetric(vertical: 100.h, horizontal: 30.w),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  AppLocalizations.of(context)!.editTask,
                  style: AppTextStyles.editTitle(isLight),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10.h,
                ),
                Text(AppLocalizations.of(context)!.taskTitle,
                    style: AppTextStyles.dateLabelTextStyle(isLight)),
                SizedBox(height: 5.h),
                TextFormField(
                  controller: taskTitleController,
                  decoration: InputDecoration(
                    hintText: todoDM.title,
                  ),
                ),
                SizedBox(
                  height: 30.h,
                ),
                Text(AppLocalizations.of(context)!.taskDescription,
                    style: AppTextStyles.dateLabelTextStyle(isLight)),
                SizedBox(height: 5.h),
                TextFormField(
                  controller: taskDesController,
                  decoration: InputDecoration(
                    hintText: todoDM.description,
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Text(
                  AppLocalizations.of(context)!.dateLabel,
                  style: AppTextStyles.dateLabelTextStyle(isLight),
                ),
                SizedBox(height: 10.h),
                InkWell(
                  onTap: () {
                    showTaskDatePicker();
                  },
                  child: Text(
                    todoDM.dateTime.toFormattedDate(),
                    textAlign: TextAlign.center,
                    style: AppTextStyles.hintTextStyle(isLight),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                ElevatedButton(
                  onPressed: () {
                    updateTask();
                  },
                  child: Text(AppLocalizations.of(context)!.saveChanges,
                      style: AppTextStyles.elevatedButtonText),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showTaskDatePicker() async {
    todoDM.dateTime = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime.now().add(Duration(days: 365))) ??
        todoDM.dateTime;
    setState(() {});
  }

  Future<void> updateTask() async {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(UserDM.currentUser!.id)
        .collection(TodoDM.collectionName);

    DocumentReference documentReference = collectionReference.doc(todoDM.id);

    try {
      documentReference.update({
        'title': taskTitleController.text,
        'description': taskDesController.text,
        'dateTime': todoDM.dateTime,
      });
      DialogUtils.showLoginMessage(
          context, AppLocalizations.of(context)!.editSuccessful);
    } catch (error) {
      if (mounted) {
        DialogUtils.hide(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppLocalizations.of(context)!.failedEdit)),
        );
      }
    }
  }
}
