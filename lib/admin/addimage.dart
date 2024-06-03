import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  String _title = '';
  File? _image; // Changed from List<File> to File?

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Enter a title',
              ),
              onChanged: (value) {
                setState(() {
                  _title = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _pickImage, // Changed from _pickImages to _pickImage
              child: const Text('Select Image'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                if (_title.isNotEmpty && _image != null) { // Check if _image is not null
                  addImageAndTitle(_title, _image);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Posting...')),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a title and select an image.')),
                  );
                }
              },
              child: const Text('Post'),
            ),
            Expanded(
              child: _image != null ? Image.file(_image!) : Container(), // Show selected image if available
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Future<void> addImageAndTitle(String title, File? image) async {
    final user = FirebaseAuth.instance.currentUser!;
    final userDetailsSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user.email)
        .get();

    // Get a reference to the storage bucket where you want to store the image
    final storageRef = FirebaseStorage.instance.ref().child('images');

    // Use the image_picker package to select the image
    if (image != null) { // Check if image is not null
      TaskSnapshot taskSnapshot = await storageRef.child(image.path).putFile(image);
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      // Create a document in the Firestore collection that includes the title and image URL
      final userId = userDetailsSnapshot.docs.first.id;
      await FirebaseFirestore.instance.collection('posts').add({
        'userId': userId,
        'title': _title,
        'imageUrl': imageUrl, // Changed from 'imageUrls'
        'timestamp': FieldValue.serverTimestamp(),
      });
    }
  }

  Future<void> _pickImage() async {
    XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }
}
