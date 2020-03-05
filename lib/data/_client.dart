import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:infinite_list_flutter_app/data/post.dart';

class PostClient {
  Future<List<Post>> fetchPosts(int startIndex, int limit) async {
    final String baseUrl =
        'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit';

    final result = await http.get(baseUrl);
    print(result.body);
    if (result.statusCode == 200) {
      print(result.statusCode);
      return postFromJson(result.body);
    } else {
      throw Exception('error fetching posts');
    }
  }
}
