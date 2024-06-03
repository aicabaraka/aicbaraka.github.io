
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:aicbaraka/useradmin/notesadmin.dart';
import 'package:aicbaraka/youtubeplayer.dart';

import 'auth/glassbox.dart';












class SermonsTab extends StatefulWidget {


  SermonsTab({Key? key}) : super(key: key);

  @override
  State<SermonsTab> createState() => _SermonsTabState();
}

class _SermonsTabState extends State<SermonsTab> {

  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";
  List<DocumentSnapshot> _hotels = [];
  List<DocumentSnapshot> _filteredHotels = [];


  bool _isLoading = false;




  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('sermons')
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
      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SermonSingleScreen(hotel),),);},

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
              height: 74,

             // width: MediaQuery.of(context).size.width*0.37,

              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.white.withOpacity(0.9),
              ),
              child:  Padding(
                padding: const EdgeInsets.only(left: 4.0,right: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      hotel['title'],
                      style: GoogleFonts.poppins(color: Colors.black,fontSize: 12,fontWeight: FontWeight.w600),maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      hotel['Preacher'],
                      style: GoogleFonts.poppins(color: Colors.deepPurple,fontWeight: FontWeight.w600),
                    ),

                    Text(
                        hotel['sermondate'].toString(),
                      style: GoogleFonts.bebasNeue(color: Colors.red),
                    )
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
      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SermonSingleScreen(hotel),),);},

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
                        hotel['title'],
                        style: GoogleFonts.bebasNeue(color: Colors.black),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            hotel['Preacher'],
                            style: GoogleFonts.bebasNeue(color: Colors.deepPurple),
                          ),
                          SizedBox(width: 10,),
                          Text(
                              hotel['sermondate'].toString(),
                            style: GoogleFonts.bebasNeue(color: Colors.black),
                          ),


                        ],
                      )
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
            hintText: "Type Sermon,Preacher or Bible Book",
            hintStyle: TextStyle(color: Colors.white,),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              _searchText = value;
              _filteredHotels = _hotels.where((hotel) {
                final name = hotel['title'] as String;
                final address = hotel['preacher'] as String;
                final book = hotel['book'] as String;
                final searchText = _searchText.toLowerCase();
                return name.toLowerCase().contains(searchText) ||
                 book.toLowerCase().contains(searchText) ||
                    address.toLowerCase().contains(searchText);
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





class SermonSingleScreen extends StatelessWidget {
  final FlutterTts flutterTts = FlutterTts();



  final DocumentSnapshot documen;





  bool isLoading = false;

  SermonSingleScreen(this.documen);





  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _description;
  late String _hotelname;
  bool isPaused = false;



  @override
  Widget build(BuildContext context) {
    double fem =0.9;
    double ffem =0.9;

    return Scaffold(
      bottomNavigationBar: GlassBox(
        child: BottomAppBar(
         // elevation: 0,
          clipBehavior: Clip.antiAliasWithSaveLayer,
       //   color: Colors.white.withOpacity(0.1),
          child:  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: GestureDetector(

              onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SermonPlayer( videoUrl: documen['imageurl'],),),);},

              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(

                  color: Colors.deepOrangeAccent,
                  borderRadius: BorderRadius.circular(12),

                ),
                child: const Center(
                  child: Text(

                    'Watch Sermon',
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
        ),
      ),
        body:  DefaultTabController(
          length: 2,
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
                expandedHeight: 200.0,
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
                        color:Colors.deepOrange.withOpacity(0.8)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left:8.0,right:8.0),
                      child: AnimatedTextKit(
                        animatedTexts: [
  
                          TyperAnimatedText(documen['title'],textStyle: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 12)),
  
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
                            documen['imageurl'],
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            documen['imageurl'],
                            fit: BoxFit.cover,
                          ),
                          Image.asset(
                            documen['imageurl'],
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
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    tabs: [
                      Tab(text: 'Sermon'),
                      Tab(text: 'Notes'),
                    ],
                  ),

                ),
                pinned: true,
              ),

              SliverFillRemaining(
                child:  TabBarView(
                 children: [
                    Scaffold(
                      body: ListView(
                        children: [
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
                                                              documen['imageurl']
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
                                                                Icon(Icons.perm_camera_mic_outlined,size: 17,color: Colors.deepOrangeAccent,),
                                                                Text(
                                                                  // ledadubeachE56 (1:508)
                                                                  ' Pst. ',
                                                                  style:  GoogleFonts.poppins (

                                                                    fontSize:  16*ffem,
                                                                    fontWeight:  FontWeight.w700,
                                                                    height:  1.5*ffem/fem,
                                                                    letterSpacing:  0.08*fem,
                                                                    color:  Colors.black,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  // ledadubeachE56 (1:508)
                                                                  documen['Preacher'],
                                                                  style:  GoogleFonts.poppins (

                                                                    fontSize:  16*ffem,
                                                                    fontWeight:  FontWeight.w700,
                                                                    height:  1.5*ffem/fem,
                                                                    letterSpacing:  0.08*fem,
                                                                    color:  Colors.black,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  // ledadubeachE56 (1:508)
                                                                  ' ',
                                                                  style:  GoogleFonts.poppins (

                                                                    fontSize:  16*ffem,
                                                                    fontWeight:  FontWeight.w700,
                                                                    height:  1.5*ffem/fem,
                                                                    letterSpacing:  0.08*fem,
                                                                    color:  Colors.black,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  // ledadubeachE56 (1:508)
                                                                  '',
                                                                  style:  GoogleFonts.poppins (

                                                                    fontSize:  16*ffem,
                                                                    fontWeight:  FontWeight.w700,
                                                                    height:  1.5*ffem/fem,
                                                                    letterSpacing:  0.08*fem,
                                                                    color:  Colors.black,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Icon(Icons.date_range,size: 17,color: Colors.deepOrangeAccent,),
                                                                Text(
                                                                  // ledadubeachE56 (1:508)
                                                                  documen['sermondate'],
                                                                  style:  GoogleFonts.poppins (

                                                                    fontSize:  16*ffem,
                                                                    fontWeight:  FontWeight.w700,
                                                                    height:  1.5*ffem/fem,
                                                                    letterSpacing:  0.08*fem,
                                                                    color:  Colors.black,
                                                                  ),
                                                                ),
                                                                Text(
                                                                  // days2nightsmKv (1:509)
                                                                  documen['book'],
                                                                  style:  GoogleFonts.poppins (

                                                                    fontSize:  14*ffem,
                                                                    fontWeight:  FontWeight.w500,
                                                                    height:  1.6666666667*ffem/fem,
                                                                    letterSpacing:  0.06*fem,
                                                                    color:  Colors.black,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Icon(Icons.email,size: 17,color: Colors.deepOrangeAccent,),
                                                                Text(
                                                                  // ledadubeachE56 (1:508)
                                                                  ' ',
                                                                  style:  GoogleFonts.poppins (

                                                                    fontSize:  16*ffem,
                                                                    fontWeight:  FontWeight.w700,
                                                                    height:  1.5*ffem/fem,
                                                                    letterSpacing:  0.08*fem,
                                                                    color:  Colors.black,
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: 185,
                                                                  child: Text(
                                                                    // days2nightsmKv (1:509)
                                                                    documen['title'],
                                                                    style:  GoogleFonts.poppins (

                                                                      fontSize:  14*ffem,
                                                                      fontWeight:  FontWeight.w500,
                                                                      height:  1.6666666667*ffem/fem,
                                                                      letterSpacing:  0.06*fem,
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
                                          child: Column(
                                            children: [
                                              Container(

                                                child: GestureDetector(
                                                  onTap: () async {
                                                    if (isPaused) {
                                                      // Resume speaking
                                                      await flutterTts.pause();
                                                      isPaused = false;
                                                    } else {
                                                      // Start speaking
                                                      await flutterTts.setLanguage("en-US");
                                                      await flutterTts.speak(documen['description'] ?? '');
                                                    }
                                                  },
                                                  onLongPress: () async {
                                                    // Pause speaking
                                                    await flutterTts.pause();
                                                    isPaused = true;
                                                  },
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                          decoration: BoxDecoration(
                                                              color:Colors.grey.withOpacity(0.4),
                                                              borderRadius: BorderRadius.circular(8.0)
                                                          ),


                                                          child: Icon(Icons.mic, color: Colors.deepOrangeAccent, size: 20)),
                                                      SizedBox(width: 5,),
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            color:Colors.grey.withOpacity(0.4),
                                                            borderRadius: BorderRadius.circular(8.0)
                                                        ),
                                                        child: Text(
                                                          'Click to Listen', // Text displayed next to the mic icon.
                                                          style: GoogleFonts.poppins(
                                                            fontSize: 14 * ffem,
                                                            fontWeight: FontWeight.w500,


                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                //  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                    //  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) =>  SingleDjEvents(username:documen['email']),),);},
                                                    //  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) =>  Credits(),),);},
                                                    child: Row(
                                                      children: [
                                                        //  Lottie.asset('lib/assets/icons/events.json',height: 30),

                                                        Container(
                                                            decoration: BoxDecoration(
                                                                color: Colors.grey.withOpacity(0.4),
                                                                borderRadius: BorderRadius.circular(8.0)
                                                            ),
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(2.0),
                                                              child: Container(
                                                                width: 310,
                                                                child: Flexible(
                                                                  child: Text(
                                                                    // days2nightsmKv (1:509)
                                                                      documen['description'],
                                                                      style:  GoogleFonts.poppins (

                                                                        fontSize:  14*ffem,
                                                                        fontWeight:  FontWeight.w500,
                                                                        height:  1.6666666667*ffem/fem,
                                                                        letterSpacing:  0.06*fem,
                                                                        color:  Colors.black,
                                                                      )
                                                                  ),
                                                                ),
                                                              ),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),

                                      SizedBox(height:60.0),





                                      //Rate Card





                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                   NotesTab(sermonid: documen['id'],)

                    // ListTiles++
                  ],  
                ),
              )

            ],
          ),
        ),

    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.transparent, // Customize the background color of the tab bar
      child: GlassBox(child: _tabBar),
    );
  }

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
