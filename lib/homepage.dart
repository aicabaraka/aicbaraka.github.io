import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_size_text_plus/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:aicbaraka/auth/glassbox.dart';
import 'package:aicbaraka/pastors.dart';
import 'package:aicbaraka/search.dart';
import 'package:aicbaraka/sermons.dart';
import 'package:aicbaraka/teams.dart';

import 'auth/songs.dart';
import 'events.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(
        children: [
          Stack(
            children: [
              const AppBarr(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 5,),
                      AnimatedTextKit(
                          animatedTexts: [
                            TyperAnimatedText('AIC BARAKA  Church',textStyle: GoogleFonts.dmSerifDisplay(fontSize:25,color: Colors.white)),
                            TyperAnimatedText('Mlolongo ',textStyle: GoogleFonts.dmSerifDisplay(fontSize:28,color: Colors.white)),
                            TyperAnimatedText('Join Us Every Sunday ',textStyle: GoogleFonts.dmSerifDisplay(fontSize:28,color: Colors.white)),
                            //   TyperAnimatedText('',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),

                            //    TyperAnimatedText('WE GOT you!!',textStyle: GoogleFonts.bebasNeue(fontSize:28,color: Colors.white)),

                          ],
                          pause: const Duration(milliseconds: 8000),

                          stopPauseOnTap: true,
                          repeatForever: true,
                        ),

                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10,),
          Teams(),
          Divider(),
          const Eventss(),
          Divider(),
          const Sermons(),
          Divider(),
          Pastors(),
          Divider(),
          const Songs()
        ],
      ),
    );
  }
}
