import 'package:flutter/material.dart';
import 'package:todo/ui/home/widgets/tabs/settings_tab.dart';
import 'package:todo/ui/home/widgets/tabs/tasks_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<Widget> tabs =[
    TasksTab(),
    SettingsTab()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do List'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: BottomNavigationBar(
          currentIndex:currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          } ,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: ""
            ) ,
          BottomNavigationBarItem(
              icon:Icon(Icons.settings,),
          label: ""
          ),
          ],
        ),
      ),
      body: tabs[currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        child: const Icon(
          Icons.add,
          color: Colors.white,),
      ),
    );
  }
}
