import 'package:flutter/material.dart';
import 'package:ressources_relationnelles/api/http_service_resource.dart';
import 'package:flutter_html/flutter_html.dart';

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
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }
          ),
          title: Text(this.title),
        ),
        body: Card(
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
                  /* return ListTile(
                      title: Card(
                          margin: EdgeInsets.only(top:0, bottom: 10),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              snapshot.data.title,
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20
                              ),
                            ),
                          )
                      ),
                      subtitle: Html(data: snapshot.data.content),

                      contentPadding: EdgeInsets.only(bottom: 20.0),
                    ); */
                  return Column(
                      children: [
                        Card(
                          margin: EdgeInsets.only(top:0, bottom: 30),
                          child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                              snapshot.data.title,
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20
                              ),
                            ),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.only(top:0),
                          child: Html(data: snapshot.data.content),
                        ),
                        Card(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                snapshot.data.username,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                              Text(
                                snapshot.data.createdat,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 10,
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
      );
    }
}
