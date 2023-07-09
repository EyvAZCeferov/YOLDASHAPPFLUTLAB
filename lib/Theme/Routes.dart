import 'package:get/get.dart';
import 'package:yoldash/Controllers/AutomobilsController.dart';
import 'package:yoldash/Controllers/BalanceController.dart';
import 'package:yoldash/Controllers/CardsController.dart';
import 'package:yoldash/Controllers/HistoryController.dart';
import 'package:yoldash/Views/Auth/Login.dart';
import 'package:yoldash/Views/Auth/Register.dart';
import 'package:yoldash/Views/Auth/VerificationCode.dart';
import 'package:yoldash/Views/Tabs/Home/HomePage.dart';
import 'package:yoldash/Views/Tabs/MainScreen.dart';
import 'package:yoldash/Views/Tabs/Profile/Automobils/AutomobilsCreate.dart';
import 'package:yoldash/Views/Tabs/Profile/Automobils/AutomobilsIndex.dart';
import 'package:yoldash/Views/Tabs/Profile/Balance/BalanceCreate.dart';
import 'package:yoldash/Views/Tabs/Profile/Cards/CardsAdd.dart';
import 'package:yoldash/Views/Tabs/Profile/Cards/CardsIndex.dart';
import 'package:yoldash/Views/Tabs/Profile/History/HistoryIndex.dart';
import 'package:yoldash/Views/Tabs/Profile/ProfileInformation.dart';
import 'package:yoldash/Views/Tabs/Profile/ProfilePage.dart';

final List<GetPage> Routes = [
  GetPage(name: '/login', page: () => Login()),
  GetPage(name: '/register', page: () => Register()),
  GetPage(name: '/verificationcode', page: () => VerificationCode()),
  // Tabs
  GetPage(name: '/mainscreen', page: () => MainScreen()),
  GetPage(name: '/homepage', page: () => HomePage()),

  // Profile
  GetPage(name: '/profilepage', page: () => ProfilePage()),
  GetPage(name: '/profileinformation', page: () => ProfileInformation()),
  GetPage(
    name: '/cards',
    page: () => CardsIndex(),
    binding: BindingsBuilder(() {
      Get.put(CardsController());
    }),
  ),
  GetPage(
    name: '/cards/add',
    page: () => CardsAdd(),
    binding: BindingsBuilder(() {
      Get.put(CardsController());
    }),
  ),
  GetPage(
    name: '/automobils',
    page: () => AutomobilsIndex(),
    binding: BindingsBuilder(() {
      Get.put(AutomobilsController());
    }),
  ),
  GetPage(
    name: '/automobils/add',
    page: () => AutomobilsCreate(),
    binding: BindingsBuilder(() {
      Get.put(AutomobilsController());
    }),
  ),
  GetPage(
    name: '/balance/add',
    page: () => BalanceCreate(),
    binding: BindingsBuilder(() {
      Get.put(BalanceController());
    }),
  ),
  GetPage(
    name: '/history',
    page: () => HistoryIndex(),
    binding: BindingsBuilder(() {
      Get.put(HistoryController());
    }),
  ),
];
