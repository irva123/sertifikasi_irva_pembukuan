// ignore_for_file: unnecessary_overrides, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sertifikasi_irva_pembukuan/app/modules/home/home_controller.dart';
import 'package:sertifikasi_irva_pembukuan/app/routes/app_pages.dart';
import 'package:sertifikasi_irva_pembukuan/app/utility/app_color.dart';
import 'package:sertifikasi_irva_pembukuan/app/utility/database_helper.dart';

class AddExpenseController extends GetxController {
  RxBool isLoading = false.obs;
  TextEditingController dateC = TextEditingController();
  TextEditingController nominalC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();

  final DatabaseHelper dbHelper = DatabaseHelper.instance;
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Fungsi ini digunakan untuk mereset formulir penambahan pengeluaran
  Future<void> resetForm() async {
    dateC.text = "01-01-2021";
    nominalC.clear();
    descriptionC.clear();
  }

  // Fungsi ini digunakan untuk menambahkan data pengeluaran ke database
  Future<void> addExpense() async {
    final date = dateC.text;
    final nominalWithRp = nominalC.text;
    final numericText = nominalWithRp.replaceAll("Rp ", "").replaceAll(".", "");
    final nominal = int.tryParse(numericText);
    final description = descriptionC.text;
    final status = "expense"; // Status pengeluaran

    final cashflow = {
      'user_id': box.read('user_id'),
      'date': date,
      'nominal': nominal,
      'description': description,
      'status': status, // Konversi ke integer
    };

    final id = await dbHelper.insertCashflow(cashflow);

    if (id != null) {
      // Memperbarui data pada controller Home setelah pengeluaran ditambahkan
      final HomeController homeController = Get.put(HomeController());
      homeController.reInitialize();

      // Kembali ke halaman utama dan tampilkan snackbar berhasil
      Get.offNamed(Routes.HOME);
      Get.snackbar(
        'Berhasil',
        'Data pengeluaran berhasil disimpan',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.primaryColor,
        colorText: Colors.white,
      );
    } else {
      // Handle jika gagal menyimpan data pengeluaran
      Get.snackbar(
        'Error',
        'Gagal menyimpan data pengeluaran',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.secondary,
        colorText: Colors.white,
      );
    }
  }
}
