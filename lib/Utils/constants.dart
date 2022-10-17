import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double width;
  static late double height;
  static late double widthPercent;
  static late double heightPercent;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

    width = _mediaQueryData.size.width;
    height = _mediaQueryData.size.height;

    widthPercent = width * 0.01;
    heightPercent = height * 0.01;
  }
}

class AppTheme {
  Color backgroundColor = Color(0xFFF2F2F2);
  Color primaryColor = Color(0xFF6C5CFF);
  Color textColor = Colors.black;
  Color textLightColor = Colors.grey;
  Color gradientColor1 = Color(0xFFB542FF);
  Color gradientColor2 = Color(0xFF6C93E8);

  TextStyle welcomeTitle = GoogleFonts.fredokaOne(
    fontSize: 35,
    color: Colors.white,
    //fontWeight: FontWeight.normal
  );

  TextStyle buildTitleStyle1(double size, Color color) {
    return GoogleFonts.workSans(
      fontWeight: FontWeight.w600,
      color: color,
      fontSize: size,
    );
  }

  TextStyle buildGeneralTextStyle(double size, Color color) {
    return GoogleFonts.ubuntu(
        fontWeight: FontWeight.normal, fontSize: size, color: color);
  }
}


class StoreConstants{
  late String _token;
  late bool _isActive;
  late String _storeId;
  late String _username;
  late String _name;
  late int _radius;
  late Map _address;
  late List _storeOrders;
  late Map _configurations;
  late List _categories;
  late List _pointTransactions;


  String get token => _token;
  bool get isActive => _isActive;
  String get storeId => _storeId;
  String get username => _username;
  String get name => _name;
  int get radius => _radius;
  Map get address => _address;
  List get storeOrders => _storeOrders;
  Map get configurations => _configurations;
  List get categories => _categories;
  List get pointTransactions => _pointTransactions;

  initiateAuthToken(String tok){
    _token = tok;
  }

  initiateStoreConstants(Map data){
    _isActive = data['is_active'];
    _storeId = data['_id'];
    _username = data['username'];
    _name = data['name'];
    _radius = data['radius'];
    _address = data['address'];
    //_configurations = data['configurations'] ?? {};
    _configurations = {};
    _categories = data['categories'];
    _pointTransactions = data['point_transactions'];
  }

  initiateStoreOrders(List data){
    _storeOrders = data;
  }

  initiateCategories(List data){
    _categories = data;
  }
  initiateConfigs(Map data){
    _configurations = data;
  }
}

StoreConstants storeConstants = StoreConstants();

