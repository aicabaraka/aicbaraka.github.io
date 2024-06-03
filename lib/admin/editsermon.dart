import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../auth/glassbox.dart';
import '../search.dart';






class EditSermon extends StatefulWidget {
  final String docId;


  EditSermon({required this.docId});

  @override
  _EditSermonState createState() => _EditSermonState();
}

class _EditSermonState extends State<EditSermon> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;



  late TextEditingController _descriptionController;

  late TextEditingController _eventdateController;
  late TextEditingController _imageController;



  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();



    _descriptionController = TextEditingController();

    _eventdateController = TextEditingController();
    _imageController = TextEditingController();

    _loadData();
  }

  @override
  void dispose() {










    _nameController.dispose();



    _descriptionController.dispose();

    _eventdateController.dispose();





    super.dispose();
  }

  void _loadData() async {
    final doc = await FirebaseFirestore.instance.collection('sermons').doc(widget.docId).get();
    final data = doc.data() as Map<String, dynamic>;
    _nameController.text = data['title'];


    _descriptionController.text = data['description'];

    _eventdateController.text = data['sermondate'];


  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();




      final description = _descriptionController.text.trim();

      final eventdate = _eventdateController.text.trim();
      final image = _imageController.text.trim();


      await FirebaseFirestore.instance.collection('sermons').doc(widget.docId).update({
        'title': name,

        'description': description,
        'sermondate': eventdate,

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
                        TyperAnimatedText('Edit Sermon',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),
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

                          labelText: 'Sermon Name',
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
                        controller: _eventdateController,
                        readOnly: true, // Make the field read-only to disable manual input
                        onTap: () async {
                          DateTime selectedDate = DateTime.now();
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );

                          if (pickedDate != null && pickedDate != selectedDate) {
                            setState(() {
                              selectedDate = pickedDate;
                              _eventdateController.text = selectedDate.toString(); // Update the controller with the selected date
                            });
                          }
                        },
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.date_range),
                          labelText: 'Sermon Date',
                          fillColor: Colors.white.withOpacity(0.4),
                          filled: true,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a Sermon Date';
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 16),



                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 5, // Set the number of lines to 5
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
                                'Edit Sermon',
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
