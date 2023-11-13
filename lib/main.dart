import 'package:flutter/material.dart';
import 'package:shoebot/add_to_cart.dart';
import 'package:shoebot/searchpage.dart';
import 'package:shoebot/chatbot_page.dart';
import 'package:shoebot/payment.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';
import 'package:shoebot/product_details.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(), // Set the dark theme
         initialRoute: MyHomePage.id,
        routes: {
          AddToCartScreen.id: (context) => AddToCartScreen(),
          ProductScreen.id : (context) => ProductScreen(),
          MyHomePage.id : (context) => MyHomePage(),
          PaymentPage.id : (context) => PaymentPage(),
          MySearchApp.id : (context) => MySearchApp(),
        }
    );
  }
}

class MyHomePage extends StatefulWidget {
  static String id ="homepage";
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  stt.SpeechToText _speech = stt.SpeechToText();
  String _text = "";
  bool _isListening = false;
  int k=0;
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _initializeSpeechRecognition();
  }

  Future<void> _initializeSpeechRecognition() async {

    bool available = await _speech.initialize();
    print(available);
    if (available) {
      setState(() {
        _isListening = true;
      });
    } else {
      print('Speech recognition not available on this device.');
    }
  }

  @override
  void dispose() {
    _speech.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //appBar: AppBar(
   //     title: Text("ShoeBot"),
   //   ),
      body: SingleChildScrollView( // Use SingleChildScrollView as the parent
        child: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 100.0, 0.0, 0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Text(
                "S H O E B O T",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                padding: const EdgeInsets.fromLTRB(0.0, 25.0, 0.0, 10.0),
              child: Text(
                "Find your perfect pair",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 40.0),
              child: Center(
                child: Image.asset('assets/c2.PNG'), // Use the asset path here
              ),
            ),
            Text(
              _text,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child:Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: "Ask me what you're looking for today!",
                    ),
                    onChanged: (value) {
                      setState(() {
                        _text = value;
                      });
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatBotScreen(_text),
                    ),
                    );
                  },
                ),
              ],
              ),
            ),
          ],
        ),
      ),
      ),
      floatingActionButton:Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        AvatarGlow(
        animate: _isListening,
        glowColor: Colors.yellow,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
            onPressed: () {
              if (_isListening) {
                _speech.stop();
              } else {
                _speech.listen(
                  onResult: (result) {
                    setState(() {
                      _text = result.recognizedWords;
                    });
                  },
                );
              }
              setState(() {
                _isListening = !_isListening;
              });
            },
            backgroundColor: Colors.yellow,
            child: Icon(_isListening ? Icons.mic_none : Icons.mic,color: Colors.black),
          ),
          ),
          SizedBox(width: 16), // Add space between the button and text field
        ],
      ),
    );
  }
}
