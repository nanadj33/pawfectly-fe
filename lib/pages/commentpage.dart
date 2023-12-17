import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class CommentPage extends StatefulWidget {
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List<Map<String, dynamic>> filedata = [
    {
      'name': 'Chuks Okwuenu',
      'pic': 'https://picsum.photos/300/30',
      'message': 'I love to code',
      'date': DateTime(2021, 1, 1, 12, 0, 0),
    },
    // Add more comment data as needed
  ];

  @override
  void initState() {
    super.initState();
    initializeDateFormatting(); // Initialize intl library
  }

  Widget commentChild(List<Map<String, dynamic>> data) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.0)
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset("assets/female.svg")
                  ],
                )
              ],
            ),

          ),
        ),
        for (var i = 0; i < data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(2.0, 8.0, 2.0, 0.0),
            child: ListTile(
              leading: GestureDetector(
                onTap: () async {
                  // Display the image in a large form.
                  print("Comment Clicked");
                },
                child: Container(
                  height: 50.0,
                  width: 50.0,
                  decoration: new BoxDecoration(
                      color: Colors.blue,
                      borderRadius: new BorderRadius.all(Radius.circular(50))),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: CommentBox.commentImageParser(
                        imageURLorPath: data[i]['pic']),
                  ),
                ),
              ),
              title: Text(
                data[i]['name'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(data[i]['message']),
              trailing: Text(
                formatDateTime(data[i]['date']),
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCF2F1),
      appBar: AppBar(
        title: Text("Comment Page"),
        backgroundColor: Color(0xffFCF2F1)
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide.none)
        ),
        child: CommentBox(
          userImage: CommentBox.commentImageParser(
              imageURLorPath: "assets/girl.jpg"),
          child: commentChild(filedata),
          labelText: 'Comment as Regina...',
          errorText: 'Comment cannot be blank',
          withBorder: false,
          sendButtonMethod: () {
            if (formKey.currentState!.validate()) {
              print(commentController.text);
              setState(() {
                var value = {
                  'name': 'Regina',
                  'pic': "assets/girl.jpg",
                  'message': commentController.text,
                  'date': DateTime.now(),
                };

                filedata.insert(0, value);
              });
              commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: Color(0xffFAE3E0),
          textColor: Color.fromARGB(255, 176, 121, 114),
          
          sendWidget: Icon(Icons.send_rounded, size: 40, color: Color.fromARGB(255, 169, 126, 120)),
        ),
      ),
    );
  }

  String formatDateTime(DateTime dateTime) {
    String formattedDate = DateFormat.yMMMMd('id_ID').format(dateTime);
    String formattedTime = DateFormat.jm('id_ID').format(dateTime);
    return '$formattedDate - $formattedTime';
  }
}
