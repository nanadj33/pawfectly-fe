import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:pawfectly/constants/constants.dart';
import 'package:pawfectly/constants/discussion_data.dart';
import 'package:pawfectly/constants/discussion_post_data.dart';
import 'package:pawfectly/constants/replies_data.dart';
import 'package:pawfectly/controllers/discussion_controller.dart';
import 'package:pawfectly/pages/forum_update.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CommentPage extends StatefulWidget {
  final DiscussionPost forumData;

  const CommentPage({Key? key, required this.forumData}) : super(key: key);

  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  String? userId;
  String? profilePicture;
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  late DiscussionPost forumData;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    forumData = widget.forumData;
    getUserId();
    initializeDateFormatting();
  }

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('id');
    profilePicture = prefs.getString('image');
    setState(() {});
  }

  String formatDateTime(DateTime dateTime) {
    String formattedDate = DateFormat.yMMMMd('id_ID').format(dateTime);
    String formattedTime = DateFormat.jm('id_ID').format(dateTime);
    return '$formattedDate - $formattedTime';
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffFCF2F1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 252, 242, 241),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: Color(0xff704520),
          ),
        ),
        title: Text(
          forumData.title,
          style: TextStyle(
            color: const Color(0xff403D2F),
            fontWeight: FontWeight.bold,
            fontSize: deviceWidth / 20,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide.none),
        ),
        child: CommentBox(
          userImage: NetworkImage("$urlIp/storage/$profilePicture"),
          labelText: 'Add a comment',
          errorText: 'Comment cannot be blank',
          withBorder: false,
          sendButtonMethod: () {
            if (formKey.currentState!.validate()) {
              DiscussionController.addReplies(
                  Replies(description: commentController.text),
                  widget.forumData.postId,
                  context);
              commentController.clear();
              FocusScope.of(context).unfocus();
            } else {
              print("Not validated");
            }
          },
          formKey: formKey,
          commentController: commentController,
          backgroundColor: const Color(0xffFAE3E0),
          textColor: const Color.fromARGB(255, 176, 121, 114),
          sendWidget: const Icon(Icons.send_rounded,
              size: 40, color: Color.fromARGB(255, 169, 126, 120)),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Container(
                  padding: EdgeInsets.all(deviceWidth / 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: deviceWidth / 30,
                          spreadRadius: 2.0,
                          color: Colors.grey.shade300,
                        )
                      ],
                      borderRadius:
                          BorderRadius.all(Radius.circular(deviceWidth / 20))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              widget.forumData.profilePictureUrl != null
                                  ? Container(
                                      height: 50.0,
                                      width: 50.0,
                                      decoration: const BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(50))),
                                      child: CircleAvatar(
                                        radius: 50,
                                        backgroundImage:
                                            CommentBox.commentImageParser(
                                          imageURLorPath: NetworkImage(
                                              '$urlIp/${widget.forumData.profilePictureUrl}'),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.grey,
                                        shape: BoxShape.circle,
                                      ),
                                      width: MediaQuery.of(context).size.width /
                                          10,
                                      height:
                                          MediaQuery.of(context).size.width /
                                              10,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.person,
                                            color: Colors.white,
                                            size: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                14,
                                          ),
                                        ],
                                      ),
                                    ),
                              const SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.forumData.name,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    DateFormat('dd-MM-yyyy kk:mm').format(
                                        DateTime.parse(
                                            widget.forumData.createdAt)),
                                    style: const TextStyle(
                                        fontSize: 11, height: 1),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Row(
                            children: [
                              FutureBuilder(
                                future: DiscussionController.getBookmarked(
                                    widget.forumData.postId),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return InkWell(
                                      onTap: () {
                                        snapshot.data!
                                            ? DiscussionController
                                                    .deleteBookmark(
                                                        widget.forumData.postId,
                                                        context)
                                                .then((value) {
                                                setState(() {});
                                              })
                                            : DiscussionController.addBookmark(
                                                    widget.forumData.postId,
                                                    context)
                                                .then((value) {
                                                setState(() {});
                                              });
                                      },
                                      child: Icon(
                                        Icons.bookmark,
                                        color: snapshot.data!
                                            ? const Color.fromARGB(
                                                255, 193, 130, 125)
                                            : const Color.fromARGB(
                                                77, 224, 186, 181),
                                        size: 38,
                                      ),
                                    );
                                  } else {
                                    return const SizedBox();
                                  }
                                },
                              ),
                              SizedBox(
                                width: deviceWidth / 20,
                              ),
                              userId != null &&
                                      widget.forumData.userId ==
                                          int.parse(userId!)
                                  ? InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return UpdateDiscussionPage(
                                              updateDis: DiscussionPostForm(
                                                  id: widget.forumData.postId,
                                                  title: widget.forumData.title,
                                                  description: widget
                                                      .forumData.description,
                                                  imageUrl:
                                                      widget.forumData.imageUrl,
                                                  tags:
                                                      widget.forumData.tags!));
                                        }));
                                      },
                                      child: const Icon(
                                        Icons.edit,
                                        color:
                                            Color.fromARGB(255, 193, 130, 125),
                                        size: 38,
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),
                      Text(
                        widget.forumData.title,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1.2),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        widget.forumData.description,
                        style: const TextStyle(fontSize: 13, height: 1.25),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width / 4,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.forumData.imageUrl!.length,
                            itemBuilder: (context, index2) {
                              return Padding(
                                padding:
                                    EdgeInsets.only(right: deviceWidth / 20),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(deviceWidth / 40),
                                  ),
                                  child: Image.network(
                                    "$urlIp${widget.forumData.imageUrl![index2]['image_path']}",
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    height:
                                        MediaQuery.of(context).size.width / 4,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              );
                            }),
                      ),
                      // Wrap(
                      //   children: [
                      //     ...filteredData[index]
                      //         .attachment
                      //         .map((attachment) =>
                      //             buildAttachmentChip(
                      //                 attachment, context))
                      //         .toList(),
                      //   ],
                      // ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              FutureBuilder(
                                future: DiscussionController.getLiked(
                                    widget.forumData.postId),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return InkWell(
                                      onTap: () {
                                        snapshot.data!
                                            ? DiscussionController.dislike(
                                                    widget.forumData.postId,
                                                    context)
                                                .then((value) {
                                                setState(() {});
                                              })
                                            : DiscussionController.addLike(
                                                    widget.forumData.postId,
                                                    context)
                                                .then((value) {
                                                setState(() {});
                                              });
                                      },
                                      child: Icon(
                                        Icons.favorite,
                                        color: snapshot.data!
                                            ? const Color(0xffCC5946)
                                            : Colors.grey,
                                      ),
                                    );
                                  } else {
                                    return const CircularProgressIndicator();
                                  }
                                },
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "${widget.forumData.likesCount} likes",
                                style: const TextStyle(fontSize: 12),
                              )
                            ],
                          ),
                          Text(
                            "Reply ",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: deviceWidth / 30,
                                color:
                                    const Color.fromARGB(255, 180, 123, 115)),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              FutureBuilder(
                  future:
                      DiscussionController.getReplies(widget.forumData.postId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      List<Replies> replies = snapshot.data!;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 16),
                            child: Text(
                              "Replies (${replies.length})",
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w600),
                            ),
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: replies.length,
                              itemBuilder: (context, id) {
                                return Padding(
                                  padding: EdgeInsets.fromLTRB(deviceWidth / 20,
                                      deviceWidth / 20, deviceWidth / 20, 0.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: deviceWidth / 30,
                                            spreadRadius: 2.0,
                                            color: Colors.grey.shade300,
                                          )
                                        ],
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(
                                          deviceWidth / 50,
                                        ))),
                                    child: ListTile(
                                      leading: GestureDetector(
                                        onTap: () async {
                                          // Display the image in a large form.
                                          print("Comment Clicked");
                                        },
                                        child: replies[id].profilePictureUrl !=
                                                null
                                            ? Container(
                                                height: 50.0,
                                                width: 50.0,
                                                decoration: const BoxDecoration(
                                                    color: Colors.blue,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                50))),
                                                child: CircleAvatar(
                                                  radius: 50,
                                                  backgroundImage: CommentBox
                                                      .commentImageParser(
                                                    imageURLorPath: NetworkImage(
                                                        '$urlIp/${replies[id].profilePictureUrl}'),
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.grey,
                                                  shape: BoxShape.circle,
                                                ),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    10,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    10,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.person,
                                                      color: Colors.white,
                                                      size:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              14,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                      ),
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            replies[id].name!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            formatDateTime(DateTime.parse(
                                                replies[id].createdAt!)),
                                            style:
                                                const TextStyle(fontSize: 10),
                                          ),
                                        ],
                                      ),
                                      subtitle: Text(replies[id].description),
                                    ),
                                  ),
                                );
                              })
                        ],
                      );
                    } else {
                      return const SizedBox();
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
