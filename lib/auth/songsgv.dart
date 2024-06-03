
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'glassbox.dart';












class SongsTab extends StatefulWidget {


  SongsTab({Key? key}) : super(key: key);

  @override
  State<SongsTab> createState() => _SongsTabState();
}

class _SongsTabState extends State<SongsTab> {

  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";
  List<DocumentSnapshot> _hotels = [];
  List<DocumentSnapshot> _filteredHotels = [];


  bool _isLoading = false;




  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('songs')
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
        crossAxisCount: 3,
        childAspectRatio: 2/2.5,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,

      ),
      padding: const EdgeInsets.all(8),

      itemCount: _filteredHotels.length,
      itemBuilder: (context, index) => _buildItem(index),


    );
  }


  Widget _buildListView() {
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
   Widget _buildItem(int index) {
    final hotel = _filteredHotels[index];


    final hotelId = hotel.id;
    final user = FirebaseAuth.instance.currentUser;
    double rating = 2.5;






    bool _isLoading = false;




    return InkWell(
        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SongDetailScreen(hotel),),);},

      // onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DjSingles(item: items[index]),),);},
      child: Container(

        margin: const EdgeInsets.only(right: 1),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(

              width: MediaQuery.of(context).size.width*0.45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                image: DecorationImage(
                  image: AssetImage(hotel['imageurl']
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Container(
              height: 40,

              width: MediaQuery.of(context).size.width*0.37,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white.withOpacity(1.0),
              ),
              child:  Padding(
                padding: const EdgeInsets.only(left: 4.0,right: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      hotel['name'],
                      style: GoogleFonts.bebasNeue(color: Colors.black),
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
   Widget _buildItemm(int index) {
    final hotel = _filteredHotels[index];


    final hotelId = hotel.id;
    final user = FirebaseAuth.instance.currentUser;






    bool _isLoading = false;




    return InkWell(
        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SongDetailScreen(hotel),),);},

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
                image: DecorationImage(
                  image: AssetImage(hotel['imageurl']
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Container(
              height: 40,
              width: MediaQuery.of(context).size.width*0.37,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                color: Colors.white.withOpacity(0.8),
              ),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        hotel['name'],
                        style: GoogleFonts.bebasNeue(color: Colors.black),
                      ),

                    ],
                  ),
                  const Icon(
                    Icons.play_circle,
                    color: Colors.deepPurple,
                  ),
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
        backgroundColor: Colors.deepOrangeAccent.shade700,
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: "Type Song Name",
            hintStyle: TextStyle(color: Colors.white,),
            border: InputBorder.none,
          ),
        onChanged: (value) {
            setState(() {
              _searchText = value;
              _filteredHotels = _hotels.where((hotel) {
                final name = hotel['name'] as String;

                final searchText = _searchText.toLowerCase();
                return name.toLowerCase().contains(searchText);
              }).toList();
            });
          },




        ),
        actions: [

          MaterialButton(
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
            child: Icon(_isGridView ? Icons.view_list : Icons.view_module),

          )


        ],


      ),
      body:_filteredHotels.isEmpty
          ? Lottie.asset('lib/assets/icons/loading.json')
          : _isGridView ? _buildGridView() : _buildListView() ,

    );
  }
}















class SongDetailScreen extends StatelessWidget {
 // final FlutterTts flutterTts = FlutterTts();



  final DocumentSnapshot documen;





  bool isLoading = false;

  SongDetailScreen(this.documen);





  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late String _hotelname;





















