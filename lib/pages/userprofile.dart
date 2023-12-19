import 'package:flutter/material.dart';
import 'package:pawfectly/widgets/info_container.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFF2DE),
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back, color: Color(0xff704520)),
        ),
        title: Text(
          "My Profile",
          style: TextStyle(color: Color(0xff704520), fontWeight: FontWeight.w600),
        ),
        backgroundColor: Color(0xffFFF2DE),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
              children: [
                Stack(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/girl.jpg',
                        width: 120,
                      ),
                    ),
                    Positioned(
                      bottom: 1,
                      right: 1,
                      child: Icon(
                        Icons.add_a_photo,
                        size: 40,
                        color: Color(0xffCC5946),
                      ),
                    )
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 60),
                  child: Center(
                    child: Column(
                      children: [
                        buildInfoContainer("assets/email.svg", "reginaaa@gmail.com"),
                        buildInfoContainer("assets/username.svg", "Regina"),
                        buildInfoContainer("assets/id-card.svg", "Regina George"),
                        buildInfoContainer("assets/telephone-call.svg", "08123854768"),
                        SizedBox(height: 60),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xffCC5946),
                          ),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("Pawfect!",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xffFFF2DE)
                            ),),
                          ))
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
