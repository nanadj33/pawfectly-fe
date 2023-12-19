import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pawfectly/constants/forumdata.dart';

import 'attachment_chip.dart';
import 'tag_chip.dart';

class CommentChildWidget extends StatefulWidget {
  final List<Map<String, dynamic>> data;
  final DiscussionForum forumData;

  CommentChildWidget({
    required this.data,
    required this.forumData,
  });

  @override
  _CommentChildWidgetState createState() => _CommentChildWidgetState();
}

class _CommentChildWidgetState extends State<CommentChildWidget> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            widget.forumData.pic,
                            width: 50,
                          ),
                          SizedBox(width: 8,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.forumData.name,
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                              Text(
                                widget.forumData.time,
                                style: TextStyle(
                                    fontSize: 11,
                                    height: 1
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                      InkWell(
                        onTap: (){
                          setState(() {
                                      widget.forumData.isSaved = !widget.forumData.isSaved;
                                    });
                        },
                        child: Icon(
                          Icons.bookmark,
                          color: widget.forumData.isSaved
                                      ? Color.fromARGB(255, 193, 130, 125)
                                      : Color.fromARGB(
                                            77, 224, 186, 181),
                          size: 38,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 14),
                  Text(
                    widget.forumData.title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    widget.forumData.content,
                    style: TextStyle(fontSize: 13, height: 1.25),
                  ),
                  SizedBox(height: 20),
                  Wrap(
                    children: [
                      ...widget.forumData.attachment.map((attachment) => buildAttachmentChip(attachment, context)).toList(),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        children: [
                          ...widget.forumData.tags.map((tag) => buildTagChip(tag)).toList(),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            children: [
                              Icon(
                                Icons.warning_rounded,
                                size: 34,
                                color: Color(0xffDBCA4E),
                              ),
                              Text(
                                "report",
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 11,
                                  height: 1,
                                  color: Color(0xffDBCA4E),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 8),
                          Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  setState(() {
                                    widget.forumData.isFavorite = !widget.forumData.isFavorite;
                                    if (widget.forumData.isFavorite) {
                                      widget.forumData.likes += 1;
                                    } else {
                                      widget.forumData.likes -= 1;
                                    }
                                  });
                                },
                                child: Icon(
                                  Icons.favorite,
                                  color: widget.forumData.isFavorite
                                      ? Color(0xffCC5946)
                                      : Color.fromARGB(107, 204, 90, 70),
                                  size: 34,
                                ),
                              ),
                              Text(
                                "${widget.forumData.likes}",
                                style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 11,
                                  height: 1,
                                  color: Color(0xffCC5946),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left:20.0, top: 16),
          child: Text("Replies (${widget.data.length})",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600
            ),),
        ),
        for (var i = 0; i < widget.data.length; i++)
          Padding(
            padding: const EdgeInsets.fromLTRB(6.0, 8.0, 6.0, 0.0),
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
                        imageURLorPath: widget.data[i]['pic']),
                  ),
                ),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.data[i]['name'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    formatDateTime(widget.data[i]['date']),
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
              subtitle: Text(widget.data[i]['message']),
            ),
          ),
      ],
    );
  }

  String formatDateTime(DateTime dateTime) {
    String formattedDate = DateFormat.yMMMMd('id_ID').format(dateTime);
    String formattedTime = DateFormat.jm('id_ID').format(dateTime);
    return '$formattedDate - $formattedTime';
  }
}
