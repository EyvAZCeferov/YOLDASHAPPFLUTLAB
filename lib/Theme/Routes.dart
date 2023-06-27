import 'package:get/get.dart';
import 'package:yoldash/Views/Auth/Login.dart';
import 'package:yoldash/Views/Auth/Register.dart';
import 'package:yoldash/Views/Auth/VerificationCode.dart';
import 'package:yoldash/Views/Tabs/Home/HomePage.dart';

final List<GetPage> Routes = [
  GetPage(name: '/login', page: () => Login()),
  GetPage(name: '/register', page: () => Register()),
  GetPage(name: '/verificationcode', page: () => VerificationCode()),
  // Tabs
  GetPage(name: '/homepage', page: () => HomePage()),
];
