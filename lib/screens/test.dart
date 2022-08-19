import 'package:flutter/material.dart';
import 'package:stedom/utils/app_config.dart';
import 'package:stedom/utils/colors.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final appBar = AppBar(
      leading: Builder(
        builder: (BuildContext appBarContext) {
          return IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: blackPrimary,
            ),
            tooltip: 'Menu Icon',
            onPressed: () {
              Navigator.pop(context);
            },
          );
        },
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: appBackground,
    );

    return Scaffold(
      key: widget.key,
      appBar: appBar,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
