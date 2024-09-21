import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DigitalPetApp(),
  ));
}

class DigitalPetApp extends StatefulWidget {
  const DigitalPetApp({super.key});

  @override
  State<DigitalPetApp> createState() {
    return _DigitalPetAppState();
  }
}

class _DigitalPetAppState extends State<DigitalPetApp> {
  String petName = "Pickels";
  int happinessLevel = 50;
  int hungerLevel = 50;
  String mood = "Neutral";
  int red = 255;
  int green = 255;
  int blue = 255;
  String imageplaceholder = "parkbg.png";
  String petplaceholder = "petimage.png";
  String _now = "";
  Timer? _everySecond;
  int _countdown = 10;

//BEGINNING OF MOOD RELATED FUNCTIONS
// Function to increase happiness and update hunger when playing with the pet
  void _playWithPet() {
    setState(() {
      if (_countdown != 0) {
        happinessLevel = (happinessLevel + 10).clamp(0, 100);
        _updateHunger();
      }
      _updateMood();
      _updateColor();
    });
  }

// Function to decrease hunger and update happiness when feeding the pet
  void _feedPet() {
    setState(() {
      if (_countdown != 0) {
        hungerLevel = (hungerLevel - 10).clamp(0, 100);
        _updateHappiness();
      }
      _updateMood();
      _updateColor();
    });
  }

// Update happiness based on hunger level
  void _updateHappiness() {
    if (hungerLevel < 30) {
      happinessLevel = (happinessLevel - 20).clamp(0, 100);
    } else {
      happinessLevel = (happinessLevel + 10).clamp(0, 100);
    }
    _updateMood();
    _updateColor();
  }

// Increase hunger level slightly when playing with the pet
  void _updateHunger() {
    hungerLevel = (hungerLevel + 5).clamp(0, 100);
    if (hungerLevel > 100) {
      hungerLevel = 100;
      happinessLevel = (happinessLevel - 20).clamp(0, 100);
    }
    _updateColor();
  }

  void _updateMood() {
    if (happinessLevel > 70) {
      mood = "Happy";
      petplaceholder = "coolcat.png";
      imageplaceholder = "dolphinbg.png";
    } else if (happinessLevel >= 30 && happinessLevel <= 70) {
      mood = "Neutral";
      petplaceholder = "petimage.png";
      imageplaceholder = "parkbg.png";
    } else {
      mood = "Unhappy";
      petplaceholder = "angrypetimage.png";
      imageplaceholder = "explosionbg.png";
    }
  }

