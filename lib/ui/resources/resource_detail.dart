import 'package:flutter/material.dart';
import 'package:ressources_relationnelles/api/http_service_resource.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ressources_relationnelles/utils/colors.dart';

class ResourceDetail extends StatefulWidget {
  final int id;
  final String title;
  ResourceDetail(this.id, this.title);

  @override
  _ResourceDetail createState() => _ResourceDetail(this.id, this.title);
}


class _ResourceDetail extends State<ResourceDetail> {

  final int resourceId;
  final String title;

  _ResourceDetail(this.resourceId, this.title);
  final HTTPServiceResource httpService = new HTTPServiceResource();

  @override

    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
              "Détail de la ressource",
              style: TextStyle(
                  fontFamily: "Exo2",
                  fontSize: 20,
                  color: backgroundColor)
          ),
          centerTitle: true,
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }
        ),
          backgroundColor: colorCurve,
        ),
        body: SingleChildScrollView(
           scrollDirection: Axis.vertical,
           child: Card(
            child: FutureBuilder(
              future: httpService.getDetailledResource(this.resourceId),
              builder: (BuildContext ctx, AsyncSnapshot snapshot){
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else {
                  return Column(
                      children: [
                        Container(
                           width: double.infinity,
                           decoration: new BoxDecoration(
                             gradient: new LinearGradient(
                               colors: [
                                 Color.fromRGBO(15, 175, 150, 1),
                                 Color.fromRGBO(99, 255, 150, 1)
                               ],
                             ),
                           ),
                           child: Card(
                              elevation: 0,
                              color: Colors.transparent,
                              child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                  snapshot.data.title,
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20
                                  ),
                                ),
                              ),
                            ),
                            margin: EdgeInsets.only(top:0, bottom: 10),
                        ),
                        Container(
                          margin: EdgeInsets.only(top:0),
                          child: Html(data: snapshot.data.content),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                         child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                snapshot.data.username,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                snapshot.data.createdat,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                  );
                }
        },
          )
        ),
        ),
      );
    }
}
