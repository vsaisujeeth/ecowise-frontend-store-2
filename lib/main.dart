import 'package:ecowise_vendor_v2/Utils/tabProvider.dart';
import 'package:ecowise_vendor_v2/screens/authScreens/signIn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
     // ChangeNotifierProvider(create: (_) => orderProvider()),
     // ChangeNotifierProvider(create: (_) => storeConfigs()),
     ChangeNotifierProvider(create: (_) => TabProvider()),
     //ChangeNotifierProvider(create: (_) => ProfileChangeProvider()),
     //ChangeNotifierProvider(create: (_) => approving())
  ], child: MyApp()));

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EcoWise',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignInPage(),
    );
  }
}
