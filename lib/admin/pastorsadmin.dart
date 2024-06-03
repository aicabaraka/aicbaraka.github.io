

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



import '../auth/glassbox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_fonts/google_fonts.dart';

import 'addevent.dart';
import 'addpastor.dart';

import 'editevent.dart';
import 'editpastor.dart';



class PastorsTab extends StatefulWidget {


  PastorsTab({Key? key}) : super(key: key);

  @override
  State<PastorsTab> createState() => _PastorsTabState();
}

class _PastorsTabState extends State<PastorsTab> {

  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";
  List<DocumentSnapshot> _hotels = [];
  List<DocumentSnapshot> _filteredHotels = [];


  bool _isLoading = false;




  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('pastors')
        .get()
        .then((QuerySnapshot snapshot) {
      setState(() {
        _hotels = snapshot.docs;
        _filteredHotels = _hotels;
      });
    });
  }

  Widget _buildGridView() {
    return Container(
      decoration: BoxDecoration(

          image: DecorationImage(
            image: AssetImage('lib/assets/images/event1.jpg'),
            fit: BoxFit.cover,
          )
      ),
      child: Container(
        color: Colors.grey.withOpacity(0.4),
        child: GlassBoxxx(
          child: GridView.builder(

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2/2.5,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,


            ),
            padding: const EdgeInsets.all(8),

            itemCount: _filteredHotels.length,
            itemBuilder: (context, index) => _buildItem(index),


          ),
        ),
      ),
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
          .collection('pastors')
          .doc(hotelId)
          .delete()
          .then((value) => print('Unfollowed'))
          .catchError((error) => print('Failed to delete car: $error'));
    }




    return InkWell(
      onLongPress: (){
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Delete Pastor??'),
              content: Text('Are you sure you want to delete this pastor?'),
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



      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => EditP(docId: hotelId,),),);},


      // onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DjSingles(item: items[index]),),);},
      child: Container(

        margin: const EdgeInsets.only(right: 1),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(

              width: MediaQuery.of(context).size.width*0.45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                image:  DecorationImage(
                  image: AssetImage('lib/assests/images/event1.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Container(
              height: 40,
              width: MediaQuery.of(context).size.width*0.37,
              margin: const EdgeInsets.only(bottom: 2,left: 2,right: 2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white.withOpacity(0.8),
              ),
              child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //  mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Row(
                    children: [
                      Icon(Icons.title,size: 15,),
                      Text(
                        hotel['firstname'],
                        style: GoogleFonts.bebasNeue(color: Colors.deepPurple),
                      ),
                    ],
                  ),
                  Row(

                    children: [
                      Icon(Icons.title,size: 15,),
                      Text(
                        hotel['lastname'],
                        style: GoogleFonts.bebasNeue(color: Colors.deepPurple),
                      ),




                    ],
                  )
                ],
              ),
            )

          ],

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
            hintText: "Type Pastor Name",
            hintStyle: TextStyle(color: Colors.white,),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              _searchText = value;
              _filteredHotels = _hotels.where((hotel) {
                final name = hotel['firstname'] as String;
                final address = hotel['lastname'] as String;
                final searchText = _searchText.toLowerCase();
                return name.toLowerCase().contains(searchText) ||
                    address.toLowerCase().contains(searchText);
              }).toList();
            });
          },




        ),
        actions: [

          Container(
            decoration: BoxDecoration(
                border:Border.all(color: Colors.white),
                borderRadius:BorderRadius.circular(20)
            ),
            child: TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPastor(),),);
              },
              child: const Text('Add Pastor',style: TextStyle(color: Colors.white),),
            ),
          ),

          // MaterialButton(onPressed: () {setState(() {_isGridView = !_isGridView;});}, child: Icon(_isGridView ? Icons.view_list : Icons.view_module),)


        ],


      ),
      body:_filteredHotels.isEmpty
          ? Container(child: GlassBoxxx(),)
          : _isGridView ? _buildGridView() : _buildListView() ,

    );
  }
}