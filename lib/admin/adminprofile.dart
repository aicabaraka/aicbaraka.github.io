import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';



import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:aicbaraka/admin/pledgesadmin.dart';
import 'package:aicbaraka/admin/prayergroupadmin.dart';
import 'package:aicbaraka/admin/teamsadmin.dart';
import 'package:aicbaraka/auth/glassbox.dart';


import '../useradmin.dart';
import 'addpastor.dart';
import 'addstaff.dart';
import 'allstaff.dart';
import 'counters.dart';
import 'developmentsadmin.dart';

import 'editdevelopment.dart';
import 'editprofile.dart';
import 'eventsadmin.dart';
import 'developmentsadmin.dart';
import 'pastorsadmin.dart';
import 'songsadmin.dart';
import 'sermonsadmin.dart';

import 'membersadmin.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({Key? key}) : super(key: key);

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return UserAdmin();
  }
}

class AdSwitcher extends StatefulWidget {
  const AdSwitcher({Key? key}) : super(key: key);

  @override
  State<AdSwitcher> createState() => _AdSwitcherState();
}

class _AdSwitcherState extends State<AdSwitcher> {
  final user = FirebaseAuth.instance.currentUser!;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(

          image: DecorationImage(
            image: AssetImage('lib/assets/images/logo.jpg'),
            fit: BoxFit.cover,
          )
      ),
      child: GlassBoxxx(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child:   Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),

              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.deepPurple.shade700, // Set the border color here

