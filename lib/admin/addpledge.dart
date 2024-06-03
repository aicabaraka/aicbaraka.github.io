

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';
import 'package:aicbaraka/auth/glassbox.dart';

import '../search.dart';




import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPledge extends StatefulWidget {
  @override
  _AddPledgeState createState() => _AddPledgeState();
}

class _AddPledgeState extends State<AddPledge> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _priceController = TextEditingController();
  String _selectedUser = ''; // Track selected user

  // Fetch users' data from Firestore
  Future<List<String>> fetchUsers() async {
    QuerySnapshot snapshot = await _firestore.collection('users').get();
    List<String> usersList = [];
    snapshot.docs.forEach((doc) {
      // Adjust this based on your user document structure
      String userFullName = '${doc['firstname']} ${doc['lastname']} (${doc['email']})';
      usersList.add(userFullName);
    });
    return usersList;
  }

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
                          TyperAnimatedText('Add Pledge',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),

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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: FutureBuilder<List<String>>(
          future: fetchUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text('No users available.'),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<String>(
                    value: _selectedUser.isNotEmpty ? _selectedUser : null,
                    items: snapshot.data!
                        .map((user) => DropdownMenuItem<String>(
                      value: user,
                      child: Text(user),
                    ))
                        .toList(),
                    hint: Text('Select User'),
                    onChanged: (value) {
                      setState(() {
                        _selectedUser = value!;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _addPledgeToFirestore();
                    },
                    child: Text('Add Pledge'),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  void _addPledgeToFirestore() {
    if (_selectedUser.isEmpty || _priceController.text.isEmpty) {
      // Show a snackbar or handle empty fields
      return;
    }

    // Extract firstname, lastname, and email
    List<String> userDetails = _selectedUser.split(' ');
    String firstName = userDetails.isNotEmpty ? userDetails[0] : '';
    String lastName = userDetails.length > 1 ? userDetails[1] : '';
    String userEmail = userDetails.length > 2 ? userDetails[2].replaceAll(RegExp(r'[()]'), '') : '';

    // Add data to Firestore pledges collection
    _firestore.collection('pledges').add({
      'firstname': firstName,
      'lastname': lastName,
      'useremail': userEmail,
      'price': double.parse(_priceController.text),
      'paid': false,
    }).then((_) {
      // Clear form fields after adding pledge
      _priceController.clear();
      setState(() {
        _selectedUser = '';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Pledge added successfully')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add pledge: $error')),
      );
    });
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }
}
