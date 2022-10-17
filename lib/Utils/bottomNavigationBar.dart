import 'package:ecowise_vendor_v2/Utils/constants.dart';
import 'package:ecowise_vendor_v2/Utils/tabProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class BottomNavigationBar1 extends StatefulWidget {
  const BottomNavigationBar1({Key? key}) : super(key: key);

  @override
  _BottomNavigationBar1State createState() => _BottomNavigationBar1State();
}

class _BottomNavigationBar1State extends State<BottomNavigationBar1> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TabProvider>(
      builder: (context, tabProvider, child) {
        return Container(
          decoration: BoxDecoration(color: AppTheme().primaryColor),
          child: BottomAppBar(
            color: Colors.white,
            elevation: 20,
            child: SizedBox(
              height: SizeConfig.heightPercent * 8,
              width: SizeConfig.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    tabIcon(
                        title: "Home",
                        icon: const Icon(Icons.home_rounded),
                        isSelected: tabProvider.selectedTab == 0,
                        onPressed: () {
                          tabProvider.selectTab(0);
                        }),
                    tabIcon(
                        title: "Profile",
                        icon: const Icon(Icons.person_rounded),
                        isSelected: tabProvider.selectedTab == 1,
                        onPressed: () {
                          tabProvider.selectTab(1);
                        }),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  tabIcon(
      {required String title,
        required Icon icon,
        required bool isSelected,
        required VoidCallback onPressed}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: onPressed,
            icon: icon,
            color: (isSelected) ? AppTheme().primaryColor : Colors.grey,
          ),
          Text(
            title,
            style: GoogleFonts.arvo(
              color: (isSelected) ? AppTheme().primaryColor : Colors.grey,
              fontSize: 13,
              height: .1,
            ),
          )
        ],
      ),
    );
  }
}
