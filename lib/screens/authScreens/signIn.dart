

import 'package:ecowise_vendor_v2/UI/buttons.dart';
import 'package:ecowise_vendor_v2/UI/snackBar.dart';
import 'package:ecowise_vendor_v2/Utils/constants.dart';
import 'package:ecowise_vendor_v2/screens/authScreens/signUp.dart';
import 'package:ecowise_vendor_v2/services/apiServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  bool loggingIn = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme().backgroundColor,
      body: Container(
        height: SizeConfig.height,
        width: SizeConfig.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme().gradientColor1,
                  AppTheme().gradientColor2
                ])),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: SizeConfig.heightPercent * 10,
                ),
                Text(
                  "Ecowise Store",
                  style: AppTheme().welcomeTitle,
                ),
                SizedBox(
                  height: SizeConfig.heightPercent * 10,
                ),
                Text(
                  "LOGIN",
                  style: AppTheme().buildTitleStyle1(30, Colors.white),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: SizeConfig.widthPercent * 65,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 0.5)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextField(
                          controller: username,
                          enabled: true,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: " Enter Username"),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: SizeConfig.widthPercent * 65,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 0.5)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: TextField(
                          controller: password,
                          enabled: true,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: " Enter Password"),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                loadingButton(
                  context,
                      () async {
                    if (username.text.isEmpty || password.text.isEmpty) {
                      snackBar(context, "Some Fields are empty!", Colors.red);
                      return;
                    }
                    setState(() {
                      loggingIn = true;
                    });

                    bool isLogin = await ApiServices().logIn(username.text, password.text);
                    if(isLogin){
                      snackBar(context, "Logged In Successfully!", Colors.green);
                      // Navigator.of(context).pop();
                      // Navigator.of(context).push(
                      //     MaterialPageRoute(builder: (_)=>PageManager())
                      // );
                    } else {
                      setState(() {
                        loggingIn = false;
                      });
                      snackBar(
                          context, "Invalid Credentials!", Colors.red);
                    }
                  },
                  (loggingIn)
                      ? const SpinKitSpinningLines(
                    color: Colors.white,
                    size: 30,
                  )
                      : Text(
                    "LOGIN",
                    style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  "Don't have an account yet?",
                  textAlign: TextAlign.center,
                  style: AppTheme().buildGeneralTextStyle(16, Colors.white),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const SignUpPage()));
                  },
                  child: Text(
                    "SignUp",
                    textAlign: TextAlign.center,
                    style: AppTheme().buildTitleStyle1(18, Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
