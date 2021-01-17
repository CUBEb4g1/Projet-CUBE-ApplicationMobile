import 'dart:convert';

import 'package:http/http.dart';
import 'package:flutter/foundation.dart';

class HttpService {
  Future<List<Resources>> getTopLikeResources() async {
    Response res = await get("http://ressources-relationnelles.rayformatics.fr/api/resources/top/like");

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
    Response res = await get("http://ressources-relationnelles.rayformatics.fr/api/resources/top/views");

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
