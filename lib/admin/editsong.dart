import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:aicbaraka/admin/addstanza.dart';


import '../auth/glassbox.dart';
import '../search.dart';







class EditSong extends StatefulWidget {
  final String docId;


  EditSong({required this.docId});

  @override
  _EditSongState createState() => _EditSongState();
}

class _EditSongState extends State<EditSong> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;




  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _loadData();
  }

  @override
  void dispose() {










    _nameController.dispose();






    super.dispose();
  }

  void _loadData() async {
    final doc = await FirebaseFirestore.instance.collection('songs').doc(widget.docId).get();
    final data = doc.data() as Map<String, dynamic>;
    _nameController.text = data['name'];


  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();




      await FirebaseFirestore.instance.collection('songs').doc(widget.docId).update({
        'name': name,

      });

      Navigator.pop(context);
    }
  }


  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.circular(30),
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
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()
              ),
              child: Column(
                children: [
                  SizedBox(height: 10,),

                  Stack(
                    children:  [

                      AppBarr(),
                      Center(
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText('Edit Song',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),
                            // TyperAnimatedText('Rate Card',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),

                            //   TyperAnimatedText('',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),

                            //    TyperAnimatedText('WE GOT you!!',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),

                          ],
                          pause: const Duration(milliseconds: 8000),

                          stopPauseOnTap: true,
                          repeatForever: true,
                        ),
                      )



                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  keyboardType: TextInputType.text,
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
                                    labelText: 'Song Name',
                                    fillColor: Colors.white.withOpacity(0.4),
                                    filled: true,
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter song name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: 8),
                              // Add some spacing between the TextFormField and the button
                              GestureDetector(
                                onTap: _submit,
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Icon(Icons.verified,color: Colors.green,),
                                  ),
                                ),
                              ),

                            ],
                          ),













                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(28.0),
                    child: Stack(
                      children:  [

                        AppBarr(),
                        Center(
                          child: AnimatedTextKit(
                            animatedTexts: [
                              TyperAnimatedText('Edit Stanzas',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),
                              // TyperAnimatedText('Rate Card',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),

                              //   TyperAnimatedText('',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),

                              //    TyperAnimatedText('WE GOT you!!',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),

                            ],
                            pause: const Duration(milliseconds: 8000),

                            stopPauseOnTap: true,
                            repeatForever: true,
                          ),
                        )



                      ],
                    ),
                  ),
                  GestureDetector(
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => AddStanza(songId: widget.docId),),);},



                      child: Container(

                        decoration:  BoxDecoration(
                            color: Colors.deepOrangeAccent,
                            //   color: Color(0xFFFD7465),
                            borderRadius: const BorderRadius.only(topRight: Radius.circular(20.0,),bottomLeft: Radius.circular(20.0,)



                            )
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [

                              Icon(Icons.add),
                              Text('Add Stanza')
                            ],
                          ),
                        ),
                      )),
                  Container(
                    height: 344,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('stanzas')
                          .where("songid" ,isEqualTo: widget.docId)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(
                            child: Text('An error occurred while loading the data.'),
                          );
                        }

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        if (snapshot.data!.docs.isEmpty) {
                          return Center(
                            child: Text('No  details found.'),
                          );
                        }

                        return ListView(

                          scrollDirection: Axis.vertical,
                          children: snapshot.data!.docs.map((document) {
                            final name = document.get('stanza');







                            final hotelId = document.get('id'); // <-- Get the hotel ID



                            bool _isLoading = false;
                            var limitedTitle = name.length > 50 ? name.substring(0, 50) + '...' : name;





                            return Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                              ),
                              child: ListTile(
                                title: Text(hotelId,maxLines: 1,
                                  overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white),),
                                subtitle: Text(limitedTitle,maxLines: 1,
                                  overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.black),),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit,color: Colors.green,),
                                      onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => EditStanza(docId: hotelId,),),);},



                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete,color: Colors.red,),
                                      onPressed: () {
                                        // Handle delete button press
                                        // You can show a confirmation dialog and delete the item if confirmed
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class EditStanza extends StatefulWidget {
  final String docId;


  EditStanza({required this.docId});

  @override
  _EditStanzaState createState() => _EditStanzaState();
}

class _EditStanzaState extends State<EditStanza> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;




  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _loadData();
  }

  @override
  void dispose() {










    _nameController.dispose();






    super.dispose();
  }

  void _loadData() async {
    final doc = await FirebaseFirestore.instance.collection('stanzas').doc(widget.docId).get();
    final data = doc.data() as Map<String, dynamic>;
    _nameController.text = data['stanza'];


  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();




      await FirebaseFirestore.instance.collection('stanzas').doc(widget.docId).update({
        'stanza': name,

      });

      Navigator.pop(context);
    }
  }


  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        //borderRadius: BorderRadius.circular(30),
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
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()
              ),
              child: Column(
                children: [
                  SizedBox(height: 10,),

                  Stack(
                    children:  [

                      AppBarr(),
                      Center(
                        child: AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText('Edit Stanza',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),
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

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          TextFormField(
                            keyboardType: TextInputType.multiline, // Use multiline keyboard type
                            maxLines: null,
                            //  keyboardType: TextInputType.text,
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


                              labelText: 'Stanza',
                              fillColor: Colors.white.withOpacity(0.4),
                              filled: true,


                            ),

                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter stanza';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16),









                          SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 25.0),
                            child: GestureDetector(
                              onTap: _submit,
                              child: Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.deepOrangeAccent,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Text(
                                    'Edit Stanza',
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


                        ],
                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

