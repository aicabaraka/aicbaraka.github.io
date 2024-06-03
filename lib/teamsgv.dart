
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:aicbaraka/useradmin/addsupport.dart';
import 'package:aicbaraka/useradmin/notesadmin.dart';
import 'package:aicbaraka/youtubeplayer.dart';

import 'auth/glassbox.dart';












class TeamsTab extends StatefulWidget {


  TeamsTab({Key? key}) : super(key: key);

  @override
  State<TeamsTab> createState() => _TeamsTabState();
}

class _TeamsTabState extends State<TeamsTab> {

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


    return InkWell(
      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => TeamSingleScreen(hotel),),);},


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
                  image: AssetImage(hotel['imageUrls']
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
                      hotel['title'],
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






    return InkWell(
      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => TeamSingleScreen(hotel),),);},

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
                  image: AssetImage(hotel['imageUrls']
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
                      hotel['title'],
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

  bool _isGridView = true;







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent.shade700,
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: "Type Team/Choir name",
            hintStyle: TextStyle(color: Colors.white,),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              _searchText = value;
              _filteredHotels = _hotels.where((hotel) {
                final name = hotel['title'] as String;

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





class TeamSingleScreen extends StatelessWidget {
  final FlutterTts flutterTts = FlutterTts();



  final DocumentSnapshot documen;





  bool isLoading = false;

  TeamSingleScreen(this.documen);





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
        length: 4,
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
                      color:Colors.red.withOpacity(0.8)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left:8.0,right:8.0),
                    child: AnimatedTextKit(
                      animatedTexts: [

                        TyperAnimatedText(documen['title'],textStyle: GoogleFonts.poppins(color: Colors.white,fontWeight: FontWeight.bold)),

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

                        Image.network(
                          documen['imageUrls'],
                          fit: BoxFit.cover,
                        ),
                        Image.network(
                          documen['imageUrls'],
                          fit: BoxFit.cover,
                        ),
                        Image.network(
                          documen['imageUrls'],
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
                      Tab(text: 'Team'),

                      Tab(text: 'Projects'),
                      Tab(text: 'Videos'),
                      Tab(text: 'Support'),


                    ],
                  ),

                ),
                pinned: true,
              ),

            SliverFillRemaining(
              child:  TabBarView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [

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
                                                  color:  Colors.white,
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
                  TeamDevtTab(teamid: documen['id'],),
                  TeamVideoTab(teamid: documen['id'],),
                  AddSupport(),


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

class TeamDevtTab extends StatefulWidget {
  final String teamid;


  TeamDevtTab({ required this.teamid});

  @override
  State<TeamDevtTab> createState() => _TeamDevtTabState();
}

class _TeamDevtTabState extends State<TeamDevtTab> {

  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";
  List<DocumentSnapshot> _hotels = [];
  List<DocumentSnapshot> _filteredHotels = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('developments')
    .where('teamid', isEqualTo: widget.teamid)

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
    return ListView.builder(
      itemCount: _filteredHotels.length ,
      itemBuilder: (context, index) => _buildItemm(index),




    );
  }


  Widget _buildItem(int index) {
    final hotel = _filteredHotels[index];







    return InkWell(
      //  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => EventsDetailScreen(hotel),),);},

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
                  image: NetworkImage(hotel['imageUrl']
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          hotel['description'],
                          style: GoogleFonts.bebasNeue(color: Colors.deepPurple),
                        ),



                      ],
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






    return InkWell(
      //  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => EventsDetailScreen(hotel),),);},

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
                  image: NetworkImage(hotel['imageUrl']
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
                      hotel['title'],
                      style: GoogleFonts.bebasNeue(color: Colors.black),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          hotel['description'],
                          style: GoogleFonts.bebasNeue(color: Colors.deepPurple),
                        ),



                      ],
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

  bool _isGridView = true;







  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: "Type Development Name",
            hintStyle: TextStyle(color: Colors.white,),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              _searchText = value;
              _filteredHotels = _hotels.where((hotel) {
                final name = hotel['title'] as String;
                final searchText = _searchText.toLowerCase();
                return name.toLowerCase().contains(searchText);
              }).toList();
            });
          },




        ),


      ),
      body:_filteredHotels.isEmpty
          ? Lottie.asset('lib/assets/icons/loading.json')
          : _isGridView ? _buildGridView() : _buildListView() ,

    );
  }
}



class TeamVideoTab extends StatefulWidget {
  final String teamid;


  TeamVideoTab({ required this.teamid});

  @override
  State<TeamVideoTab> createState() => _TeamVideoTabState();
}

class _TeamVideoTabState extends State<TeamVideoTab> {

  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";
  List<DocumentSnapshot> _hotels = [];
  List<DocumentSnapshot> _filteredHotels = [];


  bool _isLoading = false;






  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('video')
        .where('teamid', isEqualTo: widget.teamid)

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
    return ListView.builder(
      itemCount: _filteredHotels.length ,
      itemBuilder: (context, index) => _buildItemm(index),




    );
  }
  Widget _buildItem(int index) {
    final hotel = _filteredHotels[index];







    return InkWell(
      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => TeamPlayer( videoUrl: hotel['videoUrl'],),),);},

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
                  image: NetworkImage(hotel['imageUrl']
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
                      hotel['title'],
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
  return InkWell(
        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => TeamPlayer( videoUrl: hotel['videoUrl'],),),);},

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
                  image: NetworkImage(hotel['imageUrl']
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
                      hotel['title'],
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
  bool _isGridView = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor.withOpacity(0.8),
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: "Type Video Name",
            hintStyle: TextStyle(color: Colors.white,),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            setState(() {
              _searchText = value;
              _filteredHotels = _hotels.where((hotel) {
                final name = hotel['title'] as String;
                final searchText = _searchText.toLowerCase();
                return name.toLowerCase().contains(searchText);
              }).toList();
            });
          },




        ),



      ),
      body:_filteredHotels.isEmpty
          ? Lottie.asset('lib/assets/icons/loading.json')
          : _isGridView ? _buildGridView() : _buildListView() ,

    );
  }
}

