import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
        leading: InkWell(onTap: (){
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back, color: Color(0xff704520),)),
        title: Text("My Profile",style: TextStyle(color: Color(0xff704520), fontWeight: FontWeight.w600),),
        backgroundColor: Color(0xffFFF2DE)
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:40.0),
          child: Column(
            children: [
              Stack(
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/girl.jpg',
                      width: 120,
                    ),
                  ),
                  Positioned(bottom: 1, right: 1,child: Icon(Icons.add_a_photo, size: 40, color: Color(0xffCC5946),))
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal:8.0),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color(0xffFCC576)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset("assets/email.svg", width: 30, color: Color(0xffCC5946),),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text("reginaaa@gmail.com", style: TextStyle(fontSize: 16, color: Color(0xffCC5946), fontWeight: FontWeight.w600),),
                                  )
                                ],
                              ),
                              SvgPicture.asset("assets/pen.svg",
                              width: 24,)
                                            
                            ],
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color(0xffFCC576)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset("assets/email.svg", width: 30, color: Color(0xffCC5946),),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text("reginaaa@gmail.com", style: TextStyle(fontSize: 16, color: Color(0xffCC5946), fontWeight: FontWeight.w600),),
                                  )
                                ],
                              ),
                              SvgPicture.asset("assets/pen.svg",
                              width: 24,)
                                            
                            ],
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color(0xffFCC576)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset("assets/email.svg", width: 30, color: Color(0xffCC5946),),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text("reginaaa@gmail.com", style: TextStyle(fontSize: 16, color: Color(0xffCC5946), fontWeight: FontWeight.w600),),
                                  )
                                ],
                              ),
                              SvgPicture.asset("assets/pen.svg",
                              width: 24,)
                                            
                            ],
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Color(0xffFCC576)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset("assets/email.svg", width: 30, color: Color(0xffCC5946),),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text("reginaaa@gmail.com", style: TextStyle(fontSize: 16, color: Color(0xffCC5946), fontWeight: FontWeight.w600),),
                                  )
                                ],
                              ),
                              SvgPicture.asset("assets/pen.svg",
                              width: 24,)
                                            
                            ],
                          ),
                        ),
                      ),

                      
                    ],
                  ),
                ),
              )
              
            ],
          ),
        ),
      ),
    );
  }
  
}