                width: 1.5, // Set the border width here

              ),

            ),
            child: Column(
              children: [
                Avatar(avatar: user.email!),
                UserName(username: user.email!),
                SizedBox(height: 10,),
                Container(


                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),

                    borderRadius: BorderRadius.circular(30),


                    border: Border.all(

                      color: Colors.white, // Set the border color here

                      width: 1.5, // Set the border width here

                    ),

                  ),

                  // width: 250,

                  child: Padding(

                    padding: const EdgeInsets.all(8.0),

                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(height: 10,),
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('admin')
                              .where('email', isEqualTo: user.email!)
                              .where('role', isEqualTo: 'admin')
                              .snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return const Text('Loading...');
                            }
                            if (snapshot.data!.docs.isEmpty) {

                                // Data not found in "djs" table, fetch from "users" table instead
                                return StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection('admin')
                                      .where('email', isEqualTo: user.email!)
                                      .where('role', whereIn: ['IT', 'pastor','team','Finance','Development','Song','Event'])
                                      .snapshots(),
                                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (!snapshot.hasData) {
                                      return const Text('Loading...');
                                    }

                                    if (snapshot.data!.docs.isEmpty) {
                                      return const Text('Data not found');
                                    }
                                    List roles = snapshot.data!.docs.map((doc) => doc.get('role')).toList();



                                    String image = snapshot.data!.docs[0].get('imageurl');
                                    return Column(
                                      children: [
                                        if (roles.contains('IT'))
                                          Container(
                                            child: Column(
                                              children: [

                                                Row(

                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                                  children: [
                                                    //PLedges
                                                    Container(

                                                      decoration:BoxDecoration(

                                                          borderRadius: BorderRadius.circular(12),

                                                          color: Colors.deepPurpleAccent.withOpacity(0.5)

                                                      ),

                                                      child: GestureDetector(
                                                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => PledgesTab(),),);},







                                                        child: Padding(

                                                          padding: const EdgeInsets.all(4.0),

                                                          child: Row(

                                                            children: [
                                                              PledgesCounter(),
                                                              SizedBox(width: 2,),

                                                              Text('Pledges',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),

                                                              Icon(

                                                                Icons.handshake_outlined,

                                                                color: Colors.yellow,

                                                                size: 25,

                                                              ),

                                                            ],

                                                          ),

                                                        ),

                                                      ),

                                                    ),
                                                    //Paybill
                                                    Container(

                                                      decoration:BoxDecoration(

                                                          borderRadius: BorderRadius.circular(12),

                                                          color: Colors.deepPurpleAccent.withOpacity(0.5)

                                                      ),

                                                      child: GestureDetector(
                                                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => EditPaybill(docId: '4oZlcJE7UzyrXMGUnPzy',),),);},








                                                        child: Padding(

                                                          padding: const EdgeInsets.all(4.0),

                                                          child: Row(

                                                            children: [

                                                              Text('Church PayBill',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),

                                                              Icon(

                                                                Icons.local_atm_outlined,

                                                                color: Colors.yellow,

                                                                size: 25,

                                                              ),

                                                            ],

                                                          ),

                                                        ),

                                                      ),

                                                    ),
                                                  ],

                                                ),
                                                SizedBox(height: 10,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                                  children: [
                                                    //Members
                                                    Container(

                                                      decoration:BoxDecoration(

                                                          borderRadius: BorderRadius.circular(12),

                                                          color: Colors.deepPurpleAccent.withOpacity(0.5)

                                                      ),

                                                      child: GestureDetector(
                                                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => MembersTab(),),);},







                                                        child: Padding(

                                                          padding: const EdgeInsets.all(4.0),

                                                          child: Row(

                                                            children: [
                                                              MembersCounter(),
                                                              SizedBox(width: 2,),

                                                              Text('Church Members',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),

                                                              Icon(

                                                                Icons.people,

                                                                color: Colors.yellow,

                                                                size: 25,

                                                              ),

                                                            ],

                                                          ),

                                                        ),

                                                      ),

                                                    ),
                                                    //Sermons
                                                    Container(

                                                      decoration:BoxDecoration(

                                                          borderRadius: BorderRadius.circular(12),

                                                          color: Colors.deepPurpleAccent.withOpacity(0.5)

                                                      ),

                                                      child: GestureDetector(
                                                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SermonsTab(),),);},








                                                        child: Padding(

                                                          padding: const EdgeInsets.all(4.0),

                                                          child: Row(

                                                            children: [
                                                              SermonsCounter(),
                                                              SizedBox(width: 2,),

                                                              Text('Sermons',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),

                                                              Icon(

                                                                Icons.book_outlined,

                                                                color: Colors.yellow,

                                                                size: 25,

                                                              ),

                                                            ],

                                                          ),

                                                        ),

                                                      ),

                                                    ),



                                                  ],

                                                ),

                                                const SizedBox(height: 10,),
                                                Row(

                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                                  children: [
//songs
                                                    Container(

                                                      decoration:BoxDecoration(

                                                          borderRadius: BorderRadius.circular(12),

                                                          color: Colors.deepPurpleAccent.withOpacity(0.5)

                                                      ),

                                                      child: GestureDetector(
                                                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SongsTab(),),);},








                                                        child: Padding(

                                                          padding: const EdgeInsets.all(4.0),

                                                          child: Row(

                                                            children: [
                                                              SongsCounter(),
                                                              SizedBox(width: 2,),

                                                              Text('Songs',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),

                                                              Icon(

                                                                Icons.music_note_outlined,

                                                                color: Colors.yellow,

                                                                size: 25,

                                                              ),

                                                            ],

                                                          ),

                                                        ),

                                                      ),

                                                    ),
