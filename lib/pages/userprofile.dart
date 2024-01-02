import 'package:flutter/material.dart';
import 'package:pawfectly/constants/constants.dart';
import 'package:pawfectly/pages/userprofile_update.dart';
import 'package:pawfectly/widgets/info_container.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffFFF2DE),
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back, color: Color(0xff704520)),
        ),
        title: const Text(
          "My Profile",
          style:
              TextStyle(color: Color(0xff704520), fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xffFFF2DE),
      ),
      body: FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.center, // Center content vertically
                    children: [
                      Stack(
                        children: [
                          snapshot.data!.getString('image')! == 'null'
                              ? Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.grey,
                                    shape: BoxShape.circle,
                                  ),
                                  width: MediaQuery.of(context).size.width / 4,
                                  height: MediaQuery.of(context).size.width / 4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color: Colors.white,
                                        size:
                                            MediaQuery.of(context).size.width /
                                                10,
                                      ),
                                    ],
                                  ),
                                )
                              : ClipOval(
                                  child: Container(
                                    width: deviceWidth / 4,
                                    height: deviceWidth / 4,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Image.network(
                                      '$urlIp/storage/${snapshot.data!.getString('image')!}',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                          // const Positioned(
                          //   bottom: 1,
                          //   right: 1,
                          //   child: Icon(
                          //     Icons.add_a_photo,
                          //     size: 40,
                          //     color: Color(0xffCC5946),
                          //   ),
                          // )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 60),
                        child: Center(
                          child: Column(
                            children: [
                              buildInfoContainer("assets/email.svg",
                                  snapshot.data!.getString('email')!),
                              buildInfoContainer("assets/username.svg",
                                  snapshot.data!.getString('username')!),
                              buildInfoContainer("assets/id-card.svg",
                                  snapshot.data!.getString('name')!),
                              buildInfoContainer("assets/telephone-call.svg",
                                  snapshot.data!.getString('phone')!),
                              const SizedBox(height: 60),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xffCC5946),
                                  ),
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return UpdateUserProfile(
                                        email:
                                            snapshot.data!.getString('email')!,
                                        name: snapshot.data!.getString('name')!,
                                        username: snapshot.data!
                                            .getString('username')!,
                                        phone:
                                            snapshot.data!.getString('phone')!,
                                        imageUrl:
                                            snapshot.data!.getString('image')!,
                                      );
                                    })).then((value) {
                                      setState(() {});
                                    });
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Text(
                                      "Update Data",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xffFFF2DE)),
                                    ),
                                  ))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
