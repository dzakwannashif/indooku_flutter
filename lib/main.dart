import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:indooku_flutter/API/api.dart' as api;
import 'package:indooku_flutter/helper/secureStorageHelper.dart';
import 'package:indooku_flutter/pages/home.dart';
import 'package:indooku_flutter/pages/login.dart';
import 'package:indooku_flutter/pages/navbot.dart';
import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:floating_frosted_bottom_bar/floating_frosted_bottom_bar.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  api.init();

  // await SecureStorageHelper.deleteDataLokalSemua();
  final token = await SecureStorageHelper.getToken();
  final isLoggedIn = token != null;
  final home = isLoggedIn ? NavigationBarPage() : LoginPage();
  runApp(MyApp(
    home: home,
  ));
}

class MyApp extends StatelessWidget {
  final Widget home;
  const MyApp({super.key, required this.home});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: home,
    );
  }
}
