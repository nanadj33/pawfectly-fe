import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_tag_editor/tag_editor.dart';
import 'package:pawfectly/constants/discussion_post_data.dart';
import 'package:pawfectly/controllers/discussion_controller.dart';

class TagFormField extends StatelessWidget {
  const TagFormField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(14)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 10),
          child: TextFormField(
            maxLines: 1,
            decoration: const InputDecoration(border: InputBorder.none),
          ),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final ValueChanged<int> onDeleted;
  final int index;
  const _Chip({
    required this.label,
    required this.onDeleted,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      labelPadding: const EdgeInsets.only(left: 8.0),
      label: Text(label),
      deleteIcon: const Icon(
        Icons.close,
        size: 18,
      ),
      onDeleted: () {
        onDeleted(index);
      },
    );
  }
}

class AddDiscussionPage extends StatefulWidget {
  const AddDiscussionPage({super.key});

  @override
  _AddDiscussionPageState createState() => _AddDiscussionPageState();
}

class _AddDiscussionPageState extends State<AddDiscussionPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  TextEditingController tagsController = TextEditingController();

  List<String> tagsValues = [];

  onDelete(index) {
    setState(() {
      tagsValues.removeAt(index);
    });
  }

  final ImagePicker imgpicker = ImagePicker();
  List<XFile> imagefiles = [];
  List<File> fileList = [];

  getImage() async {
    try {
      var pickedfiles = await imgpicker.pickMultiImage(imageQuality: 50);
      if (pickedfiles != []) {
        for (var i = 0; i < pickedfiles.length; i++) {
          imagefiles.add(XFile(pickedfiles[i].path));
          fileList.add(File(imagefiles[i].path));
        }
        print(fileList.toString());
        setState(() {});
      } else {
        print("No image is selected.");
      }
    } catch (e) {
      print("error while picking file.");
    }
  }

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffFCF2F1),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffFCF2F1),
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
          "what's up?",
          style: TextStyle(
            fontSize: deviceWidth / 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xff4C4C4C),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DiscussionController.addDiscussion(
              DiscussionPostForm(
                title: titleController.text,
                description: contentController.text,
                imagePath: fileList,
                tags: tagsValues,
              ),
              context);
        },
        child: SvgPicture.asset(
          'assets/forumsend.svg',
          width: 100,
          height: 100,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 4.0),
                  child: TextFormField(
                    maxLines: 1,
                    controller: titleController,
                    decoration: const InputDecoration(border: InputBorder.none),
                    keyboardType: TextInputType.multiline,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 4.0),
                  child: TextFormField(
                    maxLines: 3,
                    controller: contentController,
                    decoration: const InputDecoration(border: InputBorder.none),
                    keyboardType: TextInputType.multiline,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Attachment(s)",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (imagefiles.isNotEmpty)
                SizedBox(
                  height: 100,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: imagefiles.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(
                          File(imagefiles[index].path),
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      await getImage();
                    },
                    child: Container(
                      height: 90,
                      width: 90,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: const Color(0xffFAE3E0),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.add_a_photo_rounded,
                          color: Color(0xffE0BAB5),
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        imagefiles.clear();
                        setState(() {});
                      },
                      child: Text(
                        "Clear All",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: deviceWidth / 30,
                        ),
                      ))
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "Tag(s)",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              // Menambahkan semua tagFields ke dalam list

              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TagEditor(
                  length: tagsValues.length,
                  delimiters: const [',', ' '],
                  hasAddButton: true,
                  inputDecoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Separate with comma',
                  ),
                  onTagChanged: (newValue) {
                    setState(() {
                      tagsValues.add(newValue);
                    });
                  },
                  tagBuilder: (context, index) => _Chip(
                    index: index,
                    label: tagsValues[index],
                    onDeleted: onDelete,
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
