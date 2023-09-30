// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';
import 'package:sertifikasi_irva_pembukuan/app/models/cashflow.dart';
import 'package:sertifikasi_irva_pembukuan/app/utility/database_helper.dart';

class DetailCashFlowController extends GetxController {
  final dbHelper = DatabaseHelper.instance;
  RxList<CashFlow> cashflows = RxList<CashFlow>();

  @override
  void onInit() {
    super.onInit();
    loadCashflows();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void loadCashflows() async {
    final cashflowList = await dbHelper.getCashflows();
    cashflows.assignAll(cashflowList);
  }
}
