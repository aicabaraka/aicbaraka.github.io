import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../auth/glassbox.dart';
import '../search.dart';






class EditDevelopment extends StatefulWidget {
  final String docId;


  const EditDevelopment({super.key, required this.docId});

  @override
  _EditDevelopmentState createState() => _EditDevelopmentState();
}

class _EditDevelopmentState extends State<EditDevelopment> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;



  late TextEditingController _descriptionController;
  late TextEditingController _imageController;




  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();



    _descriptionController = TextEditingController();
    _imageController = TextEditingController();



    _loadData();
  }

  @override
  void dispose() {










    _nameController.dispose();



    _descriptionController.dispose();
    _imageController.dispose();



    super.dispose();
  }

  void _loadData() async {
    final doc = await FirebaseFirestore.instance.collection('developments').doc(widget.docId).get();
    final data = doc.data() as Map<String, dynamic>;
    _nameController.text = data['name'];


    _descriptionController.text = data['description'];
    _imageController.text = data['imageurl'];



  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();




      final description = _descriptionController.text.trim();
      final image = _imageController.text.trim();




      await FirebaseFirestore.instance.collection('developments').doc(widget.docId).update({
        'name': name,

        'description': description,
        'imageurl': image,

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

          body: ListView(
            children: [

              Stack(
                children:  [

                  AppBarr(),
                  Center(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText('Edit Developments',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),
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

                          labelText: 'Development Name',
                          fillColor: Colors.white.withOpacity(0.4),
                          filled: true,

                        ),

                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),







                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.description),

                          labelText: 'Description',
                          fillColor: Colors.white.withOpacity(0.4),
                          filled: true,

                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a text';
                          }
                          return null;
                        },
                      ),
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
                                'Edit Development',
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
    );
  }
}






class EditPaybill extends StatefulWidget {
  final String docId;


  const EditPaybill({super.key, required this.docId});

  @override
  _EditPaybillState createState() => _EditPaybillState();
}

class _EditPaybillState extends State<EditPaybill> {
  final _formKey = GlobalKey<FormState>();


  late TextEditingController _descriptionController;



  @override
  void initState() {
    super.initState();




    _descriptionController = TextEditingController();



    _loadData();
  }

  @override
  void dispose() {










    _descriptionController.dispose();



    super.dispose();
  }

  void _loadDataa() async {
    final doc = await FirebaseFirestore.instance.collection('paybill').doc(widget.docId).get();
    final data = doc.data() as Map<String, dynamic>;


    _descriptionController.text = data['description'];



  }


  void _loadData() async {
    final docIdd = 'hNmT85W52W4cCT7EnzO9'; // Assuming this is your document ID
    final doc = await FirebaseFirestore.instance.collection('paybill').where('id', isEqualTo: docIdd).get();

    if (doc.docs.isNotEmpty) {
      final data = doc.docs.first.data() as Map<String, dynamic>;

      _descriptionController.text = data['description'];
      // You can access other fields similarly using data['fieldName']
    } else {
      // Handle the case when the document with the given ID is not found
      print('Document with ID $docIdd not found');
    }
  }


  void _submit() async {
    if (_formKey.currentState!.validate()) {




      final description = _descriptionController.text.trim();

      final docIdd = 'hNmT85W52W4cCT7EnzO9';

      await FirebaseFirestore.instance.collection('paybill').doc(docIdd).update({


        'description': description,


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

          body: ListView(
            children: [

              Stack(
                children:  [

                 AppBarr(),
                  Center(
                    child: AnimatedTextKit(
                      animatedTexts: [
                        TyperAnimatedText('Edit Paybill',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),
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
                        keyboardType: TextInputType.text,
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.description),

                          labelText: 'Description',
                          fillColor: Colors.white.withOpacity(0.4),
                          filled: true,

                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a text';
                          }
                          return null;
                        },
                      ),
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
                                'Edit PayBill',
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
    );
  }
}

