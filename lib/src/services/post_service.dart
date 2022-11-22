import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:owl_test/src/config/base_url.dart';
import 'package:owl_test/src/config/endpoint_url.dart';
import 'package:owl_test/src/models/post_model.dart';

class PostService {
  static Future savePost(Map<String, dynamic> postMap) async {
    try {
      final response = await http.post(
          Uri.parse(BaseUrl.baseUrl + EndpointUrl.saveAndGetPosts),
          body: json.encode(postMap));

      if (response.statusCode == 201) {
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<List<PostModel>> getAllPosts() async {
    List<PostModel> allPosts = [];

    final response = await http
        .get(Uri.parse(BaseUrl.baseUrl + EndpointUrl.saveAndGetPosts));

    final postResult = json.decode(response.body);

    for (int i = 0; i < postResult.length; i++) {
      var dataPost = PostModel(
          id: postResult[i]["id"],
          title: postResult[i]["title"],
          content: postResult[i]["content"]);

      allPosts.add(dataPost);
    }

    return allPosts;
  }
}
