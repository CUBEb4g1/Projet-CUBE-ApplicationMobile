import 'package:flutter/material.dart';
import 'package:ressources_relationnelles/api/http_service_resource.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ressources_relationnelles/main.dart';
import 'package:ressources_relationnelles/utils/colors.dart';
import 'package:html_editor/html_editor.dart';


class ResourceCreation extends StatefulWidget {
  final String title;

  ResourceCreation(this.title);


  @override
  _ResourceCreation createState() => _ResourceCreation(this.title);
}


class _ResourceCreation extends State<ResourceCreation> {
  final String title;
  final HTTPServiceResource httpService = new HTTPServiceResource();

  _ResourceCreation(this.title);
  GlobalKey<HtmlEditorState> keyEditor = GlobalKey();
  String result = "";
  Future<Map> json = null;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              HtmlEditor(
                hint: "Créez votre ressource !",
                //value: "text content initial, if any",
                key: keyEditor,
                height: 400,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.blueGrey,
                      onPressed: (){
                        setState(() {
                          keyEditor.currentState.setEmpty();
                        });
                      },
                      child: Text("Reset", style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(width: 16,),
                    FlatButton(
                      color: Colors.blue,
                      onPressed: () async {
                        final txt = await keyEditor.currentState.getText();
                        setState(() {
                          result = txt;
                        });
                        json = httpService.createResource('Test Appli', result);
                        if(json != null)
                          {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));
                          }

                      },
                      child: Text("Submit", style: TextStyle(color: Colors.white),),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}