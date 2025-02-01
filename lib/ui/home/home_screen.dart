import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/ui/home/widgets/addTask.dart';
import 'package:todo/ui/home/widgets/tabs/settings_tab.dart';
import 'package:todo/ui/home/widgets/tabs/tasks_tab.dart';
import 'package:todo/ui/login/login_screen.dart';

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
        actions: [
          IconButton(
            onPressed: (){
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
            icon: const Icon(Icons.logout),
          )
        ],
        title: const Text('To Do List'),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          currentIndex:currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          } ,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.list,size: 30,),
              label: ""
            ) ,
          BottomNavigationBarItem(
              icon:Icon(Icons.settings,size: 30,),
          label: ""
          ),
          ],
        ),
      ),
      body: tabs[currentIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(
            isScrollControlled: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            context: context,
              builder:(context) =>AddTask() , );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,),
      ),
    );
  }
}
