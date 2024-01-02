import 'package:comment_box/comment/comment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pawfectly/constants/constants.dart';
import 'package:pawfectly/constants/discussion_data.dart';
import 'package:pawfectly/constants/my_pet_data.dart';
import 'package:pawfectly/controllers/discussion_controller.dart';
import 'package:pawfectly/controllers/my_pet_controller.dart';
import 'package:pawfectly/pages/chatApp.dart';
import 'package:pawfectly/pages/forum_all.dart';
import 'package:pawfectly/pages/forum_detail.dart';
import 'package:pawfectly/pages/my_pet_all.dart';
import 'package:pawfectly/pages/my_pet_form.dart';
import 'package:pawfectly/pages/onboarding.dart';
import 'package:pawfectly/pages/pet_report.dart';
import 'package:pawfectly/pages/saved_forum.dart';
import 'package:pawfectly/pages/userprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DiscussionPost> topDiscussions = [];
  bool viewPhoto = false;

  @override
  void initState() {
    super.initState();
    topDiscussions.sort((a, b) => b.likesCount.compareTo(a.likesCount));
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffFCF2F1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffFCF2F1),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.menu_rounded,
                size: 30,
                color: Color(0xff704520),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: SvgPicture.asset(
          'assets/pawfectly.svg',
          width: 120,
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Container(
          width:
              MediaQuery.of(context).size.width * 3 / 4, // 3/4 dari lebar layar
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.bookmark,
                  color: Color(0xffE0BAB5),
                ),
                title: const Text(
                  'Saved Discussion',
                  style: TextStyle(
                    color: Color(0xffE0BAB5),
                  ),
                ),
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const SavedForumPage();
                  })).then((value) {
                    setState(() {});
                  }); // close the drawer
                },
              ),
              const Divider(
                indent: 18.0,
                endIndent: 18.0,
                thickness: 1.5,
                color: Color(0xffE0BAB5),
              ),
              ListTile(
                leading: const Icon(
                  Icons.person,
                  color: Color(0xffE0BAB5),
                ),
                title: const Text(
                  'My Profile',
                  style: TextStyle(
                    color: Color(0xffE0BAB5),
                  ),
                ),
                onTap: () {
                  // Handle going to settings
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const UserProfile();
                  })).then((value) {
                    setState(() {});
                  });
                },
              ),
              const Divider(
                indent: 18.0,
                endIndent: 18.0,
                thickness: 1.5,
                color: Color(0xffE0BAB5),
              ),
              ListTile(
                leading: const Icon(
                  Icons.logout_rounded,
                  color: Color(0xffE0BAB5),
                ),
                title: const Text(
                  'Logout',
                  style: TextStyle(
                    color: Color(0xffE0BAB5),
                  ),
                ),
                onTap: () async {
                  // Handle logout
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.clear();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => const OnboardingPage()),
                      (Route<dynamic> route) => false);
                },
              ),
              const Divider(
                indent: 18.0,
                endIndent: 18.0,
                thickness: 1.5,
                color: Color(0xffE0BAB5),
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: () async {
              setState(() {});
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    FutureBuilder(
                        future: SharedPreferences.getInstance(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Hi,",
                                        style: TextStyle(
                                            color: Color(0xff704520),
                                            fontSize: 18,
                                            height: 0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                        '${snapshot.data!.getString('name')!}!',
                                        style: const TextStyle(
                                            color: Color(0xff704520),
                                            fontSize: 30,
                                            height: 0,
                                            fontWeight: FontWeight.w900),
                                      )
                                    ],
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        viewPhoto = true;
                                      });
                                    },
                                    child: ClipOval(
                                        child: Image.network(
                                      '$urlIp/storage/${snapshot.data!.getString('image')!}',
                                      width: deviceWidth / 3.5,
                                      height: deviceWidth / 3.5,
                                      fit: BoxFit.cover,
                                    )),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        }),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xffFDB384),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ChatScreen()),
                                );
                              },
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    'assets/onlineconsult.svg',
                                    width: 60,
                                  ),
                                  const SizedBox(height: 6),
                                  const Text(
                                    "Online\nConsultation",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        height: 1,
                                        fontSize: 12,
                                        color: Color(0xff704520),
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                final Uri url = Uri.parse(
                                    'https://www.google.com/maps/search/klinik+hewan/@-6.1954543,106.8784504,15z/data=!3m1!4b1?entry=ttu');
                                if (!await launchUrl(url)) {
                                  throw Exception('Could not launch $url');
                                }
                              },
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    'assets/clinicfinder.svg',
                                    width: 60,
                                  ),
                                  const SizedBox(height: 6),
                                  const Text(
                                    "Clinic Finder",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        height: 1,
                                        fontSize: 12,
                                        color: Color(0xff704520),
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const PetListPage();
                                })).then((value) {
                                  setState(() {});
                                });
                              },
                              child: Column(
                                children: [
                                  SvgPicture.asset(
                                    'assets/petreport.svg',
                                    width: 60,
                                  ),
                                  const SizedBox(height: 6),
                                  const Text(
                                    "Pet Report",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        height: 1,
                                        fontSize: 12,
                                        color: Color(0xff704520),
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const MyPetAll();
                        })).then((value) {
                          setState(() {});
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xffF6CDC7)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "My Pets",
                                    style: TextStyle(
                                        height: 1,
                                        fontSize: 18,
                                        color: Color(0xFFCC5946),
                                        fontWeight: FontWeight.w600),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return const AddPetPage();
                                      })).then((value) {
                                        setState(() {});
                                      });
                                    },
                                    child: const Icon(
                                      Icons.add_circle_rounded,
                                      color: Color(0xFFCC5946),
                                      size: 30,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 18),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width / 4,
                                child: Center(
                                  child: FutureBuilder(
                                    future: MyPetController.getPet(),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData &&
                                          snapshot.data!.isNotEmpty) {
                                        List<MyPet> pets = snapshot.data!;

                                        return ListView.builder(
                                            itemCount: pets.length,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 20.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    pets[index].imagePath ==
                                                            null
                                                        ? Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  Colors.white,
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                6,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                6,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Icon(
                                                                  Icons.pets,
                                                                  color: const Color(
                                                                      0xffCC5946),
                                                                  size: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      14,
                                                                ),
                                                                Text(
                                                                  "No Photo",
                                                                  style:
                                                                      TextStyle(
                                                                    color: const Color(
                                                                        0xffCC5946),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize: MediaQuery.of(context)
                                                                            .size
                                                                            .width /
                                                                        40,
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        : ClipOval(
                                                            child:
                                                                Image.network(
                                                              "$urlIp${pets[index].imagePath!}",
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  6,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  6,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                    SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              35,
                                                    ),
                                                    Text(
                                                      pets[index].name,
                                                      style: TextStyle(
                                                          height: 1,
                                                          fontSize: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              23,
                                                          color: const Color
                                                              .fromARGB(
                                                              255, 181, 73, 54),
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    )
                                                  ],
                                                ),
                                              );
                                            });
                                      } else if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Text("Loading data");
                                      } else if (snapshot.data!.isEmpty) {
                                        return const Center(
                                          child: Text("You dont add pet yet"),
                                        );
                                      } else {
                                        return const SizedBox();
                                      }
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Check this out!",
                                style: TextStyle(
                                    color: Color(0xff704520),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 26),
                              ),
                              Text(
                                "Trending Topic",
                                style: TextStyle(
                                  color: Color(0xff704520),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ForumPage()),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        174, 253, 178, 132),
                                    borderRadius: BorderRadius.circular(50)),
                                child: const Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Icon(Icons.chevron_right_rounded,
                                      color: Color(0xff704520), size: 50),
                                ),
                              ))
                        ],
                      ),
                    ),
                    FutureBuilder(
                      future: DiscussionController.getDiscussion(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                          List<DiscussionPost> discussion = snapshot.data!;
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: discussion.take(3).length,
                            itemBuilder: (context, index) {
                              return InkWell(
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
                                                      ? Container(
                                                          height: 50.0,
                                                          width: 50.0,
                                                          decoration: const BoxDecoration(
                                                              color:
                                                                  Colors.blue,
                                                              borderRadius: BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          50))),
                                                          child: CircleAvatar(
                                                            radius: 50,
                                                            backgroundImage:
                                                                CommentBox
                                                                    .commentImageParser(
                                                              imageURLorPath:
                                                                  NetworkImage(
                                                                      '$urlIp/${discussion[index].profilePictureUrl}'),
                                                            ),
                                                          ),
                                                        )
                                                      : Container(
                                                          decoration:
                                                              const BoxDecoration(
                                                            color: Colors.grey,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              10,
                                                          height: MediaQuery.of(
                                                                      context)
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
                                                                color: Colors
                                                                    .white,
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
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        discussion[index].name,
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      Text(
                                                        DateFormat(
                                                                "dd-MM-yyyy kk:mm")
                                                            .format(DateTime
                                                                .parse(discussion[
                                                                        index]
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
                                                        discussion[index]
                                                            .postId),
                                                builder: (context, snapshot) {
                                                  if (snapshot.hasData) {
                                                    return InkWell(
                                                      onTap: () {
                                                        snapshot.data!
                                                            ? DiscussionController
                                                                    .deleteBookmark(
                                                                        discussion[index]
                                                                            .postId,
                                                                        context)
                                                                .then((value) {
                                                                setState(() {});
                                                              })
                                                            : DiscussionController
                                                                    .addBookmark(
                                                                        discussion[index]
                                                                            .postId,
                                                                        context)
                                                                .then((value) {
                                                                setState(() {});
                                                              });
                                                      },
                                                      child: Icon(
                                                        Icons.bookmark,
                                                        color: snapshot.data!
                                                            ? const Color
                                                                .fromARGB(255,
                                                                193, 130, 125)
                                                            : const Color
                                                                .fromARGB(77,
                                                                224, 186, 181),
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
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            child: ListView.builder(
                                                shrinkWrap: true,
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemCount: discussion[index]
                                                    .imageUrl!
                                                    .length,
                                                itemBuilder: (context, index2) {
                                                  return Padding(
                                                    padding: EdgeInsets.only(
                                                        right:
                                                            deviceWidth / 20),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(
                                                            deviceWidth / 40),
                                                      ),
                                                      child: Image.network(
                                                        "$urlIp${discussion[index].imageUrl![index2]['image_path']}",
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            4,
                                                        height: MediaQuery.of(
                                                                    context)
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
                                                        .getLiked(
                                                            discussion[index]
                                                                .postId),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot.hasData) {
                                                        return InkWell(
                                                          onTap: () {
                                                            snapshot.data!
                                                                ? DiscussionController.dislike(
                                                                        discussion[index]
                                                                            .postId,
                                                                        context)
                                                                    .then(
                                                                        (value) {
                                                                    setState(
                                                                        () {});
                                                                  })
                                                                : DiscussionController.addLike(
                                                                        discussion[index]
                                                                            .postId,
                                                                        context)
                                                                    .then(
                                                                        (value) {
                                                                    setState(
                                                                        () {});
                                                                  });
                                                          },
                                                          child: Icon(
                                                            Icons.favorite,
                                                            color: snapshot
                                                                    .data!
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
                                                    style: const TextStyle(
                                                        fontSize: 12),
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
                              );
                            },
                          );
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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

                    // for (int index = 0;
                    //     index < topDiscussions.take(3).length;
                    //     index++)
                    //   GestureDetector(
                    //     onTap: () {
                    //       Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //           builder: (context) => CommentPage(
                    //             forumData: topDiscussions[index],
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //     child: Card(
                    //       color: Colors.white,
                    //       surfaceTintColor: Colors.white,
                    //       shadowColor: Colors.transparent,
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(14.0),
                    //         child: Column(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Row(
                    //                   children: [
                    //                     SvgPicture.asset(
                    //                       topDiscussions[index].profilePictureUrl,
                    //                       width: 50,
                    //                     ),
                    //                     SizedBox(width: 8),
                    //                     Column(
                    //                       crossAxisAlignment:
                    //                           CrossAxisAlignment.start,
                    //                       children: [
                    //                         Text(
                    //                           topDiscussions[index].name,
                    //                           style: TextStyle(
                    //                               fontSize: 16,
                    //                               fontWeight: FontWeight.w600),
                    //                         ),
                    //                         Text(
                    //                           topDiscussions[index].createdAt,
                    //                           style: TextStyle(
                    //                               fontSize: 11, height: 1),
                    //                         ),
                    //                       ],
                    //                     )
                    //                   ],
                    //                 ),
                    //               ],
                    //             ),
                    //             SizedBox(height: 14),
                    //             Text(
                    //               topDiscussions[index].title,
                    //               style: TextStyle(
                    //                   fontSize: 16,
                    //                   fontWeight: FontWeight.w600,
                    //                   height: 1.2),
                    //             ),
                    //             SizedBox(height: 6),
                    //             Text(
                    //               topDiscussions[index].description,
                    //               style: TextStyle(fontSize: 13, height: 1.25),
                    //               maxLines: 2,
                    //               overflow: TextOverflow.ellipsis,
                    //             ),
                    //             SizedBox(height: 20),
                    //             Row(
                    //               mainAxisAlignment:
                    //                   MainAxisAlignment.spaceBetween,
                    //               children: [
                    //                 Row(
                    //                   children: [
                    //                     Icon(
                    //                       Icons.favorite,
                    //                       color: Color(0xffCC5946),
                    //                       size: 20,
                    //                     ),
                    //                     SizedBox(width: 4),
                    //                     Text(
                    //                       "${topDiscussions[index].likesCount} likes",
                    //                       style: TextStyle(fontSize: 12),
                    //                     )
                    //                   ],
                    //                 ),
                    //                 Text(
                    //                   "Baca selengkapnya",
                    //                   style: TextStyle(
                    //                       fontStyle: FontStyle.italic,
                    //                       fontSize: 12,
                    //                       color:
                    //                           Color.fromARGB(255, 180, 123, 115)),
                    //                 )
                    //               ],
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // SizedBox(height: 40),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForumPage()),
                        );
                      },
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "More Discussion",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFFAE918D),
                                fontWeight: FontWeight.w600),
                          ),
                          Icon(Icons.arrow_forward_ios_rounded,
                              size: 14, color: Color(0xFFAE918D))
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SvgPicture.asset(
                      'assets/logopaw.svg',
                      width: 50,
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
          viewPhoto
              ? Container(
                  width: deviceWidth,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    color: Colors.black,
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: FutureBuilder(
                        future: SharedPreferences.getInstance(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ClipOval(
                                    child: Image.network(
                                  '$urlIp/storage/${snapshot.data!.getString('image')!}',
                                  width: deviceWidth / 1.2,
                                  height: deviceWidth / 1.2,
                                  fit: BoxFit.cover,
                                )),
                                SizedBox(
                                  height: deviceWidth / 5,
                                ),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xffCC5946),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        viewPhoto = false;
                                      });
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        "Back",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: Color(0xffFFF2DE)),
                                      ),
                                    ))
                              ],
                            );
                          } else {
                            return const SizedBox();
                          }
                        }),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
