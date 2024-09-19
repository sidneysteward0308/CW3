import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
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
// Function to increase happiness and update hunger when playing with the pet
  void _playWithPet() {
    setState(() {
      happinessLevel = (happinessLevel + 10).clamp(0, 100);
      _updateHunger();
      _updateMood();
      _updateColor();
    });
  }

// Function to decrease hunger and update happiness when feeding the pet
  void _feedPet() {
    setState(() {
      hungerLevel = (hungerLevel - 10).clamp(0, 100);
      _updateHappiness();
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

  void _updateMood() {
    setState(() {
      if (happinessLevel > 70) {
        mood = "Happy";
        imageplaceholder = "dolphinbg.png";
      } else if (happinessLevel >= 30 && happinessLevel <= 70) {
        mood = "Neutral";
        imageplaceholder = "parkbg.png";
      } else {
        mood = "Unhappy";
        imageplaceholder = "explosionbg.png";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Digital Pet'),
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
              '$petName is $mood',
              style: TextStyle(fontSize: 20.0),
            ),

            Image.asset(
              "assets/images/petimage.png",
              width: 250,
              color: Color.fromRGBO(red, green, blue, 100), colorBlendMode: BlendMode.modulate,
            ),
            // Text(
            //   'Name: $petName',
            //   style: TextStyle(fontSize: 20.0),
            // ),
            SizedBox(height: 16.0),
            Text(
              'Happiness Level: $happinessLevel',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 16.0),
            Text(
              'Hunger Level: $hungerLevel',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _playWithPet,
              child: Text('Play with Your Pet'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _feedPet,
              child: Text('Feed Your Pet'),
            ),
          ],
        ),
      ),
    );
  }
}