//Pastors
                                                    Container(

                                                      decoration:BoxDecoration(

                                                          borderRadius: BorderRadius.circular(12),

                                                          color: Colors.deepPurpleAccent.withOpacity(0.5)

                                                      ),

                                                      child: GestureDetector(
                                                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => PastorsTab(),),);},







                                                        child: Padding(

                                                          padding: const EdgeInsets.all(4.0),

                                                          child: Row(

                                                            children: [
                                                              PastorsCounter(),
                                                              SizedBox(width: 2,),

                                                              Text('Pastors',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),

                                                              Icon(

                                                                Icons.people_outline_rounded,

                                                                color: Colors.yellow,

                                                                size: 25,

                                                              ),

                                                            ],

                                                          ),

                                                        ),

                                                      ),

                                                    ),



                                                  ],

                                                ),
                                                const SizedBox(height: 10,),
                                                Row(

                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                                  children: [
                                                    //TEams
                                                    Container(

                                                      decoration:BoxDecoration(

                                                          borderRadius: BorderRadius.circular(12),

                                                          color: Colors.deepPurpleAccent.withOpacity(0.5)

                                                      ),

                                                      child: GestureDetector(
                                                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => TeamsTabAdmin(),),);},








                                                        child: Padding(

                                                          padding: const EdgeInsets.all(4.0),

                                                          child: Row(

                                                            children: [
                                                              TeamsCounter(),
                                                              SizedBox(width: 2,),

                                                              Text('Teams',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),

                                                              Icon(

                                                                Icons.favorite,

                                                                color: Colors.yellow,

                                                                size: 25,

                                                              ),

                                                            ],

                                                          ),

                                                        ),

                                                      ),

                                                    ),
                                                    //EVents
                                                    Container(

                                                      decoration:BoxDecoration(

                                                          borderRadius: BorderRadius.circular(12),

                                                          color: Colors.deepPurpleAccent.withOpacity(0.5)

                                                      ),

                                                      child: GestureDetector(
                                                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => EventsTab(),),);},







                                                        child: Padding(

                                                          padding: const EdgeInsets.all(4.0),

                                                          child: Row(

                                                            children: [
                                                              EventsCounter(),
                                                              SizedBox(width: 2,),

                                                              Text('Events',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),

                                                              Icon(

                                                                Icons.event_available_rounded,

                                                                color: Colors.yellow,

                                                                size: 25,

                                                              ),

                                                            ],

                                                          ),

                                                        ),

                                                      ),

                                                    ),



                                                  ],

                                                ),
                                                const SizedBox(height: 10,),
                                                //Developments
                                                Row(

                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                                  children: [

                                                    Container(

                                                      decoration:BoxDecoration(

                                                          borderRadius: BorderRadius.circular(12),

                                                          color: Colors.deepPurpleAccent.withOpacity(0.5)

                                                      ),

                                                      child: GestureDetector(
                                                        // onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => AddEvent(),),);},
                                                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DevelopmentTab(),),);},









                                                        child: Padding(

                                                          padding: const EdgeInsets.all(4.0),

                                                          child: Row(

                                                            children: [
                                                              DevelopmentsCounter(),
                                                              SizedBox(width: 2,),

                                                              Text('Developments',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),

                                                              Icon(

                                                                Icons.hourglass_bottom,

                                                                color: Colors.yellow,

                                                                size: 25,

                                                              ),

                                                            ],

                                                          ),

                                                        ),

                                                      ),

                                                    ),





                                                  ],

                                                ),
                                              ],
                                            ),
                                            // IT Container
                                          ),

                                        if (roles.contains('Finance'))
                                          Container(
                                            child: Column(
                                              children: [

                                                Row(

                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                                  children: [
                                                    //PLedges
                                                    Container(

                                                      decoration:BoxDecoration(

                                                          borderRadius: BorderRadius.circular(12),

                                                          color: Colors.deepPurpleAccent.withOpacity(0.5)

                                                      ),

                                                      child: GestureDetector(
                                                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => PledgesTab(),),);},







                                                        child: Padding(

                                                          padding: const EdgeInsets.all(4.0),

                                                          child: Row(

                                                            children: [
                                                              PledgesCounter(),
                                                              SizedBox(width: 2,),

                                                              Text('Pledges',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),

                                                              Icon(

                                                                Icons.handshake_outlined,

                                                                color: Colors.yellow,

                                                                size: 25,

                                                              ),

                                                            ],

                                                          ),

                                                        ),

                                                      ),

                                                    ),
                                                    //Paybill
                                                    Container(

                                                      decoration:BoxDecoration(

                                                          borderRadius: BorderRadius.circular(12),

                                                          color: Colors.deepPurpleAccent.withOpacity(0.5)

                                                      ),

                                                      child: GestureDetector(
                                                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => EditPaybill(docId: '4oZlcJE7UzyrXMGUnPzy',),),);},








                                                        child: Padding(

                                                          padding: const EdgeInsets.all(4.0),

                                                          child: Row(

                                                            children: [

                                                              Text('Church PayBill',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),

                                                              Icon(

                                                                Icons.local_atm_outlined,

                                                                color: Colors.yellow,

                                                                size: 25,

                                                              ),

                                                            ],

                                                          ),

                                                        ),

                                                      ),

                                                    ),
                                                  ],

                                                ),
                                                SizedBox(height: 10,),

                                              ],
                                            ),
                                            // IT Container
                                          ),
                                        if (roles.contains('team'))
                                          Container(
                                            child: Column(
                                              children: [
                                                Row(

                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                                  children: [
                                                    //TEams
                                                    Container(

                                                      decoration:BoxDecoration(

                                                          borderRadius: BorderRadius.circular(12),

                                                          color: Colors.deepPurpleAccent.withOpacity(0.5)

                                                      ),

                                                      child: GestureDetector(
                                                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => TeamsTabAdmin(),),);},








                                                        child: Padding(

                                                          padding: const EdgeInsets.all(4.0),

                                                          child: Row(

                                                            children: [
                                                              TeamsCounter(),
                                                              SizedBox(width: 2,),

                                                              Text('Teams',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),

                                                              Icon(

                                                                Icons.favorite,

                                                                color: Colors.yellow,

                                                                size: 25,

                                                              ),

                                                            ],

                                                          ),

                                                        ),

                                                      ),

                                                    ),
                                                    //EVents
                                                    Container(

                                                      decoration:BoxDecoration(

                                                          borderRadius: BorderRadius.circular(12),

                                                          color: Colors.deepPurpleAccent.withOpacity(0.5)

                                                      ),

                                                      child: GestureDetector(
                                                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => EventsTab(),),);},







                                                        child: Padding(

                                                          padding: const EdgeInsets.all(4.0),

                                                          child: Row(

                                                            children: [
                                                              EventsCounter(),
                                                              SizedBox(width: 2,),

                                                              Text('Events',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),

                                                              Icon(

                                                                Icons.event_available_rounded,

                                                                color: Colors.yellow,

                                                                size: 25,

                                                              ),

                                                            ],

                                                          ),

                                                        ),

                                                      ),

                                                    ),



                                                  ],

                                                ),
                                                const SizedBox(height: 10,),
                                                Row(

                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                                  children: [

                                                    Container(

                                                      decoration:BoxDecoration(

                                                          borderRadius: BorderRadius.circular(12),

                                                          color: Colors.deepPurpleAccent.withOpacity(0.5)

                                                      ),

                                                      child: GestureDetector(
                                                        // onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => AddEvent(),),);},
                                                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DevelopmentTab(),),);},









                                                        child: Padding(

                                                          padding: const EdgeInsets.all(4.0),

                                                          child: Row(

                                                            children: [
                                                              DevelopmentsCounter(),
                                                              SizedBox(width: 2,),

                                                              Text('Developments',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),

                                                              Icon(

                                                                Icons.hourglass_bottom,

                                                                color: Colors.yellow,

                                                                size: 25,

                                                              ),

                                                            ],

                                                          ),

                                                        ),

                                                      ),

                                                    ),





                                                  ],

                                                ),
                                                SizedBox(height: 10,),

                                              ],
                                            ),
                                            // IT Container
                                          ),
                                        if (roles.contains('Event'))
                                          Container(

                                            decoration:BoxDecoration(

                                                borderRadius: BorderRadius.circular(12),

                                                color: Colors.deepPurpleAccent.withOpacity(0.5)

                                            ),

                                            child: GestureDetector(
                                              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => EventsTab(),),);},







                                              child: Padding(

                                                padding: const EdgeInsets.all(4.0),

                                                child: Row(

                                                  children: [
                                                    EventsCounter(),
                                                    SizedBox(width: 2,),

                                                    Text('Events',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),

                                                    Icon(

                                                      Icons.event_available_rounded,

                                                      color: Colors.yellow,

                                                      size: 25,

                                                    ),

                                                  ],

                                                ),

                                              ),

                                            ),

                                          ),
                                        if (roles.contains('pastor'))
                                          Container(
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                                  children: [
                                                    //Members
                                                    Container(

                                                      decoration:BoxDecoration(

                                                          borderRadius: BorderRadius.circular(12),

                                                          color: Colors.deepPurpleAccent.withOpacity(0.5)

                                                      ),

                                                      child: GestureDetector(
                                                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => MembersTab(),),);},







                                                        child: Padding(

                                                          padding: const EdgeInsets.all(4.0),

                                                          child: Row(

                                                            children: [
                                                              MembersCounter(),
                                                              SizedBox(width: 2,),

                                                              Text('Church Members',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),

                                                              Icon(

                                                                Icons.people,

                                                                color: Colors.yellow,

                                                                size: 25,

                                                              ),

                                                            ],

                                                          ),

                                                        ),

                                                      ),

                                                    ),
                                                    //Sermons
                                                    Container(

                                                      decoration:BoxDecoration(

                                                          borderRadius: BorderRadius.circular(12),

                                                          color: Colors.deepPurpleAccent.withOpacity(0.5)

                                                      ),

                                                      child: GestureDetector(
                                                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SermonsTab(),),);},








                                                        child: Padding(

                                                          padding: const EdgeInsets.all(4.0),

                                                          child: Row(

                                                            children: [
                                                              SermonsCounter(),
                                                              SizedBox(width: 2,),

                                                              Text('Sermons',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),

                                                              Icon(

                                                                Icons.book_outlined,

                                                                color: Colors.yellow,

                                                                size: 25,

                                                              ),

                                                            ],

                                                          ),

                                                        ),

                                                      ),

                                                    ),



                                                  ],

                                                ),
                                                SizedBox(height: 20,),
                                                Container(

                                                  decoration:BoxDecoration(

                                                      borderRadius: BorderRadius.circular(12),

                                                      color: Colors.deepPurpleAccent.withOpacity(0.5)

                                                  ),

                                                  child: GestureDetector(
                                                    onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SongsTab(),),);},








                                                    child: Padding(

                                                      padding: const EdgeInsets.all(4.0),

                                                      child: Row(

                                                        children: [
                                                          SongsCounter(),
                                                          SizedBox(width: 2,),

                                                          Text('Songs',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),

                                                          Icon(

                                                            Icons.music_note_outlined,

                                                            color: Colors.yellow,

                                                            size: 25,

                                                          ),

                                                        ],

                                                      ),

                                                    ),

                                                  ),

                                                ),
                                              ],
                                            ),
                                          ),


                                      ],
                                    );
                                  },
                                );

                              }
                            //String image = snapshot.data!.docs[0].get('artistname');
                            String image = snapshot.data!.docs[0].get('imageurl');
                            return Column(
                              children: [
                                Row(

                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: [
//PLedges
                                    Container(

                                      decoration:BoxDecoration(

                                          borderRadius: BorderRadius.circular(12),

                                          color: Colors.deepPurpleAccent.withOpacity(0.5)

                                      ),

                                      child: GestureDetector(
                                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => PledgesTab(),),);},







                                        child: Padding(

                                          padding: const EdgeInsets.all(4.0),

                                          child: Row(

                                            children: [
                                              PledgesCounter(),
                                              SizedBox(width: 2,),

                                              Text('Pledges',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),

                                              Icon(

                                                Icons.handshake_outlined,

                                                color: Colors.yellow,

                                                size: 25,

                                              ),

                                            ],

                                          ),

                                        ),

                                      ),

                                    ),
//Paybill
                                    Container(

                                      decoration:BoxDecoration(

                                          borderRadius: BorderRadius.circular(12),

                                          color: Colors.deepPurpleAccent.withOpacity(0.5)

                                      ),

                                      child: GestureDetector(
                                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => EditPaybill(docId: '4oZlcJE7UzyrXMGUnPzy',),),);},








                                        child: Padding(

                                          padding: const EdgeInsets.all(4.0),

                                          child: Row(

                                            children: [

                                              Text('Church PayBill',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),

                                              Icon(

                                                Icons.local_atm_outlined,

                                                color: Colors.yellow,

                                                size: 25,

                                              ),

                                            ],

                                          ),

                                        ),

                                      ),

                                    ),
                                  ],

                                ),
                                SizedBox(height: 10,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: [
//Members
                                    Container(

                                      decoration:BoxDecoration(

                                          borderRadius: BorderRadius.circular(12),

                                          color: Colors.deepPurpleAccent.withOpacity(0.5)

                                      ),

                                      child: GestureDetector(
                                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => MembersTab(),),);},







                                        child: Padding(

                                          padding: const EdgeInsets.all(4.0),

                                          child: Row(

                                            children: [
                                              MembersCounter(),
                                              SizedBox(width: 2,),

                                              Text('Church Members',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),

                                              Icon(

                                                Icons.people,

                                                color: Colors.yellow,

                                                size: 25,

                                              ),

                                            ],

                                          ),

                                        ),

                                      ),

                                    ),
