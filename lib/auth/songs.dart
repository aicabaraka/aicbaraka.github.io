import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:aicbaraka/auth/songsgv.dart';

class Songs extends StatefulWidget {
  const Songs({Key? key}) : super(key: key);


  @override
  State<Songs> createState() => _SongsState();
}

class _SongsState extends State<Songs> {
  @override
  Widget build(BuildContext context) {

    bool _isLoading = false;




    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Songs',
                style: GoogleFonts.dmSerifDisplay(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              GestureDetector(
                //   onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => CarSearch()));},
                child: Row(
                  children: [

                    Icon(Icons.chevron_right,color: Colors.deepOrangeAccent[700],)
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 5,),


        Container(
          height: 200,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('songs')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('An error occurred while loading the data.'),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Lottie.asset('lib/assets/icons/loading.json');
              }

              if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text('No  details found.'),
                );
              }

              return ListView(
                scrollDirection: Axis.horizontal,
                children: snapshot.data!.docs.map((document) {
                  final name = document.get('name');
              //    final availability = document.get('availability');





                  final hotelId = document.get('id');
                  final user = FirebaseAuth.instance.currentUser;// <-- Get the hotel ID



                  bool _isLoading = false;






                  return  Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: GestureDetector(


                              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) =>  SongDetailScreen(document),),);},


                      child: Container(
                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withOpacity(0.4),
                        ),

                        width: 280,

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(



                              height: 160,

                              decoration: BoxDecoration(

                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.grey)
                              ),



                              child: Stack(
                                children: [


                                  Container(

                                    decoration: BoxDecoration(

                                      image: DecorationImage(image: AssetImage('lib/assets/images/event1.jpg',),fit: BoxFit.fitWidth),


                                      borderRadius: BorderRadius.circular(20),
                                      //  border: Border.all(color: Colors.grey)
                                      color: Colors.white.withOpacity(0.4),
                                    ),


                                    width: 300,
                                    height: 160,
                                  ),




                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 13.0,right: 13.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '$name',
                                    style: GoogleFonts.dmSerifDisplay(fontSize: 18,   color: Colors.black),
                                  ),


                                ],
                              ),
                            ),



                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),
        )

      ],
    );
  }
}

