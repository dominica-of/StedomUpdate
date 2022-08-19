import 'package:flutter/material.dart';
import 'package:stedom/routes/routes.dart';
import 'package:stedom/utils/app_config.dart';
import 'package:stedom/utils/colors.dart';
import 'package:stedom/utils/constants.dart';

class WalkThroughScreen extends StatefulWidget {
  const WalkThroughScreen({Key? key}) : super(key: key);

  @override
  WalkThroughScreenState createState() => WalkThroughScreenState();
}

class WalkThroughScreenState extends State<WalkThroughScreen> {
  int slideIndex = 0;
  final PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void pageChange() {
    if (slideIndex == 2) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        welcomeViewRoute,
        (Route<dynamic> route) => false,
      );
    } else {
      _controller.animateToPage(
        slideIndex + 1,
        duration: const Duration(milliseconds: 250),
        curve: Curves.linearToEaseOut,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: (index) => setState(() => slideIndex = index),
        children: <Widget>[
          _pageBuilder(
              AvailableImages.walkThroughImg_1["assetPath"] as String,
              "Learning music, \nmade easy ",
              "Our app connects you to professional music tutors and provides you with all the tools needed to book their services."),
          _pageBuilder(
              AvailableImages.walkThroughImg_2["assetPath"] as String,
              "Make money\nteaching music",
              "We give music professionals the opportunity to make extra income tutoring and mentoring students in their convenience."),
          _pageBuilder(
              AvailableImages.walkThroughImg_3["assetPath"] as String,
              "Music resources\ntotally free",
              "Get access to a massive database of music scripts, song manuscripts, links to music resources and many more.")
        ],
      ),
    );
  }

  Widget _pageBuilder(String imagePath, String title, String content) {
    return Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.blockSizeVertical! * 40,
        left: SizeConfig.safeBlockHorizontal! * 5,
        right: SizeConfig.safeBlockHorizontal! * 5,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            imagePath,
            height: SizeConfig.blockSizeVertical! * 20,
            width: SizeConfig.blockSizeHorizontal! * 20,
          ),
          Padding(
            padding: EdgeInsets.only(
              bottom: SizeConfig.blockSizeVertical! * 2,
            ),
            child: Text(
              title,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontFamily: AvailableFonts.secondaryFont,
                color: blackPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 30,
                letterSpacing: 0.5,
              ),
            ),
          ),
          SizedBox(
            width: SizeConfig.blockSizeHorizontal! * 85,
            child: Text(
              content,
              textAlign: TextAlign.left,
              style: const TextStyle(
                fontFamily: AvailableFonts.secondaryFont,
                color: greyPrimary,
                fontWeight: FontWeight.w400,
                wordSpacing: 1.0,
                fontSize: 13,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: SizeConfig.blockSizeVertical! * 5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 6,
                  width: slideIndex != 2
                      ? SizeConfig.blockSizeHorizontal! * 45
                      : SizeConfig.blockSizeHorizontal! * 90,
                  child: Material(
                    borderRadius: BorderRadius.circular(5.0),
                    color: blackPrimary,
                    elevation: 5.0,
                    shadowColor: Colors.white70,
                    child: MaterialButton(
                      onPressed: () => pageChange(),
                      child: Text(
                        slideIndex == 2 ? 'Get Started' : "Next",
                        style: const TextStyle(
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w500,
                          fontFamily: AvailableFonts.secondaryFont,
                          fontSize: 15.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                slideIndex == 2
                    ? const SizedBox()
                    : TextButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              welcomeViewRoute,
                                  (Route<dynamic> route) => false,
                            ),
                        child: Row(
                          children: const [
                            Text(
                              'Skip',
                              style: TextStyle(
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w500,
                                fontFamily: AvailableFonts.secondaryFont,
                                fontSize: 11.0,
                                color: greyPrimary,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: greyPrimary,
                            )
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
