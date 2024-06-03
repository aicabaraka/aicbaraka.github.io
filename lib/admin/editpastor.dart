import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../auth/glassbox.dart';
import '../search.dart';






class EditP extends StatefulWidget {
  final String docId;


  EditP({required this.docId});

  @override
  _EditPState createState() => _EditPState();
}

class _EditPState extends State<EditP> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstnameController;
  late TextEditingController _lastnameController;
  late TextEditingController _emailController;
  late TextEditingController _telController;




  late TextEditingController _imageController;




  @override
  void initState() {
    super.initState();
    _firstnameController = TextEditingController();
    _lastnameController = TextEditingController();
    _telController = TextEditingController();
    _emailController = TextEditingController();




    _imageController = TextEditingController();



    _loadData();
  }

  @override
  void dispose() {










    _firstnameController.dispose();
    _lastnameController.dispose();
    _telController.dispose();
    _emailController.dispose();

    _imageController.dispose();



    super.dispose();
  }

  void _loadData() async {
    final doc = await FirebaseFirestore.instance.collection('pastors').doc(widget.docId).get();
    final data = doc.data() as Map<String, dynamic>;
    _firstnameController.text = data['firstname'];
    _lastnameController.text = data['lastname'];
    _emailController.text = data['email'];
    _telController.text = data['tel'];

    _imageController.text = data['imageurl'];



  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final firstname = _firstnameController.text.trim();
      final lastname = _lastnameController.text.trim();
      final tel = _telController.text.trim();
      final email = _emailController.text.trim();





      final image = _imageController.text.trim();




      await FirebaseFirestore.instance.collection('pastors').doc(widget.docId).update({
        'firstname': firstname,
        'lastname': lastname,
        'tel': tel,
        'email': email,


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
                        TyperAnimatedText('Edit Pastor',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),
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
                        controller: _firstnameController,

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

                          labelText: 'First Name',
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
                        controller: _lastnameController,

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

                          labelText: 'Last Name',
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
                        controller: _telController,

                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.phone),

                          labelText: 'Telephone',
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
                        controller: _emailController,

                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.email),

                          labelText: 'Email',
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
                        controller: _imageController,

                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.image),

                          labelText: 'Image Link',
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
                                'Edit Pastor',
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
