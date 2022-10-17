

import 'package:ecowise_vendor_v2/UI/buttons.dart';
import 'package:ecowise_vendor_v2/UI/snackBar.dart';
import 'package:ecowise_vendor_v2/Utils/constants.dart';
import 'package:ecowise_vendor_v2/screens/postSignIn/homeScreen.dart';
import 'package:ecowise_vendor_v2/services/apiServices.dart';
import 'package:ecowise_vendor_v2/services/locationServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddAddress extends StatefulWidget {
  String name, username, password;
  bool changingAddress;
  AddAddress(
      {required this.name,
        required this.username,
        required this.password,
        required this.changingAddress,
        Key? key})
      : super(key: key);

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  TextEditingController flatNo = TextEditingController();
  TextEditingController colony = TextEditingController();
  TextEditingController locality = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController pinCode = TextEditingController();

  bool _addingCurrentLocation = false;
  bool _signingUp = false;
  String address = "";
  Map<String, dynamic> userAddress = {};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme().backgroundColor,
      appBar: buildAppBar(context),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              iconButton(context, () async {
                if (!_addingCurrentLocation) {
                  await addCurrentLocation();
                }
              },
                  (_addingCurrentLocation)
                      ? const SpinKitSpinningLines(
                    color: Colors.white,
                    size: 30,
                  )
                      : Text(
                    "Add Current Location",
                    style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  const Icon(
                    Icons.navigation_rounded,
                    color: Colors.white,
                  )),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey[300],
                    ),
                  ),
                  Text(
                    "or",
                    style: AppTheme()
                        .buildGeneralTextStyle(13, Colors.grey.shade400),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey[300],
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
                  Text(
                    "Type your Address manually",
                    style: AppTheme()
                        .buildGeneralTextStyle(14, Colors.grey.shade500),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildTextField(45, SizeConfig.widthPercent * 40,
                      "House.No/Flat.No/Apartment name", flatNo),
                  buildTextField(45, SizeConfig.widthPercent * 40,
                      "Street No./Colony", colony),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              buildTextField(
                  45, SizeConfig.widthPercent * 85, "Locality name", locality),
              const SizedBox(
                height: 15,
              ),
              buildTextField(
                  45, SizeConfig.widthPercent * 85, "City Name", city),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildTextField(
                      45, SizeConfig.widthPercent * 40, "Landmark", landmark),
                  buildTextField(
                      45, SizeConfig.widthPercent * 40, "PinCode", pinCode),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              loadingButton(
                context,
                (widget.changingAddress)?()async{
                  bool x = await addAddress();
                  if(x){
                    Map<String,dynamic> data = {
                      "address":userAddress
                    };
                    bool isEdited = await ApiServices().editStoreProfile(storeConstants.token, data);
                    if(isEdited){
                      //Provider.of<ProfileChangeProvider>(context,listen: false).triggerProfileChanged();
                      Navigator.pop(context);
                    }else{
                      snackBar(context, "An Error Occurred!", Colors.red);
                    }
                  }
                }:() async {
                  setState(() {
                    _signingUp = true;
                  });
                  bool y = await addAddress();
                  if(y){
                    bool x = await signUpUser(userAddress);
                    if(x){
                      snackBar(context, "Registered Successfully, Logging In!!", Colors.green);
                      bool loggedIn = await ApiServices().logIn(widget.username, widget.password);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      if(loggedIn){
                        Navigator.pop(context);
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_)=>HomeScreen())
                        );
                      }else{
                        snackBar(context, "An Error Occurred!", Colors.red);
                      }
                    }
                  }
                },
                (_signingUp)
                    ? const SpinKitSpinningLines(
                  color: Colors.white,
                  size: 30,
                )
                    : Text(
                  (widget.changingAddress)?"Save":"SIGNUP",
                  style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          )),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppTheme().backgroundColor,
      title: Text(
        "Add your Address",
        style: AppTheme().buildTitleStyle1(22, Colors.black),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.grey,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: true,
    );
  }

  addCurrentLocation() async {
    setState(() {
      _addingCurrentLocation = true;
    });

    Position position = await LocationServices().getCurrentPosition();
    address = await LocationServices().getCurrentAddress(position);

    userAddress = {
      "location": "${position.latitude} - ${position.longitude}",
      "full_address": address,
    };
    setState(() {
      _addingCurrentLocation = false;
    });

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(
          (widget.changingAddress)?'Save':'Sign Up',
          style: AppTheme().buildGeneralTextStyle(24, Colors.red),
        ),
        content: Text(
          'You Address is $address.',
          style: AppTheme().buildTitleStyle1(16, Colors.black),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: Text(
              'Cancel',
              style: AppTheme().buildTitleStyle1(16, Colors.black),
            ),
          ),
          TextButton(
            onPressed: () async {
              if(widget.changingAddress){
                Map<String,dynamic> data = {
                  "address":userAddress
                };
                bool isEdited = await ApiServices().editStoreProfile(storeConstants.token, data);
                if(isEdited){
                  //Provider.of<ProfileChangeProvider>(context,listen: false).triggerProfileChanged();
                  Navigator.pop(context);
                  Navigator.pop(context);
                }else{
                  snackBar(context, "An Error Occurred!", Colors.red);
                }
              }else{
                Navigator.pop(context, 'Sign UP');
                await signUpUser(userAddress);
              }
            },
            child: Text(
              'Yes',
              style: AppTheme().buildTitleStyle1(16, Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> addAddress() async {
    setState(() {});
    address = flatNo.text +
        ", " +
        colony.text +
        ", " +
        locality.text +
        ", " +
        pinCode.text +
        ", " +
        city.text;
    String addLandmark = landmark.text;
    Location position =
    await LocationServices().getPositionFromAddress(address);

    if (position.latitude == 0.0) {
      setState(() {});
      snackBar(context, "Invalid Address!", Colors.redAccent);
      return false;
    }

    userAddress = {
      "location": "${position.latitude} - ${position.longitude}",
      "full_address": address,
    };

    return true;
  }

  signUpUser(Map<String, dynamic> userAddress) async {
    setState(() {
      _signingUp = true;
    });
    bool err = await ApiServices().signUp(
      widget.name,
      widget.username,
      widget.password,
      userAddress,
    );

    setState(() {
      _signingUp = false;
    });
    if (err) {
      snackBar(context, "SignedUp Successfully!", Colors.green);
    } else {
      snackBar(context, "An error Occurred!, $err", Colors.red);
      return false;
    }
    return true;
  }

  Widget buildTextField(double height, double width, String hint,
      TextEditingController controller) {
    return Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10),
        ),
        height: height,
        width: width,
        child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hint,
                  hintStyle: AppTheme().buildGeneralTextStyle(
                    13,
                    Theme.of(context).hintColor,
                  ),
                ),
              ),
            )),
      ),
    );
  }
}
