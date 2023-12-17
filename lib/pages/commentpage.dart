import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pawfectly/constants/forumdata.dart';

class CommentPage extends StatefulWidget {
  final DiscussionForum forumData;

  CommentPage({Key? key, required this.forumData}) : super(key: key);

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  late DiscussionForum forumData;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    forumData = widget.forumData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 252, 242, 241),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 252, 242, 241),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        title: Text("Forum"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 3.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              forumData.pic,
                              width: 50,
                            ),
                            SizedBox(width: 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  forumData.name,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  forumData.time,
                                  style: TextStyle(fontSize: 11, height: 1),
                                ),
                              ],
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            // Handle bookmark tap if needed
                          },
                          child: Icon(
                            Icons.bookmark,
                            color: Color(0xffE0BAB5),
                            size: 38,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14),
                    Text(
                      forumData.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      forumData.content,
                      style: TextStyle(fontSize: 13, height: 1.25),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          children: [
                            ...forumData.tags.map((tag) => buildTagChip(tag)).toList(),
                            
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
                                    isFavorite ??= false;
                                    if (isFavorite) {
                                      forumData.likes -= 1;
                                    } else {
                                      forumData.likes += 1;
                                    }
                                    isFavorite = !isFavorite;
                                  });
                                  },
                                  child: Icon(
                                    Icons.favorite,
                                    color: isFavorite
                                    ? Color(0xffCC5946)
                                    : Color.fromARGB(107, 204, 90, 70),
                                    size: 34,
                                  ),
                                ),
                                Text(
                                  "${forumData.likes}",
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
        ],
      ),
    );
  }

  Widget buildTagChip(String tag) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:2.0, vertical: 2),
      child: IntrinsicWidth(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffFFFFE6BE),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
            child: Center(
              child: Text(
                tag,
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
