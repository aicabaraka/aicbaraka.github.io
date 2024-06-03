

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import 'package:aicbaraka/auth/glassbox.dart';

import '../search.dart';







class AddStaff extends StatefulWidget {

  const AddStaff({Key? key}) : super(key: key);

  @override
  State<AddStaff> createState() => _AddStaffState();
}

class _AddStaffState extends State<AddStaff> {
  String? selectedMake;



  final _nameController = TextEditingController();








  @override
  void dispose(){



    _nameController.dispose();



    super.dispose();
  }


  Future<List<String>> getCarMakes() async {
    QuerySnapshot snapshot =
    await FirebaseFirestore.instance.collection('roles').get();
    List<String> makes = [];
    snapshot.docs.forEach((doc) {
      makes.add(doc['role']);
    });
    return makes;
  }


  Future<void> addHotel() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
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
      final make = selectedMake;

      final name = _nameController.text;





      print('User details found: ${userDetails.toString()}');

      try {
        String docId = FirebaseFirestore.instance.collection('admin').doc().id;
        await FirebaseFirestore.instance.collection('admin').doc(docId).set({

          'adminemail': email,
          'email': name,
          'role': make,








          'availability': true,


          'id': docId


        });

        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Your Car  ' + name + '   details have been saved.'),
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


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String>>(

        future: getCarMakes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                decoration: const BoxDecoration(
                  //   borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(

                      image: AssetImage('lib/assets/images/event1.jpg'),
                      fit: BoxFit.cover,
                    )
                ),
               child: GlassBoxxx(child: CircularProgressIndicator()));
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<String> makes = snapshot.data!;
            return Container(

              decoration: const BoxDecoration(
                  //   borderRadius: BorderRadius.circular(30),
                  image: DecorationImage(

                    image: AssetImage('lib/assets/images/event1.jpg'),
                    fit: BoxFit.cover,
                  )
              ),
              child:
              GlassBoxxx(
                child: Scaffold(

                  backgroundColor: Colors.transparent,
                  body: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          Stack(
                            children:  [

                              const AppBarr(),
                              Center(
                                child: AnimatedTextKit(
                                  animatedTexts: [
                                    TyperAnimatedText('Add Staff',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),
                                    // TyperAnimatedText('Rate Card',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),

                                    //   TyperAnimatedText('',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),

                                    //    TyperAnimatedText('WE GOT you!!',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),

                                  ],
                                  pause: const Duration(milliseconds: 3000),

                                  stopPauseOnTap: true,
                                  repeatForever: true,
                                ),
                              )



                            ],
                          ),

                          const SizedBox(height: 30,),

                          DropdownButton<String>(
                            value: selectedMake,
                            onChanged: (newValue) {
                              setState(() {
                                selectedMake = newValue;
                              });
                            },
                            items: makes.map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            hint: Text('Select Role'),
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
                              child: TextField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.deepPurple),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  prefixIcon: Icon(Icons.car_repair_sharp),
                                  hintText: 'Email',
                                  fillColor: Colors.grey[200],
                                  filled: true,
                                ),
                              ),
                            ),
                          ),


                          const SizedBox(height: 10,),

//AddButton
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: GestureDetector(
                              onTap: addHotel,
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.deepOrangeAccent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Add  Staff',
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
                          const SizedBox(height: 25,),


                        ],
                      ),
                    ),
                  ),
                ),
              ),

            );
          }
        });
  }
}