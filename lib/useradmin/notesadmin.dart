

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';




import '../auth/glassbox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_fonts/google_fonts.dart';


import 'addnotes.dart';
import 'editnotes.dart';



class NotesTab extends StatefulWidget {
  final String sermonid;

  NotesTab({Key? key, required this.sermonid}) : super(key: key);

  @override
  State<NotesTab> createState() => _NotesTabState();
}

class _NotesTabState extends State<NotesTab> {
  final user = FirebaseAuth.instance.currentUser!;

  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";
  List<DocumentSnapshot> _hotels = [];
  List<DocumentSnapshot> _filteredHotels = [];


  bool _isLoading = false;




  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('notes')
    .where('sermonid', isEqualTo: widget.sermonid)
    .where('email', isEqualTo: user.email!)
        .get()
        .then((QuerySnapshot snapshot) {
      setState(() {
        _hotels = snapshot.docs;
        _filteredHotels = _hotels;
      });
    });
  }

  Widget _buildGridView() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2/2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,

      ),
      padding: const EdgeInsets.all(8),

      itemCount: _filteredHotels.length,
      itemBuilder: (context, index) => _buildItem(index),


    );
  }


  Widget _buildListView() {
    return ListView.builder(
      itemCount: _filteredHotels.length ,
      itemBuilder: (context, index) => _buildItem(index),




    );
  }


  Widget _buildItem(int index) {
    final hotel = _filteredHotels[index];


    final hotelId = hotel.id;
    final user = FirebaseAuth.instance.currentUser;
    double rating = 2.5;






    bool _isLoading = false;



    void deleteHotel(String hotelId) {
      FirebaseFirestore.instance
          .collection('notes')
          .doc(hotelId)
          .delete()
          .then((value) => print('Unfollowed'))
          .catchError((error) => print('Failed to delete car: $error'));
    }




    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onLongPress: (){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Delete Note??'),
                content: Text('Are you sure you want to delete this note?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      deleteHotel(hotelId);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text('Delete'),
                  ),
                ],
              );
            },
          );

        },
        //  onLongPress: (){Navigator.push(context, MaterialPageRoute(builder: (context) => deleteHotel,),);},



        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => EditNotes(docId: hotelId,),),);},


        // onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DjSingles(item: items[index]),),);},
        child: Container(
          height: 82,
          width: MediaQuery.of(context).size.width*0.37,
          margin: const EdgeInsets.only(bottom: 2,left: 2,right: 2),
          decoration: BoxDecoration(
            border: Border.all(width: 1,color: Colors.black),
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white.withOpacity(0.9),
          ),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Row(
                children: [
                  Icon(Icons.title,size: 15,),
                  Text('Title: '),
                  Container(

                    child: Text(
                      '${hotel['title']}',
                      style: GoogleFonts.dmSerifDisplay(color: Colors.black,fontWeight: FontWeight.bold,letterSpacing: 0.6),maxLines:2,overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              Row(

                children: [
                  Icon(Icons.timelapse_rounded,size: 15,),
                  Container(
                  //  width: 120,
                    child: Text(
                      hotel['description'].toString(),
                      style: GoogleFonts.aBeeZee(color: Colors.deepPurple,),maxLines:2,overflow: TextOverflow.ellipsis,
                    ),
                  ),


                ],
              ),

            ],
          ),
        ),
      ),
    );
  }




  bool _isGridView = true;







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: "Type Title or Description",
            hintStyle: TextStyle(color: Colors.white,),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              _searchText = value;
              _filteredHotels = _hotels.where((hotel) {
                final name = hotel['title'] as String;
                final address = hotel['description'] as String;
                final searchText = _searchText.toLowerCase();
                return name.toLowerCase().contains(searchText) ||
                    address.toLowerCase().contains(searchText);
              }).toList();
            });
          },




        ),
        actions: [

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  border:Border.all(color: Colors.white),
                  borderRadius:BorderRadius.circular(20)
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>   AddNotes(sermonid: widget.sermonid,),),);
                },
                child: const Text('Add Note',style: TextStyle(color: Colors.white),),
              ),
            ),
          ),


          // MaterialButton(onPressed: () {setState(() {_isGridView = !_isGridView;});}, child: Icon(_isGridView ? Icons.view_list : Icons.view_module),)


        ],


      ),
      body: _filteredHotels.isEmpty
          ? Lottie.asset('lib/assets/icons/loading.json')
          : _isGridView
          ? _buildListView()
          : _buildListView(),
    );
  }
}