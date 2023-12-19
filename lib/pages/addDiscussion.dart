import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pawfectly/widgets/tagformfield.dart';

class AddDiscussionPage extends StatefulWidget {
  @override
  _AddDiscussionPageState createState() => _AddDiscussionPageState();
}

class _AddDiscussionPageState extends State<AddDiscussionPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  List<Widget> tagFields = [];
  final ImagePicker _picker = ImagePicker();
  List<String> attachments = [];

  Future<void> _getImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        attachments.add(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCF2F1),
      appBar: AppBar(
        backgroundColor: Color(0xffFCF2F1),
        title: Text(
          "what's up?",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Title",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                  child: TextFormField(
                    maxLines: 2,
                    controller: titleController,
                    decoration: InputDecoration(border: InputBorder.none),
                    keyboardType: TextInputType.multiline,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Content",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                  child: TextFormField(
                    maxLines: null,
                    controller: contentController,
                    decoration: InputDecoration(border: InputBorder.none),
                    keyboardType: TextInputType.multiline,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Attachment(s)",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (attachments.isNotEmpty)
                Container(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: attachments.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(
                          File(attachments[index]),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              InkWell(
                onTap: () async {
                  await _getImageFromGallery();
                },
                child: Container(
                  height: 90,
                  width: 90,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: Color(0xffFAE3E0),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.add_a_photo_rounded,
                      color: Color(0xffE0BAB5),
                      size: 40,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Tag(s)",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              // Menambahkan semua tagFields ke dalam list
              ...tagFields,
              InkWell(
                onTap: () {
                  setState(() {
                    tagFields.add(TagFormField());
                  });
                },
                child: Container(
                  width: 200,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: Color(0xffFAE3E0),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Add new tag",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xffBF9089),
                                fontSize: 15),
                          ),
                          Icon(
                            Icons.add_circle_rounded,
                            color: Color(0xffBF9089),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              Center(
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    print('Button Clicked');
                  },
                  icon: SvgPicture.asset(
                    'assets/forumsend.svg',
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
