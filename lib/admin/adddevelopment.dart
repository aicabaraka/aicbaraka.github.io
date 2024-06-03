
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import 'package:rich_text_editor_controller/rich_text_editor_controller.dart';

import '../auth/glassbox.dart';
import '../search.dart';


import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';
import 'dart:io';





import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';







class AddDevelopment extends StatefulWidget {

  const AddDevelopment({Key? key}) : super(key: key);

  @override
  State<AddDevelopment> createState() => _AddDevelopmentState();
}

class _AddDevelopmentState extends State<AddDevelopment> {



  final _nameController = TextEditingController();



  final _descriptionController = TextEditingController();


 final RichTextEditorController controller = RichTextEditorController();





  @override
  void dispose(){



    _nameController.dispose();
    controller.dispose();



    _descriptionController.dispose();



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
                                    TyperAnimatedText('Add Developments',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),

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
                          hintText: 'Development Name',
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
                        child: RichTextField(
                          controller: controller,
                          maxLines: 10,
                          minLines: 1,
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
                  ElevatedButton(
                    onPressed: _pickImages,
                    child: const Text('Select Image'),
                  ),

















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
                            'Add  Development',
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


      final description = _descriptionController.text;

      await FirebaseFirestore.instance.collection('developments').add({


        'email': email,
        'name': name,
        'description': description,
        'imageurl': 'lib/assets/images/event1.jpg',
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

      final description = _descriptionController.text;
   print('User details found: ${userDetails.toString()}');

      try {
        String docId = FirebaseFirestore.instance.collection('developments').doc().id;
        await FirebaseFirestore.instance.collection('developments').doc(docId).set({

          'email': email,
          'name': name,
          'description': description,
          'imageurl': 'lib/assets/images/event1.jpg',
          'availability': true,
          'id': docId


        });

        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Your Development  details have been saved.'),
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
            title: const Text('User Details Not Found'),
            content: Text('We could not find your user details. Please try again later.'),
            actions: [
              TextButton(
                  child: Text('OK'),
                  onPressed: () { Navigator.pop(context); Navigator.pop(context); Navigator.pop(context);}
              ),
            ],
          );
        },
      );
    }
  }
}