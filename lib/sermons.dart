import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:aicbaraka/sermonsgv.dart';

class Sermons extends StatefulWidget {
  const Sermons({Key? key}) : super(key: key);

  @override
  State<Sermons> createState() => _SermonsState();
}

class _SermonsState extends State<Sermons> {
  get primaryKala => Colors.deepPurple.shade700;

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
                'Sermons',
                style: GoogleFonts.dmSerifDisplay(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Row(
                children: [

                  Icon(Icons.chevron_right,color: Colors.deepOrangeAccent.shade700,)
                ],
              ),
            ],
          ),
        ),

        Container(
          height: 139,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('sermons')
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
                  final name = document.get('title');
                  final pastor = document.get('Preacher');

                  final desc = document.get('description');


                  final imageurl = document.get('imageurl');


                  final hotelId = document.get('id'); // <-- Get the hotel ID



                  bool _isLoading = false;





                  return InkWell(
                    onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) =>  SermonSingleScreen(document),),);},


                    child: Padding(
                      padding: const EdgeInsets.only(left: 3.0,right: 3.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withOpacity(0.4),
                        ),


                        width: 160,

                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [


                                Container(
                                  height: 90,

                                  decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage('$imageurl',),fit: BoxFit.fitWidth),

                                    borderRadius: BorderRadius.circular(20),
                                      border: Border.all(color: Colors.grey.shade700)
                                    //  border: Border.all(color: Colors.grey)

                                  ),






                                ),
                                Positioned(



                                  bottom: 10,right: 10,



                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.deepOrangeAccent.shade700,
                                        borderRadius: BorderRadius.circular(60)
                                    ),
                                    child: Icon(Icons.add,size: 35,color: Colors.white,),),),

                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0  ,right: 5.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '$name',
                                    style: GoogleFonts.dmSerifDisplay(fontSize: 18,fontWeight: FontWeight.bold,   color: Colors.deepPurple.shade700) ,overflow: TextOverflow.ellipsis,maxLines: 1,
                                  ),
                                  Text(
                                    '$pastor',
                                    style: GoogleFonts.dmSerifDisplay(fontSize: 16,   color: Colors.grey.shade900),overflow: TextOverflow.ellipsis,maxLines: 1,
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
