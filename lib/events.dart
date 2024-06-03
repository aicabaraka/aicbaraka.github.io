

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'eventsgv.dart';

class Eventss extends StatefulWidget {
  const Eventss({Key? key}) : super(key: key);


  @override
  State<Eventss> createState() => _EventssState();
}

class _EventssState extends State<Eventss> {
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
                'Our Events',
                style: GoogleFonts.dmSerifDisplay(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              GestureDetector(
             //   onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => CarSearch()));},
                child: Row(
                  children: [

                    Icon(Icons.chevron_right,color: Colors.deepOrangeAccent.shade700,)
                  ],
                ),
              ),
            ],
          ),
        ),



        Container(

          height: 210,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('events')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
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
                  final name = document.get('eventname');
                  final eventdate = document.get('eventdate');
                  final starttime = document.get('starttime');
                  final endtime = document.get('endtime');
                  final price = document.get('price');
                  final availability = document.get('availability');


                  final imageurl = document.get('imageurl');


                  final hotelId = document.get('id');
                  final user = FirebaseAuth.instance.currentUser;// <-- Get the hotel ID



                  bool _isLoading = false;






                  return  Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: GestureDetector(

                     onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) =>  EventtiSingle(document),),);},


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

                                      image: DecorationImage(image: AssetImage('$imageurl',),fit: BoxFit.fitWidth),


                                      borderRadius: BorderRadius.circular(20),
                                      //  border: Border.all(color: Colors.grey)
                                      color: Colors.transparent,
                                    ),


                                    width: 300,
                                    height: 160,
                                  ),


                                  Positioned(
                                    top: 10,
                                    left: 10,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(60),
                                          color: Colors.white.withOpacity(0.8)
                                      ),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 0.0),
                                            child: Icon(Icons.monetization_on,color: Colors.green.shade700,),
                                          ),
                                          Text('$price',style: GoogleFonts.abrilFatface(fontSize: 20),)
                                        ],
                                      ),
                                    ),
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
                            Padding(
                              padding: const EdgeInsets.only(left: 13.0,right: 13.0),
                              child: Row(

                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [

                                  Text(
                                    '$eventdate',
                                    style: GoogleFonts.dmSerifDisplay(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple.shade700),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        '$starttime - $endtime',
                                        style: GoogleFonts.dmSerifDisplay(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.deepPurple.shade700),
                                      ),

                                      Text(
                                        '',
                                        style: GoogleFonts.dmSerifDisplay(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey),
                                      ),
                                    ],
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

