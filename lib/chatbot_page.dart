import 'package:flutter/material.dart';
import 'package:shoebot/add_to_cart.dart';
import 'package:shoebot/searchpage.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';
import 'package:shoebot/product_details.dart';

class ChatBotScreen extends StatefulWidget {
  static String id = "chatbot";

  String txt;

  ChatBotScreen(this.txt);

  @override
  _ChatBotState createState() => _ChatBotState();
}

class ChatMessage {
  final String text;
  final bool isUser;

  ChatMessage({required this.text, required this.isUser});
}


class _ChatBotState extends State<ChatBotScreen> {
  final TextEditingController _textController = TextEditingController();
  stt.SpeechToText _speech = stt.SpeechToText();
  String _text = '';
  bool _isListening = false;
  final List<ChatMessage> messages = [
  ];
  @override
  void initState() {
    super.initState();
    _initializeSpeechRecognition();

    // Add widget.txt to the messages list
    messages.add(ChatMessage(text: "${widget.txt}", isUser: true));
    messages.add(ChatMessage(text: "Hello", isUser: false));
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



  void _addMessage(String message,bool isUser) {
    setState(() {
      messages.add(ChatMessage(text: message, isUser: isUser));
      _textController.clear(); // Clear the text field after sending the message
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(0.0, 40.0, 0.0, 0.0),
            child: Text(
              "S H O E B O T",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            "Speech :" + _text,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(message: ChatMessage(text: messages[index].text, isUser: messages[index].isUser));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: InputDecoration(
                      labelText: "Ask me what you're looking for today!",
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Handle sending the message
                    _addMessage(_textController.text, true);
                    // Do something with the user message
                    _addMessage("some output from api", false);

                    if(messages.length>=5)
                      {
                        Navigator.pushNamed(context, MySearchApp.id);
                      }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Row(
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
                  _addMessage(_text, true);
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
              child: Icon(
                _isListening ? Icons.mic_none : Icons.mic,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(width: 16),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  ChatBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: message.isUser ?  Colors.blue :Colors.green,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          message.text,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
