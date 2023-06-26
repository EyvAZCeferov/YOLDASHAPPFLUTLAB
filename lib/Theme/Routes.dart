import 'package:get/get.dart';
import 'package:yoldash/Views/Auth/Login.dart';
import 'package:yoldash/Views/Auth/Register.dart';

final List<GetPage> Routes = [
  GetPage(name: '/login', page: () => Login()),
  GetPage(name: '/register', page: () => Register()),
];