//Sermons
                                    Container(

                                      decoration:BoxDecoration(

                                          borderRadius: BorderRadius.circular(12),

                                          color: Colors.deepPurpleAccent.withOpacity(0.5)

                                      ),

                                      child: GestureDetector(
                                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SermonsTab(),),);},








                                        child: Padding(

                                          padding: const EdgeInsets.all(4.0),

                                          child: Row(

                                            children: [
                                              SermonsCounter(),
                                              SizedBox(width: 2,),

                                              Text('Sermons',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),

                                              Icon(

                                                Icons.book_outlined,

                                                color: Colors.yellow,

                                                size: 25,

                                              ),

                                            ],

                                          ),

                                        ),

                                      ),

                                    ),



                                  ],

                                ),

                                const SizedBox(height: 10,),
                                Row(

                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: [

                                    Container(

                                      decoration:BoxDecoration(

                                          borderRadius: BorderRadius.circular(12),

                                          color: Colors.deepPurpleAccent.withOpacity(0.5)

                                      ),

                                      child: GestureDetector(
                                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SongsTab(),),);},








                                        child: Padding(

                                          padding: const EdgeInsets.all(4.0),

                                          child: Row(

                                            children: [
                                              SongsCounter(),
                                              SizedBox(width: 2,),

                                              Text('Songs',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),

                                              Icon(

                                                Icons.music_note_outlined,

                                                color: Colors.yellow,

                                                size: 25,

                                              ),

                                            ],

                                          ),

                                        ),

                                      ),

                                    ),

                                    Container(

                                      decoration:BoxDecoration(

                                          borderRadius: BorderRadius.circular(12),

                                          color: Colors.deepPurpleAccent.withOpacity(0.5)

                                      ),

                                      child: GestureDetector(
                                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => PastorsTab(),),);},







                                        child: Padding(

                                          padding: const EdgeInsets.all(4.0),

                                          child: Row(

                                            children: [
                                              PastorsCounter(),
                                              SizedBox(width: 2,),

                                              Text('Pastors',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),

                                              Icon(

                                                Icons.people_outline_rounded,

                                                color: Colors.yellow,

                                                size: 25,

                                              ),

                                            ],

                                          ),

                                        ),

                                      ),

                                    ),



                                  ],

                                ),
                                const SizedBox(height: 10,),
                                Row(

                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: [
//TEams
                                    Container(

                                      decoration:BoxDecoration(

                                          borderRadius: BorderRadius.circular(12),

                                          color: Colors.deepPurpleAccent.withOpacity(0.5)

                                      ),

                                      child: GestureDetector(
                                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => TeamsTabAdmin(),),);},








                                        child: Padding(

                                          padding: const EdgeInsets.all(4.0),

                                          child: Row(

                                            children: [
                                              TeamsCounter(),
                                              SizedBox(width: 2,),

                                              Text('Teams',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),

                                              Icon(

                                                Icons.favorite,

                                                color: Colors.yellow,

                                                size: 25,

                                              ),

                                            ],

                                          ),

                                        ),

                                      ),

                                    ),
