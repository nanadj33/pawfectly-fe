import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pawfectly/constants/forumdata.dart';
import 'package:pawfectly/widgets/comment_child.dart';

class CommentPage extends StatefulWidget {
  final DiscussionForum forumData;

  CommentPage({Key? key, required this.forumData}) : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  List<Map<String, dynamic>> filedata = [
    {
      'name': 'Dahlia',
      'pic': 'https://picsum.photos/300/30',
      'message': 'masa sih 😭',
      'date': DateTime(2021, 1, 1, 12, 0, 0),
    },
  ];
  late DiscussionForum forumData;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    forumData = widget.forumData;
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCF2F1),
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(right: 30.0),
          child: Text(
            forumData.title,
            style: TextStyle(fontSize: 16),
          ),
        ),
        backgroundColor: Color(0xffFCF2F1),
      ),
      body: Container(
        decoration: BoxDecoration(
          border: Border(top: BorderSide.none),
        ),
        child: CommentBox(
          userImage: CommentBox.commentImageParser(
              imageURLorPath: "assets/girl.jpg"),
          child: CommentChildWidget(
            data: filedata, // Pass the required argument 'data'
            forumData: forumData, // Pass the required argument 'forumData'
          ),
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
          sendWidget: Icon(Icons.send_rounded,
              size: 40, color: Color.fromARGB(255, 169, 126, 120)),
        ),
      ),
    );
  }
}
