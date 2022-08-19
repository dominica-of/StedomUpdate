import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stedom/models/account_model.dart';
import 'package:stedom/routes/routes.dart';
import 'package:stedom/services/user_service.dart';
import 'package:stedom/utils/app_config.dart';
import 'package:stedom/utils/colors.dart';
import 'package:stedom/utils/constants.dart';
import 'package:stedom/utils/validator.dart';
import 'package:stedom/widgets/custom_password_field.dart';
import 'package:stedom/widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  bool _saving = false;
  bool rememberMeState = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    final title = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: SizeConfig.blockSizeVertical! * 3),
          child: InkWell(
            // onTap: () => Navigator.pop(context),
            child: Image.asset(
              AvailableImages.backIcon["assetPath"] as String,
              height: SizeConfig.safeBlockVertical! * 2.5,
            ),
          ),
        ),
        const Text(
          "Log in to your\naccount",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: AvailableFonts.primaryFont,
            color: blackPrimary,
            fontWeight: FontWeight.w500,
            fontSize: 35,
          ),
        )
      ],
    );

    final emailField = CustomTextField(
      // fieldIcon: Icons.email_outlined,
      currentFocus: emailFocusNode,
      nextFocus: passwordFocusNode,
      fieldHintText: "",
      fieldValidator: Validator.emailValidator,
      fieldController: emailController,
      fieldTextInputAction: TextInputAction.next,
    );

    final passwordField = CustomPasswordField(
      fieldIcon: Icons.lock_outline,
      currentFocus: passwordFocusNode,
      fieldHintText: "",
      fieldValidator: Validator.textValidator,
      fieldController: passwordController,
      fieldTextInputAction: TextInputAction.done,
    );

    final loginForm = Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical! * 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text("Email",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: blackPrimary,
                )),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 1,
            ),
            emailField,
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 3,
            ),
            const Text("Password",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: blackPrimary,
                )),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 1,
            ),
            passwordField,
          ],
        ),
      ),
    );

    final loginBtn = Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.blockSizeVertical! * 2,
      ),
      child: SizedBox(
        height: SizeConfig.blockSizeVertical! * 6,
        width: SizeConfig.safeBlockHorizontal! * 100,
        child: Material(
          borderRadius: BorderRadius.circular(5.0),
          color: blackPrimary,
          elevation: 0,
          shadowColor: Colors.white70,
          child: MaterialButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (!_saving) {
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                  setState(() {
                    _saving = true;
                  });
                  _emailLogin();
                }
              }
            },
            child: _saving
                ? SizedBox(
                    height: SizeConfig.blockSizeVertical! * 2,
                    width: SizeConfig.blockSizeVertical! * 2,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                : const Text(
                    "Login",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.w300,
                      fontFamily: AvailableFonts.primaryFont,
                      fontSize: 17.0,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );

    final signUp = Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.blockSizeVertical! * 2,
        right: SizeConfig.safeBlockHorizontal! * 10,
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, registrationViewRoute),
        child: const Text(
          'Don\'t have an account? Sign up',
          style: TextStyle(
            letterSpacing: 0.5,
            fontWeight: FontWeight.w400,
            fontFamily: AvailableFonts.primaryFont,
            fontSize: 15.0,
            color: blackPrimary,
          ),
        ),
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical! * 5,
            left: SizeConfig.blockSizeHorizontal! * 5,
            right: SizeConfig.blockSizeHorizontal! * 5,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[title, loginForm, loginBtn, signUp],
            ),
          ),
        ),
      ),
    );
  }

  void _emailLogin() async {
    try {
      await UserService.login(
        LoginModel(
          email: emailController.text,
          password: passwordController.text,
        ),
      ).then((token) async {
        setState(() {
          _saving = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: greenStatus,
            content: Text(
              "Login Successful",
              style: TextStyle(color: greenStatusText),
            ),
            duration: Duration(seconds: 3),
          ),
        );
        Navigator.of(context).pushNamedAndRemoveUntil(
          homeViewRoute,
          (Route<dynamic> route) => false,
        );
      });
    } catch (f) {
      debugPrint(f.toString());
      setState(() {
        _saving = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: redStatus,
          content: Text(
            f.toString(),
            style: const TextStyle(color: redStatusText),
          ),
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }
}