//EVents
                                    Container(

                                      decoration:BoxDecoration(

                                          borderRadius: BorderRadius.circular(12),

                                          color: Colors.deepPurpleAccent.withOpacity(0.5)

                                      ),

                                      child: GestureDetector(
                                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => EventsTab(),),);},







                                        child: Padding(

                                          padding: const EdgeInsets.all(4.0),

                                          child: Row(

                                            children: [
                                              EventsCounter(),
                                              SizedBox(width: 2,),

                                              Text('Events',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),

                                              Icon(

                                                Icons.event_available_rounded,

                                                color: Colors.yellow,

                                                size: 25,

                                              ),

                                            ],

                                          ),

                                        ),

                                      ),

                                    ),



                                  ],

                                ),
                                const SizedBox(height: 10,),
                                //Developments
                                Row(

                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                  children: [

                                    Container(

                                      decoration:BoxDecoration(

                                          borderRadius: BorderRadius.circular(12),

                                          color: Colors.deepPurpleAccent.withOpacity(0.5)

                                      ),

                                      child: GestureDetector(
                                        // onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => AddEvent(),),);},
                                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DevelopmentTab(),),);},









                                        child: Padding(

                                          padding: const EdgeInsets.all(4.0),

                                          child: Row(

                                            children: [
                                              DevelopmentsCounter(),
                                              SizedBox(width: 2,),

                                              Text('Developments',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),

                                              Icon(

                                                Icons.hourglass_bottom,

                                                color: Colors.yellow,

                                                size: 25,

                                              ),

                                            ],

                                          ),

                                        ),

                                      ),

                                    ),
                                    Container(

                                      decoration:BoxDecoration(

                                          borderRadius: BorderRadius.circular(12),

                                          color: Colors.deepPurpleAccent.withOpacity(0.5)

                                      ),

                                      child: GestureDetector(
                                        // onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => AddEvent(),),);},
                                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => PrayerGroupTab(),),);},









                                        child: Padding(

                                          padding: const EdgeInsets.all(4.0),

                                          child: Row(

                                            children: [
                                            //  PrayerGroupsCounter(),
                                              SizedBox(width: 2,),

                                              Text('Prayer Group',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),

                                              Icon(

                                                Icons.hourglass_bottom,

                                                color: Colors.yellow,

                                                size: 25,

                                              ),

                                            ],

                                          ),

                                        ),

                                      ),

                                    ),





                                  ],

                                ),
                                const SizedBox(height: 10,),
                                Row(

                                  children: [
                                    Container(

                                      decoration:BoxDecoration(

                                          borderRadius: BorderRadius.circular(12),

                                          color: Colors.deepPurpleAccent.withOpacity(0.5)
                                      ),

                                      child: GestureDetector(
                                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => AddStaff(),),);},








                                        child: Padding(

                                          padding: const EdgeInsets.all(4.0),

                                          child: Row(

                                            children: [
                                              TeamsCounter(),
                                              SizedBox(width: 2,),

                                              Text('Add Staff',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),

                                              Icon(

                                                Icons.favorite,

                                                color: Colors.yellow,

                                                size: 25,

                                              ),

                                            ],

                                          ),

                                        ),

                                      ),

                                    ),
                                    Container(

                                      decoration:BoxDecoration(

                                          borderRadius: BorderRadius.circular(12),

                                          color: Colors.deepPurpleAccent.withOpacity(0.5)

                                      ),

                                      child: GestureDetector(
                                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => StaffListView(),),);},








                                        child: Padding(

                                          padding: const EdgeInsets.all(4.0),

                                          child: Row(

                                            children: [
                                              TeamsCounter(),
                                              SizedBox(width: 2,),

                                              Text('View All Staff',style: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold),),

                                              Icon(

                                                Icons.favorite,

                                                color: Colors.yellow,

                                                size: 25,

                                              ),

                                            ],

                                          ),

                                        ),

                                      ),

                                    ),
                                  ],
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                ),

                                // Text('$image'),
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class Avatar extends StatelessWidget {
  final String avatar;
  const Avatar({required this.avatar});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('admin')
          .where('email', isEqualTo: avatar)
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
                .where('email', isEqualTo: avatar)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Text('Loading...');
              }

              if (snapshot.data!.docs.isEmpty) {
                return const Text('Data not found');
              }


              String image = snapshot.data!.docs[0].get('imageurl');
              return Column(
                children: [
                  ClipOval( 

                    child: Image.asset('$image',height: 90,) ,
                  ),



                ],
              );
            },
          );
        }

        //String image = snapshot.data!.docs[0].get('artistname');
        String image = snapshot.data!.docs[0].get('imageurl');
        return Column(
          children: [
            ClipOval(

              child: Image.asset('$image',height: 90,) ,
            ),
            // Text('$image'),
          ],
        );
      },
    );
  }

}

class UserName extends StatelessWidget {

  final String username;

  const UserName({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('admin')
          .where('email', isEqualTo: username)
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
                .where('email', isEqualTo: username)
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
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 1.0,color: Colors.white),
                    borderRadius: BorderRadius.circular(25)
                  ),
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

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(

              decoration:BoxDecoration(

                  borderRadius: BorderRadius.circular(12),

                  color: Colors.deepPurpleAccent.withOpacity(0.5)

              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Text('$image ',style: TextStyle(color: Colors.white,
                          fontSize: 18,
                        ),),
                        Icon(
                          Icons.edit,
                          color: Colors.yellow,
                          size: 25,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}


