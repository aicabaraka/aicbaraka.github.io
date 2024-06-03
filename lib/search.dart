
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:aicbaraka/auth/glassbox.dart';
import 'package:aicbaraka/sermonsgv.dart';
import 'package:aicbaraka/teamsgv.dart';

import 'auth/songsgv.dart';
import 'developments.dart';
import 'developmentsgv.dart';
import 'eventsgv.dart';













class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with SingleTickerProviderStateMixin {
  final user = FirebaseAuth.instance.currentUser!;
  late TabController tabController;
  @override
  void  initState(){
    super.initState();
    tabController = TabController(length: 5, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()
          ),
          children: <Widget>[
            Stack(
              children: <Widget>[

                const AppBarr(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 5,),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {

                          },
                          child: AnimatedTextKit(
                            animatedTexts: [
                              TyperAnimatedText('Sermons ',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),

                              TyperAnimatedText('Sermons',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),

                              TyperAnimatedText('Developments',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),

                            ],
                            pause: const Duration(milliseconds: 3000),

                            stopPauseOnTap: true,
                            repeatForever: true,
                          ),
                        ),
                      ],
                    ),


                    const SizedBox(width: 5,),
                  ],
                ),



              ],
            ),

            TabBar(
              controller: tabController,
              indicatorColor: Theme.of(context).primaryColor.withOpacity(0.8),
              // indicatorColor: Color(0xFFFE8A7E),
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 4.0,
              isScrollable: true,
              labelColor: const Color(0xFF440206),
              unselectedLabelColor: const Color(0xFF440206),
              tabs: const [
                Tab(
                  child: Text(
                    'Sermons',style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15.0,
                  ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Songs',style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15.0,

                  ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Events',style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15.0,

                  ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Developments',style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15.0,

                  ),
                  ),
                ),
                Tab(
                  child: Text(
                    'Teams',style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15.0,

                  ),
                  ),
                ),

              ],



            ),
            const SizedBox(height: 10.0,),
            Container(
              color: Colors.red,
              height: MediaQuery.of(context).size.height,
              child: TabBarView(
                controller: tabController,
                children:   <Widget>[
                  SermonsTab(),
                  SongsTab(),
                  EventsGvTab(),

                  DevelopmentsGvTab(),


                  TeamsTab(),
               //   DevtTab(),
                  //   EventsTabLocation(),












                ],
              ),
            ),


          ],
        ),
      ),
    );
  }


}

class AppBarr extends StatefulWidget {
  const AppBarr({Key? key}) : super(key: key);

  @override
  State<AppBarr> createState() => _AppBarrState();
}

class _AppBarrState extends State<AppBarr> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,

      decoration:  BoxDecoration(
          color: Colors.deepPurple.shade700,
          //   color: Color(0xFFFD7465),
          borderRadius: const BorderRadius.only(bottomRight: Radius.circular(95.0,),bottomLeft: Radius.circular(5.0,),topLeft:Radius.circular(95.0,),topRight: Radius.circular(5.0,)



          )
      ),
    );
  }
}



