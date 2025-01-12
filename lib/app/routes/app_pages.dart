import 'package:get/get.dart';

import '../modules/admin/bindings/admin_binding.dart';
import '../modules/admin/views/admin_view.dart';
import '../modules/contact/bindings/contact_binding.dart';
import '../modules/contact/views/contact_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/list/bindings/list_binding.dart';
import '../modules/list/views/list_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';

part 'app_routes.dart';

class AppPages {
  static const HOME = Routes.HOME;
  static const LOGIN = Routes.LOGIN;
  static const LIST = Routes.LIST;
  static const CONTACT = Routes.CONTACT;
  static const ADMIN = Routes.ADMIN;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
    ),
    GetPage(
      name: Routes.LIST,
      page: () => ListViewPage(),
    ),
    GetPage(
      name: Routes.CONTACT,
      page: () => ContactView(),
    ),
    GetPage(
      name: Routes.ADMIN,
      page: () => AdminView(),
    ),
  ];
}