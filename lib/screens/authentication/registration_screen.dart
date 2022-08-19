import 'package:flutter/gestures.dart';
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

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  RegistrationScreenState createState() => RegistrationScreenState();
}

class RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordOneController = TextEditingController();
  final passwordTwoController = TextEditingController();

  final fullNameFocusNode = FocusNode();
  final emailFocusNode = FocusNode();
  final passwordOneFocusNode = FocusNode();
  final passwordTwoFocusNode = FocusNode();

  String selectedSpecification = "Piano";

  List<String> specificationList = ["Piano", "Violin", "Trumpet"];

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordOneController.dispose();
    passwordTwoController.dispose();

    fullNameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordOneFocusNode.dispose();
    passwordTwoFocusNode.dispose();
    super.dispose();
  }

  bool termsAgreed = false;
  bool _saving = false;

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
          "Register",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontFamily: AvailableFonts.primaryFont,
            color: blackPrimary,
            fontWeight: FontWeight.w500,
            fontSize: 37,
          ),
        )
      ],
    );

    final specificationField = FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 0.0,
              horizontal: 15.0,
            ),
            filled: true,
            hintText: "I want to learn",
            suffixIcon: Icon(
              Icons.piano,
              color: greyPrimary,
            ),
            errorStyle: TextStyle(
              fontSize: 11.0,
            ),
            focusColor: greyDateBackground,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
                color: greyDateBackground,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
                color: greyDateBackground,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
                color: greyDateBackground,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            focusedErrorBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              color: greyPrimary,
              fontSize: 11,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              items: specificationList.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
              icon: const Icon(
                Icons.arrow_drop_down_outlined,
                size: 25,
                color: blackPrimary,
              ),
              onChanged: (dynamic newVal) {
                setState(() {
                  selectedSpecification = newVal;
                });
              },
              value: selectedSpecification,
            ),
          ),
        );
      },
    );

    final fullNameField = CustomTextField(
      fieldIcon: Icons.person_outline,
      currentFocus: fullNameFocusNode,
      nextFocus: emailFocusNode,
      fieldHintText: "Enter your full name",
      fieldValidator: Validator.textValidator,
      fieldController: fullNameController,
      fieldTextInputAction: TextInputAction.next,
    );

    final emailField = CustomTextField(
      fieldIcon: Icons.email_outlined,
      currentFocus: emailFocusNode,
      nextFocus: passwordOneFocusNode,
      fieldHintText: "Enter your email address",
      fieldValidator: Validator.emailValidator,
      fieldController: emailController,
      fieldTextInputAction: TextInputAction.next,
    );

    final passwordOneField = CustomPasswordField(
      fieldIcon: Icons.lock_outline,
      currentFocus: passwordOneFocusNode,
      nextFocus: passwordTwoFocusNode,
      fieldHintText: "",
      fieldValidator: Validator.textValidator,
      fieldController: passwordOneController,
      fieldTextInputAction: TextInputAction.next,
    );

    final passwordTwoField = CustomPasswordField(
      fieldIcon: Icons.lock_outline,
      currentFocus: passwordTwoFocusNode,
      fieldHintText: "",
      fieldValidator: (String value) {
        if (passwordTwoController.text != passwordOneController.text) {
          return 'passwords do not match';
        }
        return null;
      },
      fieldController: passwordTwoController,
      fieldTextInputAction: TextInputAction.done,
    );

    final registrationForm = Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.only(
          top: SizeConfig.blockSizeVertical! * 5,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "What do yo want to learn?",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: blackPrimary,
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            specificationField,
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            const Text(
              "Full Name",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: blackPrimary,
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 1,
            ),
            fullNameField,
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
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
              height: SizeConfig.blockSizeVertical! * 2,
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
            passwordOneField,
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 2,
            ),
            const Text("Repeat Password",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: blackPrimary,
                )),
            SizedBox(
              height: SizeConfig.blockSizeVertical! * 1,
            ),
            passwordTwoField,
          ],
        ),
      ),
    );

    final termsConditions = Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Theme(
          data: ThemeData(unselectedWidgetColor: blackPrimary),
          child: Checkbox(
            checkColor: Colors.white,
            activeColor: blackPrimary,
            value: termsAgreed,
            onChanged: (bool? value) {
              setState(() {
                termsAgreed = value!;
              });
            },
          ),
        ),
        SizedBox(
            width: SizeConfig.blockSizeHorizontal! * 70,
            child: RichText(
              text: TextSpan(
                  text: 'By signing up you have agreed to Stedom’s',
                  style: const TextStyle(
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w600,
                    fontFamily: AvailableFonts.primaryFont,
                    fontSize: 15.0,
                    color: blackPrimary,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: ' Terms & Conditions',
                      style: const TextStyle(
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w600,
                        fontFamily: AvailableFonts.primaryFont,
                        fontSize: 15.0,
                        color: blackPrimary,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // launchUrl("url");
                        },
                    )
                  ]),
            )),
      ],
    );

    final registrationFormBtn = Padding(
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
                  if (termsAgreed) {
                    SystemChannels.textInput.invokeMethod('TextInput.hide');
                    setState(() {
                      _saving = true;
                    });
                    _registration();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: redStatus,
                        content: Text(
                          "Terms & Conditions not agreed",
                          style: TextStyle(color: redStatusText),
                        ),
                        duration: Duration(seconds: 5),
                      ),
                    );
                  }
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
                    "Next",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w500,
                      fontFamily: AvailableFonts.primaryFont,
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );

    final signIn = Padding(
      padding: EdgeInsets.only(
        top: SizeConfig.blockSizeVertical! * 2,
        bottom: SizeConfig.blockSizeVertical! * 2,
        left: SizeConfig.safeBlockHorizontal! * 10,
        right: SizeConfig.safeBlockHorizontal! * 10,
      ),
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, loginViewRoute),
        child: const Text(
          'Already have an account? Sign in',
          style: TextStyle(
            letterSpacing: 0.5,
            fontWeight: FontWeight.w600,
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
              children: <Widget>[
                title,
                registrationForm,
                registrationFormBtn,
                termsConditions,
                signIn
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _registration() async {
    try {
      await UserService.registration(
        UserModel(
          email: emailController.text,
          specification: selectedSpecification,
          fullName: fullNameController.text,
          password: passwordTwoController.text,
        ),
      ).then((response) async {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: greenStatus,
            content: Text(
              response,
              style: const TextStyle(color: greenStatusText),
            ),
            duration: const Duration(seconds: 3),
          ),
        );
        Future.delayed(const Duration(seconds: 4), () {
          Navigator.pushReplacementNamed(context, loginViewRoute);
        });

        setState(() {
          _saving = false;
        });
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