  void _updateColor() {
    if (happinessLevel < 30) {
      //red
      green = 50;
      blue = 50;
      red = 255;
    } else if (happinessLevel > 70) {
      //green
      red = 50;
      green = 255;
      blue = 50;
    } else {
      //yellow
      red = 255;
      green = 255;
      blue = 50;
    }
  }
  //END OF MOOD RELATED FUNCTIONS

//BEGINNING OF TIMER RELATED FUNCTIONS
  void _countDownTimer(int seconds) {
    _countdown = 10;

    _everySecond = Timer.periodic(Duration(seconds: seconds), (Timer t) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
          if (hungerLevel < 100) {
            hungerLevel += 15;
          }
          _now = '$petName is $mood\n Current Timer: $_countdown';
        } else {
          t.cancel();
          if (happinessLevel > 70) {
            _now = "Winner";
          } else if (happinessLevel >= 30 && happinessLevel <= 70) {
            _now = "Meh";
          } else {
            _now = "GAME OVER";
          }
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _now = '$petName is $mood\n Current Timer: $_countdown';
    _countDownTimer(1);
  }

  void _restart() {
    _now = '$petName is $mood\n Current Timer: $_countdown';
    _countDownTimer(1);
  }
  //END OF TIMER RELATED FUNCTIONS

  //BEGINNING OF STYLES
  Shadow _setShadow(double pointOne, double pointTwo, Color color) {
    return Shadow(
        // bottomLeft
        offset: Offset(pointOne, pointTwo),
        color: color);
  }

  TextStyle _getTextStyle() {
    if (_now.contains("Winner") && _countdown == 0) {
      return GoogleFonts.pixelifySans(
        color: const Color.fromARGB(255, 15, 136, 15),
        shadows: [
          _setShadow(-1.5, -1.5, Colors.white),
          _setShadow(1.5, -1.5, Colors.white),
          _setShadow(1.5, 1.5, Colors.white),
          _setShadow(-1.5, 1.5, Colors.white),
        ],
        fontSize: 60,
        fontWeight: FontWeight.bold,
      );
    } else if (_now.contains("Meh") && _countdown == 0) {
      return GoogleFonts.pixelifySans(
        color: const Color.fromARGB(255, 176, 156, 46),
        shadows: [
          _setShadow(-1.5, -1.5, Colors.white),
          _setShadow(1.5, -1.5, Colors.white),
          _setShadow(1.5, 1.5, Colors.white),
          _setShadow(-1.5, 1.5, Colors.white),
        ],
        fontSize: 60,
        fontWeight: FontWeight.bold,
      );
    } else if (_now.contains("GAME OVER") && _countdown == 0) {
      return GoogleFonts.pixelifySans(
        color: const Color.fromARGB(255, 161, 8, 8),
        shadows: [
          _setShadow(-1.5, -1.5, Colors.black),
          _setShadow(1.5, -1.5, Colors.black),
          _setShadow(1.5, 1.5, Colors.black),
          _setShadow(-1.5, 1.5, Colors.black),
        ],
        fontSize: 60,
        fontWeight: FontWeight.bold,
      );
    } else {
      return GoogleFonts.pixelifySans(
        color: const Color.fromARGB(255, 253, 253, 253),
        shadows: [
          _setShadow(-1.5, -1.5, Colors.black),
          _setShadow(1.5, -1.5, Colors.black),
          _setShadow(1.5, 1.5, Colors.black),
          _setShadow(-1.5, 1.5, Colors.black),
        ],
        fontSize: 30.0,
        fontWeight: FontWeight.w500,
      );
    }
  }

  List<ElevatedButton> _buildButtons() {
    List<ElevatedButton> buttonList = [];

    if (_countdown != 0) {
      buttonList.add(
        ElevatedButton(
          onPressed: _playWithPet,
          child: const Text('Play with Your Pet'),
        ),
      );
      buttonList.add(
        ElevatedButton(
          onPressed: _feedPet,
          child: const Text('Feed Your Pet'),
        ),
      );
    } else {
      buttonList.add(
        ElevatedButton(
          onPressed: () {
            if (happinessLevel > 70) {
              _now = "Winner";
            } else if (happinessLevel >= 30 && happinessLevel <= 70) {
              _now = "Meh";
            } else {
              _now = "GAME OVER";
            }
            _now = '$petName is $mood\n Current Timer: $_countdown';

            _restart();
            _playWithPet();
            _feedPet();
          },
          child: const Text('Try Again'),
        ),
      );
    }

    return buttonList;
  }

  //END OF STYLES

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Digital Pet',
          style: GoogleFonts.pixelifySans(
            color: const Color.fromARGB(255, 222, 214, 214),
            shadows: [
              _setShadow(-1.5, -1.5, Colors.black),
              _setShadow(1.5, -1.5, Colors.black),
              _setShadow(1.5, 1.5, Colors.black),
              _setShadow(-1.5, 1.5, Colors.black),
            ],
            fontSize: 40.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/" + imageplaceholder),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _now,
              style: _getTextStyle(),
            ),

            Image.asset(
              "assets/images/" + petplaceholder,
              width: 300,
              color: Color.fromRGBO(red, green, blue, 1),
              colorBlendMode: BlendMode.modulate,
              key: UniqueKey(), // Forces the widget to reload the image
            ),

            // Text(
            //   'Name: $petName',
            //   style: TextStyle(fontSize: 20.0),
            // ),
            const SizedBox(height: 16.0),
            Text(
              'Happiness Level: $happinessLevel',
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Hunger Level: $hungerLevel',
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 32.0),
            ..._buildButtons(),
          ],
        ),
      ),
    );
  }
}
