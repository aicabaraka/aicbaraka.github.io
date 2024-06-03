

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:aicbaraka/admin/adminprofile.dart';
import 'package:aicbaraka/search.dart';
import 'package:aicbaraka/youtubeplayer.dart';

import 'homepage.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);
  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: false,
        body: Center(child: getSelectedWidget(index: index),),

        bottomNavigationBar:BottomNavigationBar(
          items:   const [
            BottomNavigationBarItem(
                icon: Image(image: AssetImage('lib/assets/images/event1.jpg'),height: 20,),activeIcon: Icon(Icons.home_filled), label: 'Homes'),
            BottomNavigationBarItem(
                icon: Icon(Icons.search,),activeIcon: Icon(Icons.security_rounded), label: 'Search') ,

            BottomNavigationBarItem(
                icon: Icon(Icons.person),activeIcon: Icon(Icons.person), label: 'Profile'),
          ],
          currentIndex: index,
          elevation: 0,
          selectedItemColor: Colors.deepOrangeAccent,
          unselectedItemColor: Colors.deepPurple.shade900,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,


          backgroundColor: Colors.transparent,

          onTap: (selectedIndex){
            setState(() {
              index = selectedIndex;
            });
          },

        ),

    );
  }

   Widget getSelectedWidget({required int index}){
    Widget widget;
    switch(index){
      case 0:
     //   widget =  YouTubePlayerPage();
        widget = const HomePage();
        break;
        case 1:
        widget =  const MyPage();
        break;
        //   case 2:
        //     widget = const HotelP();
        // widget = const MusicScreen();
        break;
      default:
        widget =   const AdminProfile();
     //   widget =   FbImage();
        //  widget = bMyApp();

        break;
    }
    return widget;
  }










}