  @override
  Widget build(BuildContext context) {
    double fem =0.9;
    double ffem =0.9;



    return Scaffold(
      body:  DefaultTabController(
        length: 1,
        child: CustomScrollView(

          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: <Widget>[
            SliverAppBar(
              backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
              pinned: true,
              stretch: true,
              onStretchTrigger: () {
                // Function callback for stretch
                return Future<void>.value();
              },
              expandedHeight: 300.0,
              shadowColor: Colors.red[100],
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const <StretchMode>[
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                  StretchMode.fadeTitle,

                ],
                centerTitle: true,
                title:  Container(
                  decoration: BoxDecoration(
                      borderRadius:BorderRadius.circular(12),
                      color:Colors.red.withOpacity(0.8)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left:8.0,right:8.0),
                    child: AnimatedTextKit(
                      animatedTexts: [

                        TyperAnimatedText(documen['name'],textStyle: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold)),

                        //   TyperAnimatedText(documen['location'],textStyle: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold)),

                        // TyperAnimatedText(documen['price'],textStyle: GoogleFonts.bebasNeue(color: Colors.white)),

                      ],
                      pause: const Duration(milliseconds: 5000),

                      stopPauseOnTap: true,
                      repeatForever: true,
                    ),
                  ),
                ),
                background: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    // Image.network('https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg', fit: BoxFit.cover,),
                    CarouselSlider(

                      items: [
                        Image.asset(
                          'lib/assets/images/logo.jpg',
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          'lib/assets/images/logo.jpg',
                          fit: BoxFit.cover,
                        ),
                        Image.asset(
                          'lib/assets/images/logo.jpg',
                          fit: BoxFit.cover,
                        ),
                      ],
                      options: CarouselOptions(
                        height: 355,
                        viewportFraction: 1.0,
                        autoPlay: true,
                        enlargeCenterPage: true,
                      ),

                    ),

                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                <Widget>[
                  Column(
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(bottom : 8.0,left:8.0,right:8.0),
                        child: Container(
                          // autogroupjuq148g (Eh5gZPy2nfg7PPw9pWjUq1)

                          width:  double.infinity,
                          child:
                          Column(
                            crossAxisAlignment:  CrossAxisAlignment.start,
                            children:  [
                              Container(
                                // listQCY (1:500)
                                margin:  EdgeInsets.fromLTRB(0, 0, 1, 16),
                                width:  double.infinity,
                                height:  96,
                                child:
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey, // Set the border color here
                                      width: 3.0, // Set the border width here
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:  CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children:  [
                                        Row(
                                          children: [
                                            Container(
                                              // rectangle22469WFa (1:501)
                                              width:  86,
                                              height:  86,
                                              decoration:  BoxDecoration (
                                                borderRadius:  BorderRadius.circular(8),
                                                color:  Color(0xffd9d9d9),
                                                image:  DecorationImage (
                                                  fit:  BoxFit.cover,
                                                  image:  AssetImage (
                                                    'lib/assets/images/logo.jpg',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width:20),
                                            Container(
                                              decoration: BoxDecoration(
                                                  color:Colors.grey.withOpacity(0.4),
                                                  borderRadius: BorderRadius.circular(8.0)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(2.0),
                                                child: Column(
                                                  crossAxisAlignment:  CrossAxisAlignment.start,
                                                  children:  [
                                                    Row(
                                                      children: [
                                                        Icon(Icons.perm_camera_mic_outlined,size: 13,color: Colors.red,),

                                                        Container(
                                                          width: 190,
                                                          child: Text(
                                                            // ledadubeachE56 (1:508)
                                                            documen['name'],
                                                            style:  GoogleFonts.poppins (

                                                              fontSize:  16*ffem,
                                                              fontWeight:  FontWeight.w700,
                                                              height:  1.5*ffem/fem,
                                                              letterSpacing:  0.08*fem,
                                                              color:  Colors.black,
                                                            ),overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),

                                                      ],
                                                    ),





                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),


                                      ],
                                    ),
                                  ),
                                ),
                              ),


                              SizedBox(height: 10,),

                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey, // Set the border color here
                                    width: 3.0, // Set the border width here
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),

                                child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: StreamBuilder<QuerySnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection('stanzas')
                                          .where('songid', isEqualTo: documen['id'])
                                          .snapshots(),
                                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                        if (!snapshot.hasData) {
                                          return const Text('Loading...'); // Display a loading message while data is being fetched.
                                        }

                                        if (snapshot.data!.docs.isEmpty) {
                                          // Data not found in "stanzas" collection, handle appropriately (here, returning an empty container).
                                          return Container();
                                        }

                                        String image = snapshot.data!.docs[0].get('stanza'); // Extract "stanza" from the document.

                                        return Column(
                                          children: [

                                            Container(child: Text('$image',style: TextStyle(color: Colors.black),)) // Display the extracted "stanza" text.
                                          ],
                                        );
                                      },
                                    )

                                ),
                              ),
 SizedBox(height:60.0),





//Rate Card





                            ],
                          ),
                        ),
                      ),
                    ],
                  )


                  // ListTiles++
                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}



