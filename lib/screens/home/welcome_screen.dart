import 'package:flutter/material.dart';
import 'package:stedom/routes/routes.dart';
import 'package:stedom/utils/app_config.dart';
import 'package:stedom/utils/colors.dart';
import 'package:stedom/utils/constants.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  WelcomeScreenState createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical! * 20,
          left: SizeConfig.safeBlockHorizontal! * 5,
          right: SizeConfig.safeBlockHorizontal! * 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              AvailableImages.appLogoAltBlack["assetPath"] as String,
              height: SizeConfig.blockSizeVertical! * 25,
              width: SizeConfig.blockSizeHorizontal! * 25,
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(
                bottom: SizeConfig.blockSizeVertical! * 5,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 6,
                    width: SizeConfig.blockSizeHorizontal! * 90,
                    child: Material(
                      borderRadius: BorderRadius.circular(5.0),
                      color: blackPrimary,
                      elevation: 5.0,
                      shadowColor: Colors.white70,
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                            registrationViewRoute,
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: const Text(
                          'CREATE A NEW ACCOUNT',
                          style: TextStyle(
                            // letterSpacing: 1.5,
                            fontWeight: FontWeight.w400,
                            fontFamily: AvailableFonts.secondaryFont,
                            fontSize: 15.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 2,
                  ),
                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 6,
                    width: SizeConfig.blockSizeHorizontal! * 90,
                    child: OutlinedButton(
                      style: ElevatedButton.styleFrom(
                        //Style the text
                        textStyle: const TextStyle(
                          fontSize: 15, //Set font size
                        ),
                        //Style the border
                        side: const BorderSide(
                          color: blackPrimary, //Set border color
                          width: 2, //Set border width
                        ),
                        onPrimary: blackPrimary,
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          loginViewRoute,
                              (Route<dynamic> route) => false,
                        );
                      },
                      child: const Text(
                        'LOGIN',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontFamily: AvailableFonts.secondaryFont,
                          fontSize: 15.0,
                          color: blackPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
