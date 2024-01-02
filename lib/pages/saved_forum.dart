import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pawfectly/constants/constants.dart';
import 'package:pawfectly/constants/discussion_data.dart';
import 'package:pawfectly/controllers/discussion_controller.dart';
import 'package:pawfectly/pages/forum_detail.dart';
import 'package:pawfectly/pages/forum_form.dart';

class SavedForumPage extends StatefulWidget {
  const SavedForumPage({Key? key}) : super(key: key);

  @override
  State<SavedForumPage> createState() => _SavedForumPageState();
}

class _SavedForumPageState extends State<SavedForumPage> {
  // final List<DiscussionForum> forumData = DiscussionForum.getcontent();
  // List<DiscussionForum> filteredData = [];
  Map<int, bool> isSavedMap = {};
  String searchVal = '';

  late Map<int, bool> isFavorite = {};
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // filteredData = forumData;
    // Initialize isSavedMap with false for all cards
    // for (int i = 0; i < forumData.length; i++) {
    //   isSavedMap[i] = false;
    //   isFavorite[i] = false;
    // }
  }

  // void filterSearchResults(String query) {
  //   List<DiscussionForum> searchResults = forumData
  //       .where((forum) =>
  //           forum.title.toLowerCase().contains(query.toLowerCase()) ||
  //           forum.content.toLowerCase().contains(query.toLowerCase()))
  //       .toList();

  //   setState(() {
  //     filteredData = searchResults;
  //   });
  // }
  Future refreshData() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 242, 241),
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
          "Saved Discussion",
          style: TextStyle(
            color: const Color(0xff403D2F),
            fontWeight: FontWeight.bold,
            fontSize: deviceWidth / 20,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddDiscussionPage(),
            ),
          );
        },
        child: SvgPicture.asset(
          'assets/forumsend.svg',
          width: 70,
          height: 70,
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: SizedBox(
                          height: 50,
                          child: TextField(
                            controller: searchController,
                            onChanged: (query) {
                              setState(() {
                                searchVal = query.toLowerCase();
                              });
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  searchController.clear();
                                },
                                icon: const Icon(Icons.clear,
                                    color: Color.fromARGB(255, 180, 123, 115)),
                              ),
                              prefixIcon: const Icon(
                                Icons.search_outlined,
                                color: Color.fromARGB(255, 180, 123, 115),
                                size: 30,
                              ),
                              hintText: 'Search...',
                              hintStyle: const TextStyle(
                                  color: Color.fromARGB(255, 180, 123, 115)),
                              filled: true,
                              fillColor: const Color.fromARGB(97, 246, 205, 199),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 12.0),
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
        body: FutureBuilder(
          future: DiscussionController.getSavedDiscussion(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              List<DiscussionPost> discussion = snapshot.data!;
              return RefreshIndicator(
                onRefresh: refreshData,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: discussion.length,
                  itemBuilder: (context, index) {
                    return discussion[index]
                            .title
                            .toLowerCase()
                            .contains(searchVal)
                        ? InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CommentPage(
                                    forumData: discussion[index],
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              discussion[index]
                                                          .profilePictureUrl !=
                                                      null
                                                  ? SvgPicture.asset(
                                                      discussion[index]
                                                          .profilePictureUrl!,
                                                      width: 50,
                                                    )
                                                  : Container(
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.grey,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              10,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              10,
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.person,
                                                            color: Colors.white,
                                                            size: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                14,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                              const SizedBox(width: 8),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    discussion[index].name,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    DateFormat(
                                                            "dd-MM-yyyy kk:mm")
                                                        .format(DateTime.parse(
                                                            discussion[index]
                                                                .createdAt)),
                                                    style: const TextStyle(
                                                        fontSize: 11,
                                                        height: 1),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                          FutureBuilder(
                                            future: DiscussionController
                                                .getBookmarked(
                                                    discussion[index].postId),
                                            builder: (context, snapshot) {
                                              if (snapshot.hasData) {
                                                return InkWell(
                                                  onTap: () {
                                                    snapshot.data!
                                                        ? DiscussionController
                                                                .deleteBookmark(
                                                                    discussion[
                                                                            index]
                                                                        .postId,
                                                                    context)
                                                            .then((value) {
                                                            setState(() {});
                                                          })
                                                        : DiscussionController
                                                                .addBookmark(
                                                                    discussion[
                                                                            index]
                                                                        .postId,
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
                                        ],
                                      ),
                                      const SizedBox(height: 14),
                                      Text(
                                        discussion[index].title,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            height: 1.2),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        discussion[index].description,
                                        style: const TextStyle(
                                            fontSize: 13, height: 1.25),
                                      ),
                                      const SizedBox(height: 20),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        child: ListView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: discussion[index]
                                                .imageUrl!
                                                .length,
                                            itemBuilder: (context, index2) {
                                              return Padding(
                                                padding: EdgeInsets.only(
                                                    right: deviceWidth / 20),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(
                                                        deviceWidth / 40),
                                                  ),
                                                  child: Image.network(
                                                    "$urlIp${discussion[index].imageUrl![index2]['image_path']}",
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            4,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            4,
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              FutureBuilder(
                                                future: DiscussionController
                                                    .getLiked(discussion[index]
                                                        .postId),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return InkWell(
                                                      onTap: () {
                                                        snapshot.data!
                                                            ? DiscussionController.dislike(
                                                                    discussion[
                                                                            index]
                                                                        .postId,
                                                                    context)
                                                                .then((value) {
                                                                setState(() {});
                                                              })
                                                            : DiscussionController.addLike(
                                                                    discussion[
                                                                            index]
                                                                        .postId,
                                                                    context)
                                                                .then((value) {
                                                                setState(() {});
                                                              });
                                                      },
                                                      child: Icon(
                                                        Icons.favorite,
                                                        color: snapshot.data!
                                                            ? const Color(
                                                                0xffCC5946)
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
                                                "${discussion[index].likesCount} likes",
                                                style: const TextStyle(fontSize: 12),
                                              )
                                            ],
                                          ),
                                          Text(
                                            "Reply ",
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic,
                                                fontSize: deviceWidth / 30,
                                                color: const Color.fromARGB(
                                                    255, 180, 123, 115)),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox();
                  },
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData && snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No data'),
              );
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
