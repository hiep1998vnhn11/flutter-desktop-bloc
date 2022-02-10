import 'package:trello/models/model.dart';
import 'package:trello/screens/screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String home = "/home";
  static const String signIn = "/signIn";
  static const String forgotPassword = "/forgotPassword";
  static const String editProfile = "/editProfile";
  static const String changePassword = "/changePassword";
  static const String changeLanguage = "/changeLanguage";
  static const String themeSetting = "/themeSetting";
  static const String setting = "/setting";
  static const String fontSetting = "/fontSetting";
  static const String statementFilter = "/statementFilter";
  static const String pickerScreen = "/pickerScreen";
  static const String notification = "/notification";
  static const String portfolio = "/portfolio";
  static const String listProduct = "/listProduct";
  static const String productDetail = "/productDetail";
  static const String bestSale = "/bestSale";
  static const String topCountry = "/topCountry";
  static const String device = "/device";
  static const String serviceStatus = "/serviceStatus";
  static const String about = "/about";
  static const String webView = "/webView";
  static const String report = "/report";
  static const String invoiceCheck = "/invoiceCheck";
  static const String qrScan = "/qrScan";
  static const String manageAccount = "/manageAccount";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case signIn:
        return MaterialPageRoute(
          builder: (context) {
            return const SignIn();
          },
          fullscreenDialog: true,
        );
      case changeLanguage:
        return MaterialPageRoute(
          builder: (context) {
            return const LanguageSetting();
          },
        );
      case themeSetting:
        return MaterialPageRoute(
          builder: (context) {
            return const ThemeSetting();
          },
        );
      case setting:
        return MaterialPageRoute(
          builder: (context) {
            return const Setting();
          },
        );
      case fontSetting:
        return MaterialPageRoute(
          builder: (context) {
            return const FontSetting();
          },
        );

      case pickerScreen:
        final picker = settings.arguments as PickerScreenModel;
        return MaterialPageRoute(
          builder: (context) {
            return PickerScreen(picker: picker);
          },
          fullscreenDialog: true,
        );

      case webView:
        final web = settings.arguments as WebViewModel;
        return MaterialPageRoute(
          builder: (context) {
            return WebViewPage(
              web: web,
            );
          },
          fullscreenDialog: true,
        );

      case qrScan:
        return MaterialPageRoute(
          builder: (context) {
            return const QRScan();
          },
          fullscreenDialog: true,
        );

      default:
        return MaterialPageRoute(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                title: const Text("Not Found"),
              ),
              body: Center(
                child: Text('No path for ${settings.name}'),
              ),
            );
          },
        );
    }
  }

  ///Singleton factory
  static final Routes _instance = Routes._internal();

  factory Routes() {
    return _instance;
  }

  Routes._internal();
}
