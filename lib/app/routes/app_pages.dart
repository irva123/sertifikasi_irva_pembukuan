// ignore_for_file: constant_identifier_names

import 'package:get/get.dart';
import '../modules/pengeluaran/add_expense_service.dart';
import '../modules/pengeluaran/add_expense_screen.dart';
import '../modules/pemasukan/add_income_service.dart';
import '../modules/pemasukan/add_income_screen.dart';
import '../modules/detail/detail_cash_flow_service.dart';
import '../modules/detail/detail_cash_flow_screen.dart';
import '../modules/home/home_service.dart';
import '../modules/home/home_screen.dart';
import '../modules/login/login_service.dart';
import '../modules/login/login_screen.dart';
import '../modules/setting/setting_service.dart';
import '../modules/setting/setting_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ADD_INCOME,
      page: () => AddIncomeScreen(),
      binding: AddIncomeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_EXPENSE,
      page: () => AddExpenseScreen(),
      binding: AddExpenseBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_CASH_FLOW,
      page: () => DetailCashFlowScreen(),
      binding: DetailCashFlowBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => SettingScreen(),
      binding: SettingBinding(),
    ),
  ];
}
