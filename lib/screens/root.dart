import 'package:flutter/material.dart';
import 'package:stedom/screens/home/home_screen.dart';
import 'package:stedom/utils/app_config.dart';
import 'package:stedom/utils/colors.dart';
import 'package:stedom/utils/constants.dart';

class Root extends StatefulWidget {
  const Root({Key? key}) : super(key: key);

  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedFontSize: SizeConfig.safeBlockHorizontal! * 3.0,
        unselectedFontSize: SizeConfig.safeBlockHorizontal! * 3.0,
        selectedLabelStyle: const TextStyle(color: primaryColor),
        unselectedLabelStyle: const TextStyle(color: blackPrimary),
        selectedItemColor: blackPrimary,
        currentIndex: _currentIndex,
        elevation: 0.0,
        onTap: onTabTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: whitePrimary,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Image.asset(
                AvailableImages.homeIcon["assetPath"] as String,
                height: SizeConfig.safeBlockVertical! * 3.0,
              ),
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon:Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Image.asset(
                AvailableImages.bookIcon["assetPath"] as String,
                height: SizeConfig.safeBlockVertical! * 3.0,
              ),
            ),
            label: "Learn",
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Image.asset(
                AvailableImages.profileIcon["assetPath"] as String,
                height: SizeConfig.safeBlockVertical! * 3,
              ),
            ),
            label: "Profile",
          ),
        ],
      ),
      body: [
        const HomeScreen(),
        const HomeScreen(),
        const HomeScreen(),
      ][_currentIndex],
    );
  }
}
