
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:aicbaraka/search.dart';

import 'admin/adminprofile.dart';
import 'admin/editprofile.dart';
import 'admin/prayergroupadmin.dart';
import 'admin/sermonsadmin.dart';
import 'admin/songsadmin.dart';
import 'eventsgv.dart';

class UserAdmin extends StatefulWidget {
  const UserAdmin({Key? key}) : super(key: key);

  @override
  State<UserAdmin> createState() => _UserAdminState();
}

class _UserAdminState extends State<UserAdmin> with SingleTickerProviderStateMixin {
  final user = FirebaseAuth.instance.currentUser!;
  late TabController tabController;
  @override
  void  initState(){
    super.initState();
    tabController = TabController(length: 1, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.deepPurple.shade800.withOpacity(0.8),
                Colors.deepPurple.shade200.withOpacity(0.8),

              ]
          )
      ),
      child: Scaffold(
        //   backgroundColor: Colors.red,
        body: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()
          ),
          children: <Widget>[
            Stack(
              children: <Widget>[

                AppBarr(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 5,),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {

                          },
                          child: AnimatedTextKit(
                            animatedTexts: [
                              TyperAnimatedText('View your Prayer group',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),

                              TyperAnimatedText('View Saved Sermons',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),

                              TyperAnimatedText('Write notes',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),

                            ],
                            pause: const Duration(milliseconds: 3000),

                            stopPauseOnTap: true,
                            repeatForever: true,
                          ),
                        ),
                      ],
                    ),
                   // GestureDetector(
                   //     onTap: () {},
                   //     child: Lottie.asset('lib/assets/icons/login.json',height: 70,)),

                    SizedBox(width: 5,),
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
              labelColor: Color(0xFF440206),
              unselectedLabelColor: Color(0xFF440206),
              tabs: const [
                Tab(
                  child: Text(
                    'Profile',style: TextStyle(
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
                  UserScreen(),
                  PrayerGroupTab(),
                  SongsTab(),
                  EventsGvTab(),
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


class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('admin')
              .where('email', isEqualTo: user.email!)
              .snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Text('Loading...');
            }

            if (snapshot.data!.docs.isEmpty) {
              // Data not found in "djs" table, fetch from "users" table instead
              return StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('email', isEqualTo: user.email!)
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Text('Loading...');
                  }

                  if (snapshot.data!.docs.isEmpty) {
                    return const Text('Data not found');
                  }



                  return Column(
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage('imageUrl'),
                      ),
                      const SizedBox(height: 10.0),
                      Container(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('admin')
                              .where('email', isEqualTo: user.email!)
                              .snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return const Text('Loading...');
                            }

                            if (snapshot.data!.docs.isEmpty) {
                              // Data not found in "djs" table, fetch from "users" table instead
                              return StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .where('email', isEqualTo: user.email!)
                                    .snapshots(),
                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Text('Loading...');
                                  }

                                  if (snapshot.data!.docs.isEmpty) {
                                    return const Text('Data not found');
                                  }

                                  String image = snapshot.data!.docs[0].get('firstname');
                                  String imagee = snapshot.data!.docs[0].get('lastname');
                                  return GestureDetector(
                                    onTap: () {
                                      final user=FirebaseAuth.instance.currentUser!;

                                      FirebaseFirestore.instance

                                          .collection('admin')

                                          .where('email', isEqualTo: user.email)

                                          .get()

                                          .then((QuerySnapshot snapshot) {

                                        if (snapshot.docs.isNotEmpty) {

                                          String docId = snapshot.docs[0].id;

                                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(docId: docId,),),);

                                        } else {
                                          String docId = snapshot.docs[0].id;

                                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(docId: docId,)),);

                                        }

                                      });

                                    },
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('$image $imagee',style: TextStyle(color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),),
                                        Icon(
                                          Icons.edit,
                                          color: Colors.deepPurpleAccent,
                                          size: 25,
                                        )
                                      ],
                                    ),
                                  );
                                },
                              );
                            }

                            String image = snapshot.data!.docs[0].get('firstname');
                            return  GestureDetector(

                              onTap: () {
                                final user=FirebaseAuth.instance.currentUser!;

                                FirebaseFirestore.instance

                                    .collection('admin')

                                    .where('email', isEqualTo: user.email)

                                    .get()

                                    .then((QuerySnapshot snapshot) {

                                  if (snapshot.docs.isNotEmpty) {

                                    String docId = snapshot.docs[0].id;

                                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(docId: docId,),),);

                                  } else {
                                    String docId = snapshot.docs[0].id;

                                    Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile(docId: docId,)),);

                                  }

                                });

                              },
                              child: Row(crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text('$image ',style: TextStyle(color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),),
                                  Icon(
                                    Icons.edit,
                                    color: Colors.deepPurpleAccent,
                                    size: 25,
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .where('email', isEqualTo: user.email!)
                              .snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return const Text('Loading...');
                            }

                            if (snapshot.data!.docs.isEmpty) {
                              // Data not found in "djs" table, fetch from "users" table instead
                              return StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .where('email', isEqualTo: user.email!)
                                    .snapshots(),
                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Text('Loading...');
                                  }

                                  if (snapshot.data!.docs.isEmpty) {
                                    return const Text('Weewe');
                                  }


                                  String image = snapshot.data!.docs[0].get('firstname');
                                  return Column(
                                    children: [


                                      Text('$image') ,




                                    ],
                                  );
                                },
                              );
                            }

                            //String image = snapshot.data!.docs[0].get('artistname');
                            String image = snapshot.data!.docs[0].get('firstname');
                            String imagee = snapshot.data!.docs[0].get('lastname');
                            return Column(
                              children: [


                                Text('$image $imagee',) ,


                                // Text('$image'),
                              ],
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 5.0),
                    ],
                  );
                  // return UserAdmin();
                },
              );
            }

            //String image = snapshot.data!.docs[0].get('artistname');

            return AdSwitcher();
          },
        ),
      ),
    );
  }
}



