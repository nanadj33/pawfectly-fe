import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  final String doctorName = "Drh. Strange";
  final String doctorProfession = "Dokter Hewan Umum";
  final String doctorImage = "assets/doc.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF2F1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Online Consultation"),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0, bottom: 20.0, left: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        doctorImage,
                        width: 65,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            doctorName,
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            doctorProfession,
                            style: const TextStyle(fontSize: 13),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.call_rounded,
                        color: Color(0xffFA8439),
                        size: 40,
                      ),
                      onPressed: ()async{
                        final Uri url = Uri(
                          scheme: 'tel',
                          path: "081233333333"
                        );
                        if (await canLaunchUrl(url)){
                          await launchUrl(url);
                        } else {
                          print("can't launch this url");
                        }
                      },
                    ),
                    const SizedBox(width: 6),
                    IconButton(
                    icon: const Icon(
                      Icons.videocam_rounded,
                      color: Color(0xffCC5946),
                      size: 50,
                    ),
                    onPressed: ()async{
                        final Uri url0 = Uri.parse('https://meet.jit.si/deviceid');
                        if (!await launchUrl(url0)) {
                          throw Exception('Could not launch $url0');
                        }
                    }
                  ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Flexible(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      reverse: true,
                      itemBuilder: (_, int index) => _messages[index],
                      itemCount: _messages.length,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: _buildTextComposer(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      _handleImageSubmitted(imageFile);
    }
  }

  void _handleImageSubmitted(File imageFile) {
    ChatMessage message = ChatMessage(
      doctorImage: doctorImage,
      text: 'Image',
      sender: 'You',
      isImage: true,
      imageFile: imageFile,
    );

    setState(() {
      _messages.insert(0, message);
    });

    _simulateDoctorReply();
  }

  void _simulateDoctorReply() {
    Future.delayed(const Duration(seconds: 1), () {
      ChatMessage reply = ChatMessage(
        text: 'Halo, ada yang bisa saya bantu?',
        sender: 'Doc',
        doctorImage: doctorImage,
      );
      setState(() {
        _messages.insert(0, reply);
      });
    });
  }

  Widget _buildTextComposer() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: const Color(0xffF6CDC7),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 6, bottom: 6, right: 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: TextField(
                  controller: _textController,
                  onSubmitted: _handleSubmitted,
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Enter your message',
                    hintStyle: const TextStyle(color: Color.fromARGB(255, 194, 119, 107)),
                    filled: true,
                    fillColor: Colors.transparent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(18),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.camera_alt,
                      size: 30,
                      color: Color.fromARGB(255, 194, 119, 107),
                    ),
                    onPressed: _pickImage,
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.send,
                      size: 34,
                      color: Color.fromARGB(255, 194, 119, 107),
                    ),
                    onPressed: () => _handleSubmitted(_textController.text),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    ChatMessage message = ChatMessage(
      text: text,
      sender: 'You',
      doctorImage: doctorImage,
    );
    setState(() {
      _messages.insert(0, message);
    });

    _simulateDoctorReply();
  }
}

class RoundedImage extends StatelessWidget {
  final File imageFile;

  const RoundedImage({super.key, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Image.file(
                imageFile,
                fit: BoxFit.contain,
              ),
            );
          },
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.file(
          imageFile,
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key, 
    required this.text,
    required this.sender,
    required this.doctorImage,
    this.isImage = false,
    this.imageFile,
  });

  final String text;
  final String sender;
  final bool isImage;
  final File? imageFile;
  final String doctorImage;

  @override
  Widget build(BuildContext context) {
    final bool isUserSender = sender == 'You';

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 2.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: !isUserSender
                  ? CircleAvatar(
                      radius: 20.0,
                      backgroundImage: AssetImage(doctorImage),
                    )
                  : null,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: isUserSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: <Widget>[
                  if (isImage)
                    Container(
                      margin: const EdgeInsets.only(right: 0),
                      child: RoundedImage(imageFile: imageFile!),
                    )
                  else
                    Container(
                      margin: !isUserSender ? const EdgeInsets.only(right: 50) : const EdgeInsets.only(left: 50),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: isUserSender ? const Color(0xffFFC989) : const Color(0xffF1ACA1),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 15,
                          color: isUserSender ? const Color.fromARGB(255, 78, 53, 24) : Colors.black,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
