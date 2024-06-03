
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';


import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';

import '../auth/glassbox.dart';
import '../search.dart';


import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';







class AddEvent extends StatefulWidget {

  const AddEvent({Key? key}) : super(key: key);

  @override
  State<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends State<AddEvent> {



  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _priceController = TextEditingController();

  final _descriptionController = TextEditingController();
  final _imageurlController = TextEditingController();
  final _eventdateController = TextEditingController();
  final _starttimeController = TextEditingController();
  final _endtimeController = TextEditingController();






  @override
  void dispose(){



    _nameController.dispose();
    _addressController.dispose();
    _priceController.dispose();

    _descriptionController.dispose();
    _imageurlController.dispose();
    _eventdateController.dispose();
    _starttimeController.dispose();
    _endtimeController.dispose();

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
                  if (_isLoading)
                    Center(
                      child: CircularProgressIndicator(),

                    ),

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
                                    TyperAnimatedText('Add Event',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),

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
                          hintText: 'Event Name',
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
                        child: TextField(
                          controller: _addressController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            prefixIcon: Icon(Icons.local_activity_sharp),

                            hintText: 'Event Location',
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
                            hintText: 'Event Date',
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
                        child: TextFormField(
                          controller: _starttimeController,
                          readOnly: true,
                          onTap: () {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((selectedTime) {
                              if (selectedTime != null) {
                                _starttimeController.text =
                                    selectedTime.format(context);
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
                            prefixIcon: Icon(Icons.timelapse_rounded),
                            hintText: 'Start Time',
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
                        color:Colors.grey[200],
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 0.0),
                        child: TextFormField(
                          controller: _endtimeController,
                          readOnly: true,
                          onTap: () {
                            showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            ).then((selectedTime) {
                              if (selectedTime != null) {
                                _endtimeController.text =
                                    selectedTime.format(context);
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
                            prefixIcon: Icon(Icons.timelapse_rounded),
                            hintText: 'End Time',
                            fillColor: Colors.grey[200],
                            filled: true,
                          ),
                        ),
                      ),
                    ),
                  )
                  ,
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
                          controller: _priceController,
                          keyboardType: TextInputType.numberWithOptions(decimal: true),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            hintText: 'Enter Price',
                            labelText: 'Price',
                            prefixIcon: Icon(Icons.attach_money),
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
                          controller: _imageurlController,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                              borderRadius: BorderRadius.circular(12),
                            ),

                            hintText: 'Enter Image Url',
                            fillColor: Colors.grey[200],
                            filled: true,

                          ),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _pickImages,
                    child: const Text('Select Image'),
                  ),
                  SizedBox(height: 10,),
















//AddButton
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: GestureDetector(
                    //  onTap: addHotel,
                      onTap:(){

                        addImageAndTitle(_images!);
                      },
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.deepOrangeAccent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                          child: Text(
                            'Add  Event',
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


      final name = _nameController.text;


      final address = _addressController.text;
      final eventdate = _eventdateController.text;
      final starttime = _starttimeController.text;
      final endtime = _endtimeController.text;
      final price = _priceController.text;



      final description = _descriptionController.text;
      final imageurl = _imageurlController.text;

      await FirebaseFirestore.instance.collection('events').add({
        'email': email,
        'eventname': name,
        'location': address,
        'eventdate': eventdate,
        'starttime': starttime,
        'endtime': endtime,
        'price': price,
        'dj': email,

        'description': description,
        'imageurl': imageurl,
        'availability': true,



        'id': userId,
        'title': name,
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



  Future<void> _pickImages() async {
    XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      File file = File(pickedImage.path);
      setState(() {
        _images = file;
      });
    }
  }


  Future<void> addHotel() async {
    showDialog(
      context: context,
      builder: (context) {
        return Center(child: CircularProgressIndicator());
      },
    );

    final user = FirebaseAuth.instance.currentUser!;
    print(user.email);
    final userDetailsSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user.email)
        .get();

    if (userDetailsSnapshot.docs.isNotEmpty) {
      final documentId = userDetailsSnapshot.docs[0].id;
      final userDetails = userDetailsSnapshot.docs.first.data();
      final email = userDetails['email'];

      final name = _nameController.text;


      final address = _addressController.text;
      final eventdate = _eventdateController.text;
      final starttime = _starttimeController.text;
      final endtime = _endtimeController.text;
      final price = _priceController.text;



      final description = _descriptionController.text;
      final imageurl = _imageurlController.text;



      print('User details found: ${userDetails.toString()}');

      try {
        String docId = FirebaseFirestore.instance.collection('events').doc().id;
        await FirebaseFirestore.instance.collection('events').doc(docId).set({

          'email': email,
          'eventname': name,
          'location': address,
          'eventdate': eventdate,
          'starttime': starttime,
          'endtime': endtime,
          'price': price,


          'description': description,
          'imageurl': imageurl,
          'availability': true,


          'id': docId


        });

        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Yodur Event  details have been saved.'),
              actions: [
                TextButton(
                  onPressed: () { Navigator.pop(context); Navigator.pop(context);},

                  // onPressed: () {  },
                  child: Text('OK'),
                  // onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PointPages())),
                ),
              ],
            );
          },
        );// dismiss the progress indicator dialog
      } catch (e) {
        print('Error writing Events details to Firestore: $e');
        Navigator.pop(context); // dismiss the progress indicator dialog
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('An error occurred while saving your car details. Please try again later.'),
              actions: [
                TextButton(
                    child: Text('OK'),
                    onPressed: () { Navigator.pop(context); Navigator.pop(context);}
                  //  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          },
        );
      }
    } else {
      // handle the case where the user details document doesn't exist
      Navigator.pop(context); // dismiss the progress indicator dialog
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('User Details Not Found'),
            content: Text('We could not find your user details. Please try again later.'),
            actions: [
              TextButton(
                  child: Text('OK'),
                  onPressed: () { Navigator.pop(context); Navigator.pop(context);}
              ),
            ],
          );
        },
      );
    }
  }


}

