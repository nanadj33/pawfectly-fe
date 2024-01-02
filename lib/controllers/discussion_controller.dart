import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:pawfectly/constants/constants.dart';
import 'package:pawfectly/constants/discussion_data.dart';
import 'package:pawfectly/constants/discussion_post_data.dart';
import 'package:pawfectly/constants/replies_data.dart';
import 'package:pawfectly/controllers/encrypt_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiscussionController {
  static Future<List<DiscussionPost>> getDiscussion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      final dio = Dio();
      final response = await dio.get(
        '${url}posts',
        options: Options(
          headers: {
            "Authorization": "Bearer ${decryptMyData(token!)}",
            "Accept": "application/json",
          },
        ),
      );
      List json = response.data['data'];
      return json.map((e) => DiscussionPost.fromJson(e)).toList();
    } catch (e) {
      print("Error Get Dis: $e");
    }
    return [];
  }

  static Future<List<DiscussionPost>> getSavedDiscussion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var id = prefs.getString('id');
    try {
      final dio = Dio();
      final response = await dio.get(
        '${url}user/post/bookmarks/$id',
        options: Options(
          headers: {
            "Authorization": "Bearer ${decryptMyData(token!)}",
            "Accept": "application/json",
          },
        ),
      );
      List json = response.data['data'];
      return json.map((e) => DiscussionPost.fromJson(e)).toList();
    } catch (e) {
      print("Error Get Dis: $e");
    }
    return [];
  }

  static Future<void> addDiscussion(
      DiscussionPostForm dataDiscussion, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    DiscussionPostForm newDis = dataDiscussion;

    List<d.MultipartFile> imageFiles = await Future.wait(newDis.imagePath!
        .map((e) async => await d.MultipartFile.fromFile(e.path)));
    d.FormData formData = d.FormData.fromMap({
      'user_id': prefs.getString('id') ?? '',
      'desc': newDis.description,
      'title': newDis.title,
      'tags[]': newDis.tags,
      'image_path[]': imageFiles,
    });

    print(imageFiles);
    try {
      final dio = d.Dio();
      final response = await dio.post(
        '${url}post',
        data: formData,
        options: d.Options(
          headers: {
            "Authorization": "Bearer ${decryptMyData(token!)}",
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 201) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Discussion posted successfully")));
      } else {
        const errorInfo = SnackBar(content: Text("Operation failed"));
        ScaffoldMessenger.of(context).showSnackBar(errorInfo);
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  static Future<void> updateDiscussion(
      DiscussionPostForm dataDiscussion, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    DiscussionPostForm newDis = dataDiscussion;

    var formData = {
      'desc': newDis.description,
      'title': newDis.title,
    };

    try {
      final dio = d.Dio();
      final response = await dio.post(
        '${url}post/update/${newDis.id}',
        data: formData,
        options: d.Options(
          headers: {
            "Authorization": "Bearer ${decryptMyData(token!)}",
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        Navigator.pop(context);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Discussion updated successfully")));
      } else {
        const errorInfo = SnackBar(content: Text("Operation failed"));
        ScaffoldMessenger.of(context).showSnackBar(errorInfo);
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  static Future<List<Replies>> getReplies(postId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      final dio = Dio();
      final response = await dio.get(
        '${url}post/$postId/replies',
        options: Options(
          headers: {
            "Authorization": "Bearer ${decryptMyData(token!)}",
            "Accept": "application/json",
          },
        ),
      );
      List json = response.data['data'];
      debugPrint(json.toString());

      return json.map((e) => Replies.fromJson(e)).toList();
    } catch (e) {
      print("Error Get Replis: $e");
    }
    return [];
  }

  static Future<void> addReplies(Replies replies, postId, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    Replies newRep = replies;

    var formData = {
      'user_id': int.parse(prefs.getString('id')!),
      'desc': newRep.description,
    };

    try {
      final dio = d.Dio();
      final response = await dio.post(
        '${url}post/$postId/reply',
        data: formData,
        options: d.Options(
          headers: {
            "Authorization": "Bearer ${decryptMyData(token!)}",
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
      } else {
        const errorInfo = SnackBar(content: Text("Operation failed"));
        ScaffoldMessenger.of(context).showSnackBar(errorInfo);
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  static Future<void> addLike(int postId, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var formData = {
      'user_id': int.parse(prefs.getString('id')!),
    };

    try {
      final dio = d.Dio();
      final response = await dio.post(
        '${url}post/$postId/like',
        data: formData,
        options: d.Options(
          headers: {
            "Authorization": "Bearer ${decryptMyData(token!)}",
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Discussion liked")));
      } else {
        const errorInfo = SnackBar(content: Text("Operation failed"));
        ScaffoldMessenger.of(context).showSnackBar(errorInfo);
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  static Future<void> dislike(int postId, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var userId = prefs.getString('id');
    try {
      final dio = d.Dio();
      final response = await dio.delete(
        '${url}post/$postId/dislike/$userId',
        options: d.Options(
          headers: {
            "Authorization": "Bearer ${decryptMyData(token!)}",
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Discussion disliked")));
      } else {
        const errorInfo = SnackBar(content: Text("Operation failed"));
        ScaffoldMessenger.of(context).showSnackBar(errorInfo);
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  static Future<bool> getLiked(postId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    try {
      var id = prefs.getString('id') ?? '';

      final dio = Dio();
      final response = await dio.get(
        '${url}user/$id/post/liked',
        options: Options(
          headers: {
            "Authorization": "Bearer ${decryptMyData(token!)}",
            "Accept": "application/json",
          },
        ),
      );
      if (response.data["data"].contains(postId)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error Get Liked: $e");
    }
    return false;
  }

  static Future<void> addBookmark(int postId, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var formData = {
      'user_id': int.parse(prefs.getString('id')!),
      'post_id': postId,
    };

    try {
      final dio = d.Dio();
      final response = await dio.post(
        '${url}bookmark',
        data: formData,
        options: d.Options(
          headers: {
            "Authorization": "Bearer ${decryptMyData(token!)}",
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Bookmark successfully")));
      } else {
        const errorInfo = SnackBar(content: Text("Operation failed"));
        ScaffoldMessenger.of(context).showSnackBar(errorInfo);
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  static Future<void> deleteBookmark(int postId, context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var userId = prefs.getString('id');
    try {
      final dio = d.Dio();
      final response = await dio.delete(
        '${url}bookmark/$userId/$postId',
        options: d.Options(
          headers: {
            "Authorization": "Bearer ${decryptMyData(token!)}",
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Un-bookmark discussion successfully")));
      } else {
        const errorInfo = SnackBar(content: Text("Operation failed"));
        ScaffoldMessenger.of(context).showSnackBar(errorInfo);
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  static Future<bool> getBookmarked(postId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var id = prefs.getString('id');
    try {
      final dio = Dio();
      final response = await dio.get(
        '${url}user/post/bookmarks/ids/$id',
        options: Options(
          headers: {
            "Authorization": "Bearer ${decryptMyData(token!)}",
            "Accept": "application/json",
          },
        ),
      );
      if (response.data["data"].contains(postId)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error Get Bookmark: $e");
    }
    return false;
  }
}
