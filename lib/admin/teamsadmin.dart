

import 'dart:ui';

import 'package:auto_size_text_plus/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';






import '../auth/glassbox.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_fonts/google_fonts.dart';

import 'addteam.dart';
import 'editteam.dart';




class TeamsTabAdmin extends StatefulWidget {


  TeamsTabAdmin({Key? key}) : super(key: key);

  @override
  State<TeamsTabAdmin> createState() => _TeamsTabAdminState();
}

class _TeamsTabAdminState extends State<TeamsTabAdmin> {

  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";
  List<DocumentSnapshot> _hotels = [];
  List<DocumentSnapshot> _filteredHotels = [];


  bool _isLoading = false;




  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('teams')
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
              crossAxisCount: 2,
              childAspectRatio: 2/2,
              mainAxisSpacing: 9,
              crossAxisSpacing: 0,


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
          .collection('teams')
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
              title: Text(hotel['title']),
              content: Text('Are you sure you want to delete '
              +hotel['title'] + '?'),
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



      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => EditTeams(docId: hotelId,),),);},


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
                  image: NetworkImage(hotel['imageUrls'] ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                height: 62,

                margin: const EdgeInsets.only(bottom: 2,left: 2,right: 2),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white.withOpacity(0.9),
                ),
                child:   Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.39,
                      child: AutoSizeText(
                        hotel['title'] ,
                        style: GoogleFonts.poppins(fontWeight:FontWeight.w600,color: Colors.deepPurple),maxLines: 2,
                      ),
                    ),
                  ],
                ),
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
            hintText: "Type Team name",
            hintStyle: TextStyle(color: Colors.white,),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              _searchText = value;
              _filteredHotels = _hotels.where((hotel) {
                final name = hotel['title'] as String;
                final address = hotel['title'] as String;
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
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const AddTeams(),),);},
              child: const Text('Add Team',style: TextStyle(color: Colors.white),),
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