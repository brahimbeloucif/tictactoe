import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool oTurn = true;
  List<String> displayExOh = List.filled(9, '');
  int oScore = 0;
  int xScore = 0;
  int equal = 0;

  static var myNewFontWhite = GoogleFonts.pressStart2p(
      textStyle: const TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 15));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(33, 33, 33, 1),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Player X", style: myNewFontWhite),
                          Text(xScore.toString(), style: myNewFontWhite),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Player O", style: myNewFontWhite),
                          Text(oScore.toString(), style: myNewFontWhite),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
              itemCount: 9,
              
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                
                crossAxisCount: 3,
                
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    _tapped(index);
                  },
                  child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          color: displayExOh[index] == 'X'
              ? Colors.blue // Set color for 'X'
              : displayExOh[index] == 'O'
                  ? Colors.orange // Set color for 'O'
                  : Colors.grey[800], // Set default color
          borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
        ),
        margin: EdgeInsets.all(8),// Add padding here

                    
                    child: Center(
                      child: Text(
                        displayExOh[index],
                        style: const TextStyle(color: Colors.white, fontSize: 40),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child:
                    DefaultTextStyle(
          style: const TextStyle(),
          child: AnimatedTextKit(
            animatedTexts: [
              TypewriterAnimatedText(
                'Coder By \ Brahim Beloucif',
                textStyle: GoogleFonts.kellySlab(
                  color: Colors.orangeAccent,
                  letterSpacing: 3,
                  fontSize: 30,
                ),
                speed: const Duration(milliseconds: 200),
              ),
            ],
            totalRepeatCount: 4,
            pause: const Duration(milliseconds: 1000),
            displayFullTextOnTap: true,
            stopPauseOnTap: true,
          ),
        ),
                  ),
                ],
              )

            ),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (oTurn && displayExOh[index] == '') {
        displayExOh[index] = 'O';
        equal++;
      } else if (!oTurn && displayExOh[index] == '') {
        displayExOh[index] = 'X';
        equal++;
      }
      oTurn = !oTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    // Check rows
    for (int i = 0; i < 9; i += 3) {
      if (displayExOh[i] == displayExOh[i + 1] &&
          displayExOh[i + 1] == displayExOh[i + 2] &&
          displayExOh[i] != '') {
        _showInDialog(displayExOh[i]);
        return;
      }
    }
    // Check columns
    for (int i = 0; i < 3; i++) {
      if (displayExOh[i] == displayExOh[i + 3] &&
          displayExOh[i + 3] == displayExOh[i + 6] &&
          displayExOh[i] != '') {
        _showInDialog(displayExOh[i]);
        return;
      }
    }
    // Check diagonals
    if (displayExOh[0] == displayExOh[4] &&
        displayExOh[0] == displayExOh[8] &&
        displayExOh[0] != '') {
      _showInDialog(displayExOh[0]);
      return;
    }

    if (displayExOh[2] == displayExOh[4] &&
        displayExOh[2] == displayExOh[6] &&
        displayExOh[2] != '') {
      _showInDialog(displayExOh[2]);
      return;
    }

    if (equal == 9) {
      _showDialogEqual();
    }
  }

  void _showDialogEqual() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("X and O is EQUALS"),
          actions: [
            FloatingActionButton(
              child: const Text("Play Again"),
              onPressed: () {
                _clearGame();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  void _showInDialog(String winner) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
                    playerSound();

        return AlertDialog(
          
          title: Text("WINNER IS: $winner"),
          
          actions: [
            FloatingActionButton(
              child: const Text("Play Again"),
              onPressed: () {
                
                _clearGame();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
    if (winner == 'X') {
      xScore++;
    } else if (winner == 'O') {
      oScore++;
    }
  }

  void _clearGame() {
    setState(() {
      for (var i = 0; i < 9; i++) {
        displayExOh[i] = '';
      }
      equal = 0;
    });
  }
  
playerSound() {

    AudioPlayer player =AudioPlayer();
    Source path = AssetSource("s.mp3");
    player.play(path);
  }}

