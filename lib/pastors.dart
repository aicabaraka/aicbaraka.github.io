import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Pastors extends StatelessWidget {
  Pastors({Key? key}) : super(key: key);
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0,right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Our Pastors',
                style: GoogleFonts.dmSerifDisplay(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              GestureDetector(
          //      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => BtSearch()));},
                child: Row(
                  children: [
                    Text(
                      '',
                      style: GoogleFonts.dmSerifDisplay(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple.shade700),
                    ),


                  ],
                ),
              ),
            ],
          ),
        ),


        Container(
          height: 98,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('pastors')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('An error occurred while loading the data.'),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text('No  details found.'),
                );
              }

              return ListView(
                scrollDirection: Axis.horizontal,
                children: snapshot.data!.docs.map((document) {
                  final make = document.get('firstname');
                  final last = document.get('lastname');
                  final tel = document.get('tel');


                  final imageurl = document.get('imageurl');


                  final hotelId = document.get('id'); // <-- Get the hotel ID



                  bool _isLoading = false;





                  return Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: Container(


                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        //   border: Border.all(width: 2,color: Colors.grey),
                        color: Colors.white.withOpacity(0.4),
                      ),
                      child: GestureDetector(
                     //   onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SingleBtSearch( bodytype: document['name'],),),);},

                        child: Column(

                          children: [
                            Container(
                              padding: EdgeInsets.all(2.0),

                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                //  border: Border.all(width: 2,color: Colors.grey),

                              ),
                              child: Image.asset(
                                '$imageurl',
                                height: 54,
                                // width: 85,
                              ),
                            ),

                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('$make $last',style: GoogleFonts.dmSerifDisplay(color: Colors.deepPurple,fontWeight: FontWeight.bold),),


                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('$tel',style: GoogleFonts.dmSerifDisplay(),),


                                  ],
                                ),
                              ],
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
