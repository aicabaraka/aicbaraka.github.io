
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';

import '../auth/glassbox.dart';

import 'package:uuid/uuid.dart';

import '../search.dart';


import 'dart:io';





import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';


class AddSupport extends StatefulWidget {

  const AddSupport({Key? key}) : super(key: key);

  @override
  State<AddSupport> createState() => _AddSupportState();
}

class _AddSupportState extends State<AddSupport> {



  final _nameController = TextEditingController();



  final _descriptionController = TextEditingController();

  final _eventdateController = TextEditingController();







  @override
  void dispose(){



    _nameController.dispose();



    _descriptionController.dispose();

    _eventdateController.dispose();

    super.dispose();
  }


  File? _images ;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
            image: AssetImage('lib/assets/images/event1.jpg'),
            fit: BoxFit.cover,
          )
      ),
      child: GlassBoxxx(
        child: Scaffold(

          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Stack(
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
                                    TyperAnimatedText('Support Team',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),

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




                  const SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.title),
                          hintText: 'Donation Name',
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                      ),
                    ),
                  ),



                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: TextFormField(
                          controller: _eventdateController,
                          readOnly: true,
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2023),
                              lastDate: DateTime(2024),
                            ).then((selectedDate) {
                              if (selectedDate != null) {
                                _eventdateController.text =
                                    DateFormat('yyyy-MM-dd').format(selectedDate);
                              }
                            });
                          },
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: Icon(Icons.date_range),
                            hintText: 'Support Date',
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                        ),
                      ),
                    ),
                  ),





                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: TextField(
                          controller: _descriptionController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: 'Enter Description',
                            labelText: 'Description',
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),



//AddButton
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                      onTap: (){
                        addImageAndTitle(_images!);
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'Add  Support',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 25,),



                ],
              ),
            ),
          ),
        ),
      ),
    );
  }




  bool _isLoading = false;
  Future<void> addImageAndTitle(File image) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser!;
      final userDetailsSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('email', isEqualTo: user.email)
          .get();

      final storageRef = FirebaseStorage.instance.ref().child('images');

      // Generate a unique identifier for the image
      String imageName = Uuid().v4();

      // Upload the selected image
      TaskSnapshot taskSnapshot = await storageRef.child(imageName).putFile(image);
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      final userId = userDetailsSnapshot.docs[0].id;
      final //userId = userDetailsSnapshot.docs.first.id;
      userDetails = userDetailsSnapshot.docs.first.data();
      final email = userDetails['email'];


      final firstname = userDetails['firstname'];
      final lastname = userDetails['lastname'];

      final name = _nameController.text ;



      final eventdate = _eventdateController.text;





      final description = _descriptionController.text;





      await FirebaseFirestore.instance.collection('donation').add({
        'email': email,
        'firstname': firstname,
        'lastname': lastname,
        'name': name,

        'supportdate': eventdate,

        'description': description,

        'availability': true,
        'id': userId,
        'imageUrl': imageUrl, // Store the URL directly instead of in an array
        'timestamp': FieldValue.serverTimestamp(),
      });

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }




}