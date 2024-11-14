import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do/presentation/screens/home/tabs/settings_tab/settings_tab.dart';
import 'package:to_do/presentation/screens/home/tabs/tasks_tab/tasks_tab.dart';
import 'package:to_do/presentation/screens/home/task_bottom_sheet/task_sheet.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<TasksTabState> tasksTabKey = GlobalKey();
  int currentIndex = 0;
  List<Widget> tabs = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabs = [
      TasksTab(
        key: tasksTabKey,
      ),
      SettingsTab()
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          AppLocalizations.of(context)!.appTitle,
        ),
      ),
      bottomNavigationBar: buildBottomNavBar(),
      floatingActionButton: buildFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: tabs[currentIndex],
    );
  }

  buildBottomNavBar() => BottomAppBar(
        notchMargin: 8,
        child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: onTap,
            items: [
              BottomNavigationBarItem(
                  icon: const Icon(Icons.list),
                  label: AppLocalizations.of(context)!.tasks),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.settings),
                  label: AppLocalizations.of(context)!.settings),
            ]),
      );

  void onTap(int index) {
    currentIndex = index;
    setState(() {});
  }

  Widget buildFAB() => FloatingActionButton(
        onPressed: () async {
          await showBottomSheet();
          tasksTabKey.currentState?.getTodoFromFireStore();
        },
        child: const Icon(Icons.add),
      );

  Future showBottomSheet() {
    return showModalBottomSheet(
        context: context,
        builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: const TaskSheet(),
            ),
        isScrollControlled: true);
  }
}
