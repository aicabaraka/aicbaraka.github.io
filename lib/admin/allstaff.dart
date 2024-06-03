import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

import '../search.dart';

class StaffListView extends StatefulWidget {
  @override
  _StaffListViewState createState() => _StaffListViewState();
}

class _StaffListViewState extends State<StaffListView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Stack(
          children: <Widget>[

            AppBarr(),
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
                          TyperAnimatedText('View Staff',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),

                          //   TyperAnimatedText('',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),

                          //    TyperAnimatedText('WE GOT you!!',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),

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

      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('admin').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              var staff = snapshot.data!.docs[index];
              var adminEmail = staff['email'];
              var role = staff['role'];

              // You can customize ListTile or any other widget here
              return Card(
                elevation: 3,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: ListTile(
                  title: Text(adminEmail),
                  subtitle: Text(role),
                  leading: CircleAvatar(
                    // You can customize the avatar here
                    child: Icon(Icons.person),
                  ),
                  // Add onTap or other functionalities if needed
                ),
              );
            },
          );
        },
      ),
    );
  }
}
