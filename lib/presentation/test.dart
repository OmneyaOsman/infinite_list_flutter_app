import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:infinite_list_flutter_app/data/_client.dart';
import 'package:infinite_list_flutter_app/data/post.dart';
import 'package:http/http.dart' as http;
import 'package:infinite_list_flutter_app/presentation/widget/post_widget.dart';

class RoutePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    appBar: AppBar(
    title: Text('Title'),
    ),
        body :Center(
        child: FutureBuilder(
          future: PostClient().fetchPosts(0, 20),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Center(
              child: snapshot.hasData
                  ? PostWidget( post :snapshot.data[0])
                  : CircularProgressIndicator(),
            );
          },
        ),
    )
    );
  }

   getPosts() async {
     try {
       final result = await InternetAddress.lookup('google.com');
       if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
         print('connected');
       }
     } on SocketException catch (_) {
       print('not connected');
     }
    final result = await http
        .get('https://jsonplaceholder.typicode.com/posts?_start=0&_limit=20');
     print(postFromJson(result.body)[0].toString());
    return postFromJson(result.body).toString();
  }

}
