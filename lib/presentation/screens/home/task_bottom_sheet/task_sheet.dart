import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:to_do/core/utils/date_style.dart';
import 'package:to_do/database_manager/models/todo_dm.dart';

import '../../../../core/utils/text_styles.dart';
import '../../../../database_manager/models/users_dm.dart';
import '../../../../providers/settings_provider.dart';

class TaskSheet extends StatefulWidget {
  const TaskSheet({super.key});

  @override
  State<TaskSheet> createState() => _TaskSheetState();
}

class _TaskSheetState extends State<TaskSheet> {
  DateTime selectedDate = DateTime.now();
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDesController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    bool isLight = provider.isLight();
    return Container(
      width: 412.w,
      height: 350.h,
      padding: REdgeInsets.all(12),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(AppLocalizations.of(context)!.addNewTask,
                textAlign: TextAlign.center,
                style: AppTextStyles.taskSheetTitleTextStyle(isLight)),
            SizedBox(
              height: 8.h,
            ),
            TextFormField(
              validator: (input) {
                if (input == null || input.trim().isEmpty) {
                  return AppLocalizations.of(context)!.emptyTask;
                }
                return null;
              },
              controller: taskTitleController,
              decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.taskLabel,
                  hintStyle: AppTextStyles.hintTextStyle(isLight)),
            ),
            SizedBox(
              height: 8.h,
            ),
            TextFormField(
              validator: (input) {
                if (input == null || input.trim().isEmpty) {
                  return AppLocalizations.of(context)!.emptyDescription;
                }
                if (input.length < 6) {
                  return AppLocalizations.of(context)!.shortDescription;
                }
                return null;
              },
              controller: taskDesController,
              decoration: InputDecoration(
                  hintText: AppLocalizations.of(context)!.taskDescriptionLabel,
                  hintStyle: AppTextStyles.hintTextStyle(isLight)),
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              AppLocalizations.of(context)!.dateLabel,
              style: AppTextStyles.dateLabelTextStyle(isLight),
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
                  style: AppTextStyles.hintTextStyle(isLight),
                )),
            const Spacer(),
            ElevatedButton(
                onPressed: () {
                  addTaskToFireStore();
                },
                child: Text(AppLocalizations.of(context)!.addButton,
                    style: AppTextStyles.elevatedButtonText))
          ],
        ),
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

  addTaskToFireStore() {
    if (formKey.currentState!.validate() == false) return;
    // هنا عملت object من ال database و عملت collection جواه و اخدت reference بيشاور عليه
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection(UserDM.collectionName)
        .doc(UserDM.currentUser!.id)
        .collection(TodoDM.collectionName);
    // عملت doc جوا ال collection  اخدت منه reference برضو
    DocumentReference documentReference = collectionReference.doc();
    TodoDM todoTask = TodoDM(
        id: documentReference.id,
        title: taskTitleController.text,
        description: taskDesController.text,
        dateTime: selectedDate,
        isDone: false);
    documentReference
        .set(todoTask.toFireStore())
        .then((_) {})
        .onError(
          (error, stackTrace) {},
        )
        .timeout(const Duration(microseconds: 500), onTimeout: () {
      if (context.mounted) {
        Navigator.pop(context);
      }
    });
  }
}
