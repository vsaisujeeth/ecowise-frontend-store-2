

import 'package:ecowise_vendor_v2/UI/buttons.dart';
import 'package:ecowise_vendor_v2/UI/snackBar.dart';
import 'package:ecowise_vendor_v2/Utils/constants.dart';
import 'package:ecowise_vendor_v2/screens/location/addLocationScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController name = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController reTypedPwd = TextEditingController();
  bool signingUp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme().backgroundColor,
      // appBar: buildAppBar(),
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
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      color: Colors.white,
                      iconSize: 18,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios_rounded),
                    ),
                    Text(
                      "Login",
                      style: AppTheme().buildGeneralTextStyle(15, Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: SizeConfig.heightPercent * 8,
                ),
                Text(
                  "SIGNUP",
                  style: AppTheme().buildTitleStyle1(30, Colors.white),
                ),
                SizedBox(
                  height: SizeConfig.heightPercent * 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: SizeConfig.widthPercent * 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 0.5)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextField(
                          controller: name,
                          enabled: true,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: "Store Name"),
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
                      width: SizeConfig.widthPercent * 80,
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
                              hintText: "Account Username"),
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
                      width: SizeConfig.widthPercent * 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 0.5)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextField(
                          controller: password,
                          enabled: true,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Password",
                          ),
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
                      width: SizeConfig.widthPercent * 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(width: 0.5)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextField(
                          controller: reTypedPwd,
                          enabled: true,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Re-type Password"),
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
                    if (name.text.isEmpty ||
                        username.text.isEmpty ||
                        password.text.isEmpty ||
                        reTypedPwd.text.isEmpty) {
                      snackBar(context, "Some fields are empty", Colors.red);
                      return;
                    }
                    if (reTypedPwd.text == password.text) {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => AddAddress(
                            name: name.text,
                            username: username.text,
                            password: password.text,changingAddress: false,)));
                    } else {
                      setState(() {
                        signingUp = false;
                        snackBar(context, "Password Mismatched!", Colors.red);
                      });
                    }
                  },
                  (signingUp)
                      ? const SpinKitSpinningLines(
                    color: Colors.white,
                    size: 30,
                  )
                      : Text(
                    "Add Your Store Address",
                    style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        "Login",
        style: AppTheme().buildGeneralTextStyle(14, Colors.white),
      ),
      leading: IconButton(
        color: Colors.white,
        iconSize: 12,
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.arrow_back_ios_rounded),
      ),
    );
  }
}
