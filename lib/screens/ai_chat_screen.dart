import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  bool _isLoading = false;
  File? _selectedImage;

  final String _apiKey = 'local'; // API key not required for local Ollama
  
  // Use 10.0.2.2 for Android Emulator, 127.0.0.1 for Windows Desktop
  String get _baseUrl {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:11434/v1/chat/completions';
    }
    return 'http://127.0.0.1:11434/v1/chat/completions';
  }

  @override
  void initState() {
    super.initState();
    _messages.add({
      'role': 'ai',
      'text': 'Hello! I am your local Pectus AI assistant powered by Phi-3 running directly on your machine. I can provide feedback and exercise recommendations based on your description.',
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  Future<void> _sendMessage() async {
    if (_controller.text.isEmpty && _selectedImage == null) return;

    final userText = _controller.text;
    final image = _selectedImage;

    setState(() {
      _messages.add({
        'role': 'user',
        'text': userText,
        'image': image,
      });
      _isLoading = true;
      _controller.clear();
      _selectedImage = null;
    });

    try {
      final List<Map<String, dynamic>> messagesPayload = [
        {
          "role": "system",
          "content": "You are an expert medical assistant specializing in Pectus Excavatum. Give them feedback on their condition based on their descriptions. 1. Recommend specific exercises like deep breathing, core strengthening, and posture correction. 2. Always emphasize that you are an AI and they should consult a doctor."
        }
      ];

      // Get last 10 messages for context
      final recentMessages = _messages.length > 10 
          ? _messages.sublist(_messages.length - 10) 
          : _messages;

      for (var msg in recentMessages) {
        if (msg['role'] == 'user') {
          messagesPayload.add({
            "role": "user",
            "content": msg['text'] ?? "Image sent"
          });
        } else {
          messagesPayload.add({
            "role": "assistant",
            "content": msg['text']
          });
        }
      }

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Authorization': 'Bearer $_apiKey',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "model": "pectus-ai",
          "messages": messagesPayload,
          "temperature": 0.5, 
          "max_tokens": 1024,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final aiResponse = data['choices'][0]['message']['content'];
        setState(() {
          _messages.add({'role': 'ai', 'text': aiResponse});
        });
      } else {
        throw Exception('Failed to connect to Groq: ${response.body}');
      }
    } catch (e) {
      setState(() {
        _messages.add({
          'role': 'ai',
          'text': 'Error: ${e.toString()}',
        });
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('AI Chest Analysis', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['role'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isUser ? Theme.of(context).primaryColor : Theme.of(context).cardTheme.color,
                      borderRadius: BorderRadius.circular(20).copyWith(
                        bottomRight: isUser ? Radius.zero : null,
                        bottomLeft: isUser ? null : Radius.zero,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (msg['image'] != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(msg['image']),
                            ),
                          ),
                        Text(
                          msg['text'] ?? '',
                          style: TextStyle(
                            color: isUser ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).textTheme.bodyLarge?.color,
                            fontSize: 15,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Theme.of(context).primaryColor)),
            ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_selectedImage != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(_selectedImage!, height: 80, width: 80, fit: BoxFit.cover),
                  ),
                  Positioned(
                    top: 0, right: 0,
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedImage = null),
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                        child: const Icon(Icons.close, size: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              // Image picker hidden for local text model
              /* IconButton(
                icon: const Icon(Icons.image_outlined, color: Color(0xFF4DD0E1)),
                onPressed: _pickImage,
              ), */
              Expanded(
                child: TextField(
                  controller: _controller,
                  style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color?.withAlpha(60)),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
                    filled: true,
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(color: Theme.of(context).primaryColor, shape: BoxShape.circle),
                child: IconButton(
                  icon: Icon(Icons.send, color: Theme.of(context).colorScheme.onPrimary),
                  onPressed: _sendMessage,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const SizedBox(height: 90), // Added padding for floating nav bar
        ],
      ),
    );
  }
}
