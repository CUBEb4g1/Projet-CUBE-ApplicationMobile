import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:flutter/foundation.dart';

class HTTPServiceResource {
  Future<List<Resources>> getTopLikeResources() async {
    Response res = await get("https://ressources-relationnelles.rayformatics.fr/api/resources/top/like");

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Resources> resources = body
          .map(
            (dynamic item) => Resources.fromJson(item),
      )
          .toList();

      return resources;
    } else {
      throw "Can't get resources.";
    }
  }

  Future<List<Resources>> getTopViewsResources() async {
    Response res = await get("https://ressources-relationnelles.rayformatics.fr/api/resources/top/views");

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<Resources> resources = body
          .map(
            (dynamic item) => Resources.fromJson(item),
      )
          .toList();

      return resources;
    } else {
      throw "Can't get resources.";
    }
  }
  Future<FullResources> getDetailledResource(int id) async {

    final response = await get('https://ressources-relationnelles.rayformatics.fr/api/resources/$id');

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return FullResources.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<Map> createResource (String title, String content) async {
    String url = "https://ressources-relationnelles.rayformatics.fr/api/resources/create";
    final response = await post(
        url,
        headers: {"Accept": "application/json", "Content-Type": "application/json"},
        body: jsonEncode({'title': title, 'content': content}),
    );

    if (response.statusCode == 200) {
      Map json = jsonDecode(response.body);
      return json;
    }


  }
}

class Resources {
  final int id;
  final String title;
  final String content;

  Resources({
    @required this.id,
    @required this.title,
    @required this.content,
  });

  factory Resources.fromJson(Map<String, dynamic> json) {

    return Resources(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
    );
  }
}

class FullResources {
  final int id;
  final String title;
  final String content;
  final int user_id;
  final int visibility;
  final bool validated;
  final bool deleted;
  final int views;
  final String username;
  final String createdat;

  FullResources({
    @required this.id,
    @required this.title,
    @required this.content,
    @required this.user_id,
    @required this.visibility,
    @required this.validated,
    @required this.deleted,
    @required this.views,
    @required this.username,
    @required this.createdat,
  });

  factory FullResources.fromJson(Map<String, dynamic> json) {

    return FullResources(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      user_id: json['user_id'] as int,
      visibility: json['visibility'] as int,
      validated: json['validated'] as bool,
      deleted: json['deleted'] as bool,
      views: json['views'] as int,
      createdat: json['created_at'],
      username: json['user']['username'] as String,
    );
  }
}
