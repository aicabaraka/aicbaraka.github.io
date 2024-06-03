import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../auth/glassbox.dart';
import '../search.dart';






class EditEvent extends StatefulWidget {
  final String docId;


  EditEvent({required this.docId});

  @override
  _EditEventState createState() => _EditEventState();
}

class _EditEventState extends State<EditEvent> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _priceController;

  late TextEditingController _descriptionController;
  late TextEditingController _imageurlController;
  late TextEditingController _eventdateController;
  late TextEditingController _starttimeController;
  late TextEditingController _endtimeController;



  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _addressController = TextEditingController();
    _priceController = TextEditingController();

    _descriptionController = TextEditingController();
    _imageurlController = TextEditingController();
    _eventdateController = TextEditingController();
    _starttimeController = TextEditingController();
    _endtimeController = TextEditingController();
    _loadData();
  }

  @override
  void dispose() {










    _nameController.dispose();
    _addressController.dispose();
    _priceController.dispose();

    _descriptionController.dispose();
    _imageurlController.dispose();
    _eventdateController.dispose();
    _starttimeController.dispose();
    _endtimeController.dispose();






    super.dispose();
  }

  void _loadData() async {
    final doc = await FirebaseFirestore.instance.collection('events').doc(widget.docId).get();
    final data = doc.data() as Map<String, dynamic>;
    _nameController.text = data['eventname'];
    _addressController.text = data['location'];
    _priceController.text = data['price'].toString();

    _descriptionController.text = data['description'];
    _imageurlController.text = data['imageurl'];
    _eventdateController.text = data['eventdate'];
    _starttimeController.text = data['starttime'];
    _endtimeController.text = data['endtime'];

  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final address = _addressController.text.trim();
      final price = int.parse(_priceController.text.trim());


      final description = _descriptionController.text.trim();
      final imageurl = _imageurlController.text.trim();
      final eventdate = _eventdateController.text.trim();
      final starttime = _starttimeController.text.trim();
      final endtime = _endtimeController.text.trim();

      await FirebaseFirestore.instance.collection('events').doc(widget.docId).update({
        'eventname': name,
        'location': address,
        'price': price,

        'description': description,
        'imageurl': imageurl,
        'eventdate': eventdate,
        'starttime': starttime,
        'endtime': endtime,
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
                        TyperAnimatedText('Edit Event',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),
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

                          labelText: 'Event Name',
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
                        controller: _addressController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.location_on),

                          labelText: 'Location',
                          fillColor: Colors.white.withOpacity(0.4),
                          filled: true,

                        ),

                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a city';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),


                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _priceController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.monetization_on_outlined),

                          labelText: 'Price',
                          fillColor: Colors.white.withOpacity(0.4),
                          filled: true,

                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a Price';
                          }
                          final rating = int.tryParse(value);
                          if (rating == null || rating < 0 || rating > 50000000) {
                            return 'Please enter a rating between 0 and 5000000';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _eventdateController,
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

                          labelText: 'Event Date',
                          fillColor: Colors.white.withOpacity(0.4),
                          filled: true,

                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a Event Date';
                          }

                          return null;
                        },
                      ),
                      SizedBox(height: 16),

                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _starttimeController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.timelapse_rounded),

                          labelText: 'Start Time',
                          fillColor: Colors.white.withOpacity(0.4),
                          filled: true,

                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter Start Time';
                          }

                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: _endtimeController,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          prefixIcon: Icon(Icons.timelapse_rounded),

                          labelText: 'End Time',
                          fillColor: Colors.white.withOpacity(0.4),
                          filled: true,

                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter end time';
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
                                'Edit Event',
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
