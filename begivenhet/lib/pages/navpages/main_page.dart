import 'package:begivenhet/details/datails_page.dart';
import 'package:begivenhet/pages/home_page.dart';
import 'package:begivenhet/pages/navpages/search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../details/groups_details.dart';
import '../../test/test.dart';
import 'all_events_page.dart';
import 'home_page.dart';
import 'my_profile.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);



  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages=[

    HomePage(),
    SearchPage(),
    AllEvents(),
   ProfileScreen(),
   // IncludeDrawerContent(),
    //GroupDetails(groupItem: null,),
    //ToolbarCollapseRoute()
    //DetailPage()
  ];
 int currentIndex = 0;
  void onTap(int index){
    setState(() {
      currentIndex=index;
    });

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      //bottom navigation view
      bottomNavigationBar: BottomNavigationBar(

        unselectedFontSize: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        //elevation: 0,
        items: const [
          BottomNavigationBarItem(label:'Home' ,icon: Icon(Icons.apps)),
          BottomNavigationBarItem(label:'Search' ,icon: Icon(Icons.search)),
          BottomNavigationBarItem(label:'Events' ,icon: Icon(Icons.event_note_outlined)),
          BottomNavigationBarItem(label:'Profile' ,icon: Icon(Icons.person)),

        ],
      ),
    );
  }
}
