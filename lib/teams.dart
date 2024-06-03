import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:aicbaraka/teamsgv.dart';

import 'auth/glassbox.dart';

class Teams extends StatefulWidget {
  Teams({Key? key}) : super(key: key);


  @override
  State<Teams> createState() => _TeamsState();
}

class _TeamsState extends State<Teams> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    //  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => CmSearch()));},
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Choirs',
                  style: GoogleFonts.dmSerifDisplay(fontSize: 18, fontWeight: FontWeight.bold, color: isDarkMode ? Colors.black : Colors.black),
                ),
                Row(
                  children: [

                    Icon(Icons.chevron_right,color: Colors.deepOrangeAccent[700],)
                  ],
                ),
              ],
            ),


            Container(
              height: 74,

              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('teams')
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
                      final make = document.get('title');


                      final imageurl = document.get('imageUrls');
                     // final List<dynamic> imageurl = document.get('imageUrls');
                    //  final String imageUrlsString = document.get('imageUrls');
                   //   final List<String> imageurl = imageUrlsString.split(',');

                      final hotelId = document.get('id'); // <-- Get the hotel ID



                      bool _isLoading = false;





                      return Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Container(

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            //  border: Border.all(width: 2,color: Colors.grey),
                            color: Colors.white.withOpacity(0.4),
                          ),
                          child: GestureDetector(
                            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => TeamSingleScreen(document),),);},

                            child: Column(

                              children: [

                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                  child: Image.network(
                                    imageurl,
                                    height: 54,
                                    // width: 85,
                                  ),
                                ),

                                Padding(
                                  padding: const  EdgeInsets.only(left: 8.0,right: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('$make',style: GoogleFonts.dmSerifDisplay(),overflow: TextOverflow.ellipsis, ),

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
        ),
      ),
    );
  }
}


