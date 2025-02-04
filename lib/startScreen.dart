import 'package:audioplayers/audioplayers.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/homePage.dart';



class IntroScreen extends StatefulWidget {
    @override
    _IntroScreenState createState() => _IntroScreenState();
  }
  
  class _IntroScreenState extends State<IntroScreen>
      with SingleTickerProviderStateMixin {
    static var myNewFont = GoogleFonts.pressStart2p(
        textStyle: TextStyle(color: Colors.black, letterSpacing: 3));
    static var myNewFontWhite = GoogleFonts.pressStart2p(
        textStyle: TextStyle(color: Colors.white, letterSpacing: 3));
   AudioPlayer player = AudioPlayer();
    @override
  void dispose() {
    // Dispose of the audio player when the widget is disposed
    player.dispose();
    super.dispose();
  }

  // Method to play sound
playerSound() {

    AudioPlayer player =AudioPlayer();
    Source path = AssetSource("soun.wav");
    player.play(path);
  }
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 120.0),
                      child: Container(
                        child: Text(
                          "TIC TAC TOE",
                          style: myNewFontWhite.copyWith(fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: AvatarGlow(
                        endRadius: 140,
                        duration: Duration(seconds: 2),
                        glowColor: const Color.fromARGB(255, 255, 116, 106),
                        repeat: true,
                        repeatPauseDuration: Duration(seconds: 1),
                        startDelay: Duration(seconds: 1),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                style: BorderStyle.none,
                              ),
                              shape: BoxShape.circle),
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[900],
                            child: Container(
                              child: Image.asset(
                                'assets/images/tictactoelogo.png',
                                color: Colors.white,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                            radius: 80.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 80.0),
                      child: Container(
                        child: Text(
                          "@CREAT BY BRAHIM",
                          style: myNewFontWhite.copyWith(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                 onTap: () async {
  playerSound(); // Play the sound

  // Wait for the sound to finish playing
  await Future.delayed(Duration(milliseconds: 500)); // Adjust this based on your sound length

  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => HomePage()),
  );
},
                    child: Padding(
                      padding: EdgeInsets.only(left: 40, right: 40, bottom: 60),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: EdgeInsets.all(30),
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              'PLAY GAME',
                              style: myNewFont,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
  
  
                ],
              ),
            )),
      );
    }
  }
  
  
  