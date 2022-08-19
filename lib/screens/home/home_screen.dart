import 'package:flutter/material.dart';
import 'package:stedom/utils/app_config.dart';
import 'package:stedom/utils/colors.dart';
import 'package:stedom/utils/constants.dart';
import 'package:stedom/utils/validator.dart';
import 'package:stedom/widgets/custom_text_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final searchController = TextEditingController();
  final searchFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final searchField = CustomTextField(
      fieldIcon: Icons.search,
      currentFocus: searchFocusNode,
      fieldHintText: "Search for tutor or skill",
      fieldValidator: Validator.textValidator,
      fieldController: searchController,
      fieldTextInputAction: TextInputAction.done,
    );

    final title = RichText(
      text: const TextSpan(
        text: 'Hello, ',
        style: TextStyle(
          letterSpacing: 0.5,
          fontWeight: FontWeight.w400,
          fontFamily: AvailableFonts.primaryFont,
          fontSize: 25.0,
          color: blackPrimary,
        ),
        children: <TextSpan>[
          TextSpan(
            text: 'Dominica',
            style: TextStyle(
              letterSpacing: 0.5,
              fontWeight: FontWeight.w600,
              fontFamily: AvailableFonts.primaryFont,
              fontSize: 25.0,
              color: blackPrimary,
            ),
          )
        ],
      ),
    );

    return Scaffold(
      key: widget.key,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                top: SizeConfig.blockSizeVertical! * 2,
                left: SizeConfig.blockSizeHorizontal! * 5,
                right: SizeConfig.blockSizeHorizontal! * 5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title,
                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 2,
                  ),
                  searchField,
                  SizedBox(
                    height: SizeConfig.blockSizeVertical! * 5,
                  ),
                  const Text(
                    'Featured Skills',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontFamily: AvailableFonts.primaryFont,
                      fontSize: 13.0,
                      color: blackPrimary,
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
