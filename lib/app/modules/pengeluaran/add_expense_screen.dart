// ignore_for_file: deprecated_member_use, prefer_const_constructors, sized_box_for_whitespace, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sertifikasi_irva_pembukuan/app/utility/app_color.dart';
import 'package:sertifikasi_irva_pembukuan/app/widgets/custom_input.dart';

import 'add_expense_controller.dart';

// ignore: must_be_immutable
class AddExpenseScreen extends GetView<AddExpenseController> {
  late double mWidth;
  late double mHeight;
  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height / 1.2;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 59, 5, 66),
          title: const Text('Tambah Pengeluaran'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            height: mHeight,
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Input field untuk tanggal
                    CustomInput(
                      controller: controller.dateC,
                      label: "Tanggal",
                      hint: "Pilih tanggal",
                      suffixIcon: const Icon(
                        Icons.date_range,
                        color: Colors.grey,
                      ),
                      isDate: true,
                    ),

                    // Input field untuk nominal
                    CustomInput(
                      controller: controller.nominalC,
                      label: "Nominal",
                      hint: "Masukkan nominal",
                      isNumber: true,
                      isNominal: true,
                    ),

                    // Input field untuk keterangan
                    CustomInput(
                      controller: controller.descriptionC,
                      label: "Keterangan",
                      hint: "Masukkan keterangan",
                    ),
                  ],
                ),

                // Tombol reset formulir
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (controller.isLoading.isFalse) {
                        await controller.resetForm();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      elevation: 0,
                      primary: Color.fromARGB(255, 63, 72, 100),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Reset',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                // Tombol simpan data pengeluaran
                Obx(
                  () => Container(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (controller.isLoading.isFalse) {
                          await controller.addExpense();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 18),
                        elevation: 0,
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        (controller.isLoading.isFalse)
                            ? 'Simpan'
                            : 'Loading...',
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'montserrat',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                // Tombol kembali
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 18),
                      elevation: 0,
                      primary: Colors.orange,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      '<<< Kembali',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
