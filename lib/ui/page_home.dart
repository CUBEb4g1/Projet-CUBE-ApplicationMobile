// Import lib modules
import 'package:flutter/material.dart';
import 'package:ressources_relationnelles/ui/page_search.dart';
import 'package:ressources_relationnelles/widgets/widgets.dart';
// Import pages
import '../main.dart';
import 'page_coming_soon.dart';
import 'page_login.dart';
import 'page_profile.dart';
import 'page_settings.dart';
import 'page_signup.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  int currentTab = 0;
  PageController pageController;

  _changeCurrentTab(int tab) {
    //Changing tabs from BottomNavigationBar
    setState(() {
      currentTab = tab;
      pageController.jumpToPage(0);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: bodyView(currentTab),
          bottomNavigationBar: BottomNavBar(changeCurrentTab: _changeCurrentTab)),
    );
  }

  bodyView(currentTab) {
    List<Widget> tabView = [];
    // Current Tabs in Home Screen...
    switch (currentTab) {
      case 0:
      // Home page
        tabView = [SearchPage()];
        break;
      case 1:
      // Incoming functionnality page
        tabView = [PageComingSoon()];
        break;
      case 2:
      // User profile page
        tabView = [ProfilePage()];
        break;
      case 3:
      // Settings page
        tabView = [SettingPage()];
        break;
    }
    return PageView(controller: pageController, children: tabView);
  }
}