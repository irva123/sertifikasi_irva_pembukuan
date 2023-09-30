// ignore_for_file: use_key_in_widget_constructors, sort_child_properties_last, deprecated_member_use, avoid_unnecessary_containers, prefer_const_constructors, prefer_is_empty
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sertifikasi_irva_pembukuan/app/modules/detail/cash_flow_widget.dart';
import 'package:sertifikasi_irva_pembukuan/app/utility/app_color.dart';
import 'detail_cash_flow_controller.dart';

// ignore: must_be_immutable
class DetailCashFlowScreen extends GetView<DetailCashFlowController> {
  late double mWidth;
  late double mHeight;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height / 1.2;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: const Text('Detail Cash Flow'),
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          onPressed: () async {
            Get.back();
          },
          child: const Text(
            '<< Kembali',
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'montserrat',
              fontWeight: FontWeight.w500,
            ),
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 18),
            elevation: 0,
            primary: AppColor.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: mHeight,
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              Obx(
                () => controller.cashflows.isEmpty
                    ? Container(
                        child: Center(
                          child: Text('Data masih kosong'),
                        ),
                      )
                    : Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemCount: controller.cashflows.length,
                          reverse: true, // Reverse the order
                          itemBuilder: (context, index) {
                            final cashflow = controller.cashflows[index];
                            if (cashflow.status == "income") {
                              return CashFlowWidget(
                                status_income: true,
                                nominal: cashflow.nominal,
                                description: cashflow.description,
                                date: cashflow.date,
                              );
                            } else if (cashflow.status == "expense") {
                              return CashFlowWidget(
                                status_income: false,
                                nominal: cashflow.nominal,
                                description: cashflow.description,
                                date: cashflow.date,
                              );
                            }
                            return Container();
                          },
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
