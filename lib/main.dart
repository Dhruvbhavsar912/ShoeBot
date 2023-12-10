import 'package:flutter/material.dart';
import 'package:shoebot/add_to_cart.dart';
import 'package:shoebot/searchpage.dart';
import 'package:shoebot/chatbot_page.dart';
import 'package:shoebot/payment.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';
import 'package:shoebot/product_details.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: MyHomePage.id,
      routes: {
        //AddToCartScreen.id: (context) => AddToCartScreen(),
       // ProductScreen.id: (context) => ProductScreen(),
        MyHomePage.id: (context) => MyHomePage(),
        //PaymentPage.id: (context) => PaymentPage(),
        MySearchApp.id: (context) => MySearchApp(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  static String id = "homepage";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  stt.SpeechToText _speech = stt.SpeechToText();
  String _text = "";
  bool _isListening = false;
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
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.deepPurple, Colors.black],
              ),
            ),
          ),
          ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(1, 76, 1, 6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Hero(
                      tag: 'logo',
                      child: TypewriterAnimatedTextKit(
                        speed: Duration(milliseconds: 190),
                        text: ["S H O E B O T"],
                        textStyle: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "Find your perfect pair",
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 40),
                    Hero(
                      tag: 'image',
                      child: Image.asset('assets/c2.PNG', height: 150),
                    ),
                    SizedBox(height: 20),
                    Text(
                      _text,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ChatBotScreen(_text),
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
            ],
          ),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [ AvatarGlow(
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
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: _isListening
                ? Icon(
              Icons.mic_none,
              key: ValueKey<bool>(true),
              color: Colors.black,
            )
                : Icon(
              Icons.mic,
              key: ValueKey<bool>(false),
              color: Colors.black,
            ),
          ),
        ),
      ),
      ],
    ),
    );
  }
}
