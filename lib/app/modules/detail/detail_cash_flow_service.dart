import 'package:get/get.dart';

import 'detail_cash_flow_controller.dart';

class DetailCashFlowBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailCashFlowController>(
      () => DetailCashFlowController(),
    );
  }
}
