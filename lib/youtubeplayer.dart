import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:aicbaraka/auth/glassbox.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YouTubePlayerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GlassBoxxx(
        child: Scaffold(
          backgroundColor: Colors.transparent,

          body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('video').where("id" ,isEqualTo: '').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              var videos = snapshot.data!.docs;

              return ListView.builder(
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  var videoUrl = videos[index]['videoUrl'];
                  return Card(
                    child: Column(
                      children: [
                        YoutubePlayer(
                          controller: YoutubePlayerController(
                            initialVideoId: YoutubePlayer.convertUrlToId(videoUrl)!,
                            flags: YoutubePlayerFlags(
                              autoPlay: false,
                            ),
                          ),
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: Colors.blueAccent,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

 class SermonPlayer extends StatefulWidget {
   final String videoUrl;
   const SermonPlayer({required this.videoUrl}) ;

   @override
   State<SermonPlayer> createState() => _SermonPlayerState();
 }

 class _SermonPlayerState extends State<SermonPlayer> {
   @override
   Widget build(BuildContext context) {
     return YoutubePlayer(
       controller: YoutubePlayerController(
         initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl) ?? 'https://www.youtube.com/channel/UCZgvFEDkvYPZH763J_5LhMw',

         // initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl)!,
         flags: YoutubePlayerFlags(
           autoPlay: false,
        //   hideControls: false
         ),
       ),
       showVideoProgressIndicator: true,
       progressIndicatorColor: Colors.blueAccent,
     );
   }
 }



class TeamPlayer extends StatefulWidget {
  final String videoUrl;
  const TeamPlayer({required this.videoUrl}) ;

  @override
  State<TeamPlayer> createState() => _TeamPlayerState();
}

class _TeamPlayerState extends State<TeamPlayer> {
  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl) ?? 'https://www.youtube.com/channel/UCZgvFEDkvYPZH763J_5LhMw',

        // initialVideoId: YoutubePlayer.convertUrlToId(widget.videoUrl)!,
        flags: YoutubePlayerFlags(
          autoPlay: false,
          //   hideControls: false
        ),
      ),
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.blueAccent,
    );
  }
}
