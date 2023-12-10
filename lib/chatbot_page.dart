import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shoebot/searchpage.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';

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
  String apiUrl = "https://assistfunc2.azurewebsites.net/api/http_trigger?code=6YQLkzQmdX56vMxN8o4mY-kFLMriGdmDb8heltUeaRFQAzFuGoTFmQ==";

  bool _isListening = false;
  final List<ChatMessage> messages = [];

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

  Future<void> sendDataToApi(String text) async {
    String apiUrl = "https://assistfunc2.azurewebsites.net/api/http_trigger?code=6YQLkzQmdX56vMxN8o4mY-kFLMriGdmDb8heltUeaRFQAzFuGoTFmQ==";
    Map<String, String> headers = {"Content-Type": "application/json"};
    print("text" + text);
    Map<String, dynamic> body = {"text": text};


      try {
        var response = await http.post(
            Uri.parse(apiUrl), headers: headers, body: json.encode(body));


        print(response.statusCode);
        print (body);
        if (response.statusCode == 200) {
          dynamic responseBody = json.decode(response.body);

          if (responseBody is List) {
            if (responseBody.isNotEmpty) {
              // Ensure that the first element is not null
              if (responseBody[0] != null) {
                String firstElement = responseBody[0].toString();
                print("First Element of the List: $firstElement");
                _addMessage(firstElement, false);
              } else {
                print("First element of the list is null");
              }
            } else {
              print("Empty list received from the API");
            }
          } else {
            print("Unexpected type for response body in the API response");
          }
        } else {
          print("Error: ${response.statusCode}");
        }
      } catch (error) {
        print("Exception: $error");
      }
    _textController.clear();
  }



  @override
  void dispose() {
    _speech.stop();
    super.dispose();
  }

  void _addMessage(String message, bool isUser) {
    setState(() {
      messages.add(ChatMessage(text: message, isUser: isUser));
       // Clear the text field after sending the message
      //_textController.clear();
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
                return ChatBubble(
                  message: ChatMessage(
                    text: messages[index].text,
                    isUser: messages[index].isUser,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: [
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
                          sendDataToApi(_textController.text);
                          _addMessage(_textController.text, true);

                          if (messages.length >= 5) {
                            Navigator.pushNamed(context, MySearchApp.id);
                          }
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: AvatarGlow(
                    animate: _isListening,
                    glowColor: Colors.yellow,
                    endRadius: 30.0,
                    duration: const Duration(milliseconds: 2000),
                    repeatPauseDuration: const Duration(milliseconds: 100),
                    repeat: true,
                    child: FloatingActionButton(
                      onPressed: () {
                        if (_isListening) {
                          _speech.stop();
                          if(_text != ' ' || _text.length !=0) {
                            print(_text);
                            _addMessage(_text, true);
                          }
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
                ),
              ],
            ),
          ),
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
          color: message.isUser ? Colors.blue : Colors.green,
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