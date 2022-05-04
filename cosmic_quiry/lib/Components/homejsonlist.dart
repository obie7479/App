import 'dart:convert';

import 'package:cosmic_quiry/Model/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:http/http.dart' as http;

class JSONListView extends StatefulWidget {
  CustomJSONListView createState() => CustomJSONListView();
}

class CustomJSONListView extends State {
  final String apiURL = 'https://blogcq.herokuapp.com/api/home/blogs';

  Future<List<Homeblogs>> fetchJSONData() async {
    var jsonResponse = await http.get(Uri.parse(apiURL));

    if (jsonResponse.statusCode == 200) {
      final jsonItems =
          json.decode(jsonResponse.body).cast<Map<String, dynamic>>();

      List<Homeblogs> usersList = await jsonItems.map<Homeblogs>((json) {
        return Homeblogs.fromJson(json);
      }).toList();
      return usersList;
    } else {
      throw Exception('Failed to load data from internet');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      child: FutureBuilder<List<Homeblogs>>(
        future: fetchJSONData(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          return ListView(
            children: snapshot.data!.map((user) {
              Blogs b = user.blogs[0];
              return Column(
                children: [
                  ListTile(
                    title: Html(data: "${b.title}"),
                    // title: Text(b.title),
                    onTap: () {},
                  ),
                  // Text(b.content),
                  // Text(b.description),
                  Html(data: "${b.content}"),
                  Html(data: "${b.description}"),
                  Image.network(b.thumbnail)
                ],
              );
            }).toList(),
          );
        },
      ),
      onRefresh: fetchJSONData,
    ));
  }
  void initState() {
    JSONListView();
    super.initState();
  }
}
