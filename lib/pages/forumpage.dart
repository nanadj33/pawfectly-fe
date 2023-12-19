import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pawfectly/pages/addDiscussion.dart';
import 'package:pawfectly/widgets/attachment_chip.dart';

import '../constants/forumdata.dart';
import 'commentpage.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({Key? key}) : super(key: key);

  @override
  State<ForumPage> createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  final List<DiscussionForum> forumData = DiscussionForum.getcontent();
  List<DiscussionForum> filteredData = [];
  Map<int, bool> isSavedMap = {};
  late Map<int, bool> isFavorite = {};
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredData = forumData;
    // Initialize isSavedMap with false for all cards
    for (int i = 0; i < forumData.length; i++) {
      isSavedMap[i] = false;
      isFavorite[i] = false;
    }
  }

  void filterSearchResults(String query) {
    List<DiscussionForum> searchResults = forumData
        .where((forum) =>
            forum.title.toLowerCase().contains(query.toLowerCase()) ||
            forum.content.toLowerCase().contains(query.toLowerCase()))
        .toList();

    setState(() {
      filteredData = searchResults;
    });
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
        title: Text("What's new?"),
      ),
      body: Stack(
        children: [
          NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0),
                            child: Container(
                              height: 50,
                              child: TextField(
                                controller: searchController,
                                onChanged: (query) {
                                  filterSearchResults(query);
                                },
                                decoration: InputDecoration(
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      searchController.clear();
                                      filterSearchResults('');
                                    },
                                    icon: Icon(Icons.clear,
                                        color: Color.fromARGB(
                                            255, 180, 123, 115)),
                                  ),
                                  prefixIcon: Icon(Icons.search_outlined,
                                      color: Color.fromARGB(
                                          255, 180, 123, 115),
                                      size: 30,),
                                  hintText: 'Search...',
                                  hintStyle: TextStyle(
                                      color: Color.fromARGB(
                                          255, 180, 123, 115)),
                                  filled: true,
                                  fillColor: Color.fromARGB(
                                      97, 246, 205, 199),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  contentPadding:
                                      EdgeInsets.symmetric(
                                          vertical: 12.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ];
            },
            body: ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    print('Card tapped');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommentPage(
                          forumData: filteredData[index],
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12.0, vertical: 3.0),
                    child: Card(
                      color: Colors.white,
                      surfaceTintColor: Colors.white,
                      shadowColor: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      filteredData[index].pic,
                                      width: 50,
                                    ),
                                    SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          filteredData[index].name,
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          filteredData[index].time,
                                          style: TextStyle(
                                              fontSize: 11, height: 1),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isSavedMap[index] ??= false;
                                      isSavedMap[index] =
                                          !isSavedMap[index]!;
                                    });
                                  },
                                  child: Icon(
                                    Icons.bookmark,
                                    color: isSavedMap[index] ?? false
                                        ? Color.fromARGB(255, 193, 130, 125)
                                      : Color.fromARGB(
                                            77, 224, 186, 181), 
                                    size: 38,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 14),
                            Text(
                              filteredData[index].title,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2),
                            ),
                            SizedBox(height: 6),
                            Text(
                              filteredData[index].content,
                              style: TextStyle(
                                  fontSize: 13, height: 1.25),
                              
                            ),
                            SizedBox(height: 20),
                            Wrap(
                              children: [
                                ...filteredData[index].attachment.map((attachment) => buildAttachmentChip(attachment, context)).toList(),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: (){
                                        setState(() {
                                          isFavorite[index] = !isFavorite[index]!;
                                          if (isFavorite[index]!) {
                                            filteredData[index].likes += 1;
                                            color: Color(0xffCC5946);
                                          } else {
                                            filteredData[index].likes -= 1;
                                          }
                                          
                                        });
                                      },
                                      child: Icon(
                                        Icons.favorite,
                                        color: isFavorite[index]! ? Color(0xffCC5946): Color.fromARGB(107, 204, 90, 70),
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${filteredData[index].likes} likes",
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                                Text(
                                  "Reply ",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 14,
                                      color: Color.fromARGB(
                                          255, 180, 123, 115)),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 24,
            right: 24,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddDiscussionPage(),
                  ),
                );
                print('Button Clicked');
              },
              icon: SvgPicture.asset(
                'assets/forumsend.svg',
                width: 70,
                height: 70,
              ),
            ),
          )
        ],
      ),
    );
  }
}
