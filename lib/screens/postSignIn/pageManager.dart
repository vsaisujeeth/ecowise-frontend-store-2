

import 'package:ecowise_vendor_v2/Utils/bottomNavigationBar.dart';
import 'package:ecowise_vendor_v2/Utils/constants.dart';
import 'package:ecowise_vendor_v2/Utils/tabProvider.dart';
import 'package:ecowise_vendor_v2/screens/postSignIn/homeScreen.dart';
import 'package:ecowise_vendor_v2/services/apiServices.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageManager extends StatefulWidget {
  PageManager({Key? key}) : super(key: key);

  @override
  _PageManagerState createState() => _PageManagerState();
}

class _PageManagerState extends State<PageManager> {
  List screens = [
    const HomeScreen(),
    const Center(child: Text("This is Profile Page"),)
  ];
  getMyStoreOrders()async{
    Provider.of<orderProvider>(context,listen:false).deInitialiseOrders();
    print("getting store orders");
    await ApiServices().getStoreOrders(storeConstants.token);
    print("got store orders");
    Provider.of<orderProvider>(context,listen: false).InitialiseOrders(storeConstants.storeOrders);
    // Provider.of<orderProvider>(context,listen: false).InitialiseOrders([{}]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMyStoreOrders();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: AppTheme().backgroundColor,
        body: Consumer<TabProvider>(
          builder: (context, tabProvider, child) {
            return screens[tabProvider.selectedTab];
          },
        ),
        bottomNavigationBar: const BottomNavigationBar1(),
      ),
    );
  }
}
