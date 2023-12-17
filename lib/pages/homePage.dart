import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pawfectly/constants/forumdata.dart';
import 'package:pawfectly/pages/chatApp.dart';
import 'package:pawfectly/pages/commentpage.dart';
import 'package:pawfectly/pages/forumpage.dart';
import 'package:pawfectly/pages/userprofile.dart';
import 'package:url_launcher/url_launcher.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<DiscussionForum> topDiscussions = [];

  @override
  void initState() {
    super.initState();
    topDiscussions = DiscussionForum.getcontent(); // Use the getcontent() method
    topDiscussions.sort((a, b) => b.likes.compareTo(a.likes));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCF2F1),
      appBar: AppBar(
        backgroundColor: Color(0xffFCF2F1),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(
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
        title: SvgPicture.asset('assets/pawfectly.svg', width: 120,),
        actions: [
          Icon(
            Icons.notifications_rounded,
            size: 30,
            color: Color(0xff704520),
          ),
          Padding(padding: EdgeInsets.only(right: 16))
        ],
        centerTitle: true,
      ),

      drawer: Drawer(
        child: Container(
          width: MediaQuery.of(context).size.width * 3 / 4, // 3/4 dari lebar layar
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              ListTile(
                leading: Icon(Icons.bookmark,
                color: Color(0xffE0BAB5),),
                title: Text('Saved Discussion',
                style: TextStyle(color: Color(0xffE0BAB5),),),
                onTap: () {
                  Navigator.pop(context); // close the drawer
                },
              ),
              Divider(
                indent: 18.0,
                endIndent: 18.0,
                thickness: 1.5,
                color: Color(0xffE0BAB5),
              ),
              ListTile(
                leading: Icon(Icons.settings_rounded,
                color: Color(0xffE0BAB5),),
                title: Text('Settings',
                style: TextStyle(
                  color: Color(0xffE0BAB5),
                ),),
                onTap: () {
                  // Handle going to settings
                  Navigator.pop(context); // close the drawer
                },
              ),
              Divider(
                indent: 18.0,
                endIndent: 18.0,
                thickness: 1.5,
                color: Color(0xffE0BAB5),
              ),
              ListTile(
                leading: Icon(Icons.logout_rounded,
                color: Color(0xffE0BAB5),),
                title: Text('Logout',
                style: TextStyle(
                  color: Color(0xffE0BAB5),
                ),),
                onTap: () {
                  // Handle logout
                  Navigator.pop(context); // close the drawer
                },
              ),
              Divider(
                indent: 18.0,
                endIndent: 18.0,
                thickness: 1.5,
                color: Color(0xffE0BAB5),
              ),
            ],
          ),
        ),
      ),

      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi,",
                            style: TextStyle(
                              color: Color(0xff704520),
                              fontSize: 18,
                              height: 0,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          Text(
                            "Regina!",
                            style: TextStyle(
                              color: Color(0xff704520),
                              fontSize: 30,
                              height: 0,
                              fontWeight: FontWeight.w900
                            ),
                          )
                        ],
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => UserProfile()),
                          );
                        },
                        child: ClipOval(
                          child: Image.asset(
                          'assets/girl.jpg',
                          width: 84,
                          ),
                        ),
                      ),
                      
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xffFDB384),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ChatScreen()),
                            );
                          },
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                'assets/onlineconsult.svg',
                                width: 60,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Online\nConsultation",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 12,
                                  color: Color(0xff704520),
                                  fontWeight: FontWeight.w400
                                  
                                ),
                              )
                            ],
                          ),
                        ),

                        InkWell(
                          onTap: ()async{
                              final Uri _url = Uri.parse('https://www.google.com/maps/search/klinik+hewan/@-6.1954543,106.8784504,15z/data=!3m1!4b1?entry=ttu');
                              if (!await launchUrl(_url)) {
                                throw Exception('Could not launch $_url');
                              }
                          },
                          child: Column(
                            children: [
                              SvgPicture.asset(
                                'assets/clinicfinder.svg',
                                width: 60,
                              ),
                              SizedBox(height: 6),
                              Text(
                                "Clinic Finder",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  height: 1,
                                  fontSize: 12,
                                  color: Color(0xff704520),
                                  fontWeight: FontWeight.w400
                                  
                                ),
                              )
                            ],
                          ),
                        ),

                        Column(
                          children: [
                            SvgPicture.asset(
                              'assets/petreport.svg',
                              width: 60,
                            ),
                            SizedBox(height: 6),
                            Text(
                              "Pet Report",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                height: 1,
                                fontSize: 12,
                                color: Color(0xff704520),
                                fontWeight: FontWeight.w400
                                
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xffF6CDC7)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "My Pets",
                              style: TextStyle(
                                height: 1,
                                fontSize: 18,
                                color: Color(0xFFCC5946),
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            Icon(Icons.add_circle_rounded,
                            color: Color(0xFFCC5946),
                            size: 30,)
                          ],
                        ),
                        SizedBox(height: 18),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                  'assets/mushroom.jpg',
                                  width: 80,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Mushroom",
                                  style: TextStyle(
                                    height: 1,
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 181, 73, 54),
                                    fontWeight: FontWeight.w400
                                  ),
                                )
                              ],
                            ),

                            Column(
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                  'assets/molly.jpg',
                                  width: 80,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Molly",
                                  style: TextStyle(
                                    height: 1,
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 181, 73, 54),
                                    fontWeight: FontWeight.w400
                                  ),
                                )
                              ],
                            ),

                            Column(
                              children: [
                                ClipOval(
                                  child: Image.asset(
                                  'assets/corgi.jpg',
                                  width: 80,
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  "Corgi",
                                  style: TextStyle(
                                    height: 1,
                                    fontSize: 14,
                                    color: Color.fromARGB(255, 181, 73, 54),
                                    fontWeight: FontWeight.w400
                                  ),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Check this out!",
                              style: TextStyle(
                                color: Color(0xff704520),
                                fontWeight: FontWeight.w700,
                                fontSize: 26
                              ),
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
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ForumPage()),
                          );

                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(174, 253, 178, 132),
                            borderRadius: BorderRadius.circular(50)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Icon(Icons.chevron_right_rounded,
                            color: Color(0xff704520), size: 50),
                          ),
                        )
                      )
                    ],
                  ),
                ),
                for (int index = 0; index < topDiscussions.take(3).length; index++)
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommentPage(
                            // forumData: topDiscussions[index],
                          ),
                        ),
                      );
                    },
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
                                      topDiscussions[index].pic,
                                      width: 50,
                                    ),
                                    SizedBox(width: 8),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          topDiscussions[index].name,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Text(
                                          topDiscussions[index].time,
                                          style: TextStyle(
                                              fontSize: 11, height: 1),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 14),
                            Text(
                              topDiscussions[index].title,
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2),
                            ),
                            SizedBox(height: 6),
                            Text(
                              topDiscussions[index].content,
                              style: TextStyle(
                                  fontSize: 13, height: 1.25),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.favorite,
                                      color: Color(0xffCC5946),
                                      size: 20,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${topDiscussions[index].likes} likes",
                                      style: TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                                Text(
                                  "Baca selengkapnya",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12,
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
                SizedBox(height: 40),
                InkWell(
                  onTap: (){
                    Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ForumPage()),
                          );
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "More Discussion",
                        style: TextStyle(
                          fontSize: 14,
                          color: Color(0xFFAE918D),
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 14,
                        color: Color(0xFFAE918D)
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                SvgPicture.asset(
                  'assets/logopaw.svg',
                  width: 50,
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
}