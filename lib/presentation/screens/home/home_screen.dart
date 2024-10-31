import 'package:flutter/material.dart';
import 'package:to_do/presentation/screens/home/tabs/settings_tab/settings_tab.dart';
import 'package:to_do/presentation/screens/home/tabs/tasks_tab/tasks_tab.dart';
import 'package:to_do/presentation/screens/home/task_bottom_sheet/task_sheet.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  List<Widget> tabs = [TasksTab(), SettingsTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: 100,
        title: Text(
          'To Do List',
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
              BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Tasks'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: 'Settings'),
            ]),
      );

  void onTap(int index) {
    currentIndex = index;
    setState(() {});
  }

  Widget buildFAB() => FloatingActionButton(
        onPressed: () {
          showBottomSheet();
        },
        child: Icon(Icons.add),
      );

  void showBottomSheet() {
    showModalBottomSheet(context: context, builder: (context) => TaskSheet());
  }
}
