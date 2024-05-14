

import 'package:application/screens/home_screen.dart';
import 'package:application/screens/project_screen.dart';
import 'package:application/widgets/icon_tab.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget{
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 4,
      child: Scaffold(
        body:  TabBarView(children: [
          HomePage(),
          ProjectScreen(),
          Text('3'),
          Text('4'),
        ]),
        bottomNavigationBar: TabBar(
            tabs: [
              IconTab(icon: Icon(Icons.home),text: '首页'),
              IconTab(icon: Icon(Icons.menu_book),text: '项目'),
              IconTab(icon: Icon(Icons.animation),text: '广场'),
              IconTab(icon: Icon(Icons.palette_rounded),text: '我的'),
            ]),
      ),
    );
  }
}

