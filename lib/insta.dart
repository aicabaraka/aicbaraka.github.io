import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class InstagramPage extends StatefulWidget {
  @override
  _InstagramPageState createState() => _InstagramPageState();
}

class _InstagramPageState extends State<InstagramPage> {
  String instagramLink = 'https://www.instagram.com/p/Cnt_Ct_Mjyl/';
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    _getImage();
  }

  void _getImage() async {
    final response = await http.get(Uri.parse(instagramLink));
    final responseBody = response.body;
    final startIndex = responseBody.indexOf('<meta property="og:image" content="') + '<meta property="og:image" content="'.length;
    final endIndex = responseBody.indexOf('"/>', startIndex);
    final imageTag = responseBody.substring(startIndex, endIndex);
    setState(() {
      imageUrl = imageTag;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instagram Image'),
      ),
      body: Center(
        child: imageUrl == null
            ? CircularProgressIndicator()
            : Image.network(imageUrl),
      ),
    );
  }
}
