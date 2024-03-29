// Import lib modules
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ressources_relationnelles/api/http_service_resource.dart';
import 'package:ressources_relationnelles/models/models.dart';
import 'package:ressources_relationnelles/ui/resources/resource_creation.dart';
import 'package:ressources_relationnelles/ui/resources/resource_detail.dart';
import 'package:ressources_relationnelles/utils/utils.dart';
import 'package:ressources_relationnelles/widgets/widgets.dart';
// Import pages
import 'page_login.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}



class _SearchPageState extends State<SearchPage> {
  Screen size;
  int _selectedIndex = 1;

  List<Resource> premiumList =  List();
  List<Resource> featuredList =  List();
  var categoriesList = ["Categorie1", "Categorie2", "Categorie3 ", "Categorie4","Categorie5","Categorie6","Categorie7","Categorie18"];

  @override
  void initState() {
    // TODO: implement initState
    final HTTPServiceResource httpService = new HTTPServiceResource();

    httpService.getTopLikeResources().then((value) async{
      value.toList().forEach((element) {

          List images = [
            "feature_1.jpg",
            "feature_2.jpg",
            "feature_3.jpg",
            "hall_1.jpg",
            "hall_2.jpeg",
          ];

          var rn = new Random();
          String img = images[rn.nextInt(images.length)];

          premiumList
            ..add(Resource(id: element.id, resourceName:element.title, resourceDesc:element.content, image:img, resourceRelation:"Public"));
      });
      setState(() {});
    });

    httpService.getTopViewsResources().then((value) async{
       value.toList().forEach((element) {

          List images = [
            "feature_1.jpg",
            "feature_2.jpg",
            "feature_3.jpg",
            "hall_1.jpg",
            "hall_2.jpeg",
          ];

          var rn = new Random();
          String img = images[rn.nextInt(images.length)];

          featuredList
            ..add(Resource(id: element.id, resourceName:element.title, resourceDesc:element.content, image:img, resourceRelation:"Public"));
      });

       setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: AnnotatedRegion(
        value: SystemUiOverlayStyle(
            statusBarColor: backgroundColor,
            statusBarBrightness: Brightness.dark,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: backgroundColor),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[upperPart()],
            ),
          ),
        ),
      ),
    );
  }

  Widget upperPart() {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: UpperClipper(),
          child: Container(
            height: size.getWidthPx(240),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [colorCurve, colorCurveSecondary],
              ),
            ),
          ),
        ),
        Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: size.getWidthPx(36)),
              child: Column(
                children: <Widget>[
                  titleWidget(),
                  SizedBox(height: size.getWidthPx(10)),
                  createRessourceButton(),
                  _loginButtonWidget(),
                ],
              ),
            ),
            leftAlignText(
                text: "Tendances du moment",
                leftPadding: size.getWidthPx(16),
                textColor: textPrimaryColor,
                fontSize: 16.0),
            HorizontalList(
              children: <Widget>[
                for (int i = 0; i < premiumList.length; i++)
                  resourceCard(premiumList.toList()[i])

              ],
            ),
            leftAlignText(
                text: "Ressources les plus consultees",
                leftPadding: size.getWidthPx(16),
                textColor: textPrimaryColor,
                fontSize: 16.0
            ),
            HorizontalList(
              children: <Widget>[
                for (int i = 0; i < featuredList.length; i++)
                  resourceCard(featuredList.toList()[i])

              ],
            ),
          ],
        ),
      ],
    );
  }

  Text titleWidget() {
    return Text("Explorer les ressources\net partagez votre experience",
        style: TextStyle(
            fontFamily: 'Exo2',
            fontSize: 24.0,
            fontWeight: FontWeight.w900,
            color: Colors.white));
  }

  Container createRessourceButton()
  {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: size.getWidthPx(20), horizontal: size.getWidthPx(16)),
      width: size.getWidthPx(200),
      child: RaisedButton(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        padding: EdgeInsets.all(size.getWidthPx(5)),
        child: Text(
          "Créer une ressource",
          style: TextStyle(fontFamily: 'Exo2',color: Colors.white, fontSize: 20.0),
          textAlign: TextAlign.center,
        ),
        color: colorCurve,
        onPressed: () {
          // Going to Login page
          Navigator.push(context, MaterialPageRoute(builder: (context) => ResourceCreation('Test Post')));
        },
      ),
    );
  }

  Card upperBoxCard() {
    return Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: EdgeInsets.symmetric(
            horizontal: size.getWidthPx(20), vertical: size.getWidthPx(16)),
        borderOnForeground: true,
        child: Container(
          height: size.getWidthPx(150),
          child: Column(
            children: <Widget>[
              // _searchWidget(),
              leftAlignText(
                  text: "Top categories :",
                  leftPadding: size.getWidthPx(16),
                  textColor: textPrimaryColor,
                  fontSize: 16.0),
              HorizontalList(
                children: <Widget>[
                  for(int i=0;i<categoriesList.length;i++)
                    buildChoiceChip(i, categoriesList[i])
                ],
              ),
            ],
          ),
        ));
  }

  BoxField _searchWidget() {
    return BoxField(
        controller: TextEditingController(),
        focusNode: FocusNode(),
        hintText: "Chercher par terme, categorie ou relation",
        lableText: "Rechercher...",
        obscureText: false,
        onSaved: (String val) {},
        icon: Icons.search,
        iconColor: colorCurve);
  }

  Container _loginButtonWidget() {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: size.getWidthPx(20), horizontal: size.getWidthPx(16)),
      width: size.getWidthPx(200),
      child: RaisedButton(
        elevation: 8.0,
        shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0)),
        padding: EdgeInsets.all(size.getWidthPx(5)),
        child: Text(
          "JE ME CONNECTE",
          style: TextStyle(fontFamily: 'Exo2',color: Colors.white, fontSize: 20.0),
          textAlign: TextAlign.center,
        ),
        color: colorCurve,
        onPressed: () {
          // Going to Login page
          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
        },
      ),
    );
  }

  Padding leftAlignText({text, leftPadding, textColor, fontSize, fontWeight}) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(text??"",
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontFamily: 'Exo2',
                fontSize: fontSize,
                fontWeight: fontWeight ?? FontWeight.w500,
                color: textColor)),
      ),
    );
  }

  Card resourceCard(Resource property) {
    return Card(
        elevation: 4.0,
        margin: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        borderOnForeground: true,
        child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ResourceDetail(property.id, property.resourceName)));
            },
            child: Container(
              height: size.getWidthPx(150),
              width: size.getWidthPx(170),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0)),
                      child: Image.asset('assets/${property.image}',
                          fit: BoxFit.fill)),
                  SizedBox(height: size.getWidthPx(8)),
                  leftAlignText(
                      text: property.resourceName,
                      leftPadding: size.getWidthPx(8),
                      textColor: colorCurve,
                      fontSize: 14.0),
                  leftAlignText(
                      text: "Description",
                      leftPadding: size.getWidthPx(8),
                      textColor: Colors.black54,
                      fontSize: 12.0),
                  SizedBox(height: size.getWidthPx(4)),
                  leftAlignText(
                      text: property.resourceRelation,
                      leftPadding: size.getWidthPx(8),
                      textColor: colorCurve,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w800),
                ],
            ))));
  }

  Padding buildChoiceChip(index, chipName) {
    return Padding(
      padding: EdgeInsets.only(left: size.getWidthPx(8)),
      child: ChoiceChip(
        backgroundColor: backgroundColor,
        selectedColor: colorCurve,
        labelStyle: TextStyle(
            fontFamily: 'Exo2',
            color:
                (_selectedIndex == index) ? backgroundColor : textPrimaryColor),
        elevation: 4.0,
        padding: EdgeInsets.symmetric(
            vertical: size.getWidthPx(4), horizontal: size.getWidthPx(12)),
        selected: (_selectedIndex == index) ? true : false,
        label: Text(chipName),
        onSelected: (selected) {
          if (selected) {
            setState(() {
              _selectedIndex = index;
            });
          }
        },
      ),
    );
  }

}



