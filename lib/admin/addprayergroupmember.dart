

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

class AddPrayerGroupMember extends StatefulWidget {
  @override
  _AddPrayerGroupMemberState createState() => _AddPrayerGroupMemberState();
}

class _AddPrayerGroupMemberState extends State<AddPrayerGroupMember> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String _selectedUser = ''; // Track selected user
  String _selectedGroup = ''; // Track selected user

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

  Future<List<String>> fetchPrayerGroups() async {
    QuerySnapshot snapshot = await _firestore.collection('prayergroups').get();
    List<String> groupList = [];
    snapshot.docs.forEach((doc) {
      // Adjust this based on your user document structure
      String userrFullName = '${doc['title']} ${doc['title']} (${doc['title']})';
      groupList.add(userrFullName);
    });
    return groupList;
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
                          TyperAnimatedText('Add PrayerGroup Member',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),

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
              return const Center(
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
                  DropdownButtonFormField<String>(
                    value: _selectedGroup.isNotEmpty ? _selectedGroup : null,
                    items: snapshot.data!
                        .map((group) => DropdownMenuItem<String>(
                      value: group,
                      child: Text(group),
                    ))
                        .toList(),
                    hint: Text('Select Prayer Group'),
                    onChanged: (value) {
                      setState(() {
                        _selectedGroup = value!;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      _addPledgeToFirestore();
                    },
                    child: Text('Add Member'),
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
    if (_selectedUser.isEmpty || _selectedGroup.isEmpty) {
      // Show a snackbar or handle empty fields
      return;
    }

    // Split the selected user to extract the email
    List<String> userDetails = _selectedUser.split('(');
    String userEmail = userDetails.isNotEmpty ? userDetails.last.replaceAll(')', '') : '';

    // Add data to Firestore pledges collection
    _firestore.collection('prayergroupmembers').add({
      'user_email': userEmail,
   //   'price': double.parse(_priceController.text),
      'paid': false,
    }).then((_) {
      // Clear form fields after adding pledge
    //  _priceController.clear();
      setState(() {
        _selectedUser = '';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pledge added successfully')),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add pledge: $error')),
      );
    });
  }

  @override
  void dispose() {
   // _priceController.dispose();
    super.dispose();
  }
}
