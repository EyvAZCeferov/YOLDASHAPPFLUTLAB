import 'package:get/get.dart';
import '../Controllers/BalanceController.dart';
import '../Controllers/CallingController.dart';
import '../Controllers/CardsController.dart';
import '../Controllers/HistoryController.dart';
import '../Controllers/MessagesController.dart';
import '../Views/Auth/Login.dart';
import '../Views/Auth/Register.dart';
import '../Views/Auth/VerificationCode.dart';
import '../Views/Standarts/Splash.dart';
import '../Views/Tabs/Home/HomePage.dart';
import '../Views/Tabs/MainScreen.dart';
import '../Views/Tabs/Messages/CallPage.dart';
import '../Views/Tabs/Messages/MessagesIndex.dart';
import '../Views/Tabs/Messages/MessagesShow.dart';
import '../Views/Tabs/Profile/Automobils/AutomobilsCreate.dart';
import '../Views/Tabs/Profile/Automobils/AutomobilsIndex.dart';
import '../Views/Tabs/Profile/Balance/BalanceCreate.dart';
import '../Views/Tabs/Profile/Balance/BalanceIndex.dart';
import '../Views/Tabs/Profile/Cards/CardsAdd.dart';
import '../Views/Tabs/Profile/Cards/CardsIndex.dart';
import '../Views/Tabs/Profile/History/HistoryIndex.dart';
import '../Views/Tabs/Profile/History/HistoryShow.dart';
import '../Views/Tabs/Profile/LanguagePage.dart';
import '../Views/Tabs/Profile/ProfileDriver.dart';
import '../Views/Tabs/Profile/ProfileInformation.dart';
import '../Views/Tabs/Profile/ProfilePage.dart';
import '../Controllers/AutomobilsController.dart';

final List<GetPage> Routes = [
  GetPage(name: '/splash', page: () => Splash()),
  GetPage(name: '/login', page: () => Login()),
  GetPage(name: '/register', page: () => Register()),
  GetPage(name: '/verificationcode', page: () => VerificationCode()),
  // Tabs
  GetPage(name: '/mainscreen', page: () => MainScreen()),
  GetPage(name: '/homepage', page: () => HomePage()),

  // Profile
  GetPage(name: '/profilepage', page: () => ProfilePage()),
  GetPage(name: '/profiledriver/:index', page: () => ProfileDriver()),
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
    name: '/balance',
    page: () => BalanceIndex(),
    binding: BindingsBuilder(() {
      Get.put(BalanceController());
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
  GetPage(
    name: '/history/:index',
    page: () => HistoryShow(),
    binding: BindingsBuilder(() {
      Get.put(HistoryController());
    }),
  ),
  GetPage(
    name: '/messages',
    page: () => MessagesIndex(),
    binding: BindingsBuilder(() {
      Get.put(MessagesController());
    }),
  ),
  GetPage(
    name: '/messages/:index',
    page: () => MessagesShow(),
    binding: BindingsBuilder(() {
      Get.put(MessagesController());
    }),
  ),
  GetPage(
    name: '/callpage/:type',
    page: () => CallPage(),
    binding: BindingsBuilder(() {
      Get.put(CallingController());
    }),
  ),
  GetPage(
    name: '/language',
    page: () => LanguagePage(),
  ),
];
