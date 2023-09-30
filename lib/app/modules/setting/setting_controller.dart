// ignore_for_file: unnecessary_overrides

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sertifikasi_irva_pembukuan/app/routes/app_pages.dart';
import 'package:sertifikasi_irva_pembukuan/app/utility/app_color.dart';
import 'package:sertifikasi_irva_pembukuan/app/utility/database_helper.dart';
import 'package:sertifikasi_irva_pembukuan/app/utility/hash_password.dart';

class SettingController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool obsecureText =
      true.obs; // Untuk mengontrol visibilitas teks kata sandi saat ini
  RxBool obsecureTextNew =
      true.obs; // Untuk mengontrol visibilitas teks kata sandi baru
  TextEditingController passC =
      TextEditingController(); // Controller untuk kata sandi saat ini
  TextEditingController passNewC =
      TextEditingController(); // Controller untuk kata sandi baru
  final DatabaseHelper dbHelper =
      DatabaseHelper.instance; // Objek DatabaseHelper
  final box = GetStorage(); // Objek GetStorage untuk menyimpan data lokal

  // Fungsi untuk mengganti kata sandi pengguna
  Future<void> changePassword() async {
    String currentPassword = passC.text;
    String newPassword = passNewC.text;
    final db = await dbHelper.database;

    // Ambil kata sandi saat ini dari database berdasarkan user ID
    final List<Map<String, dynamic>> users = await db.query(
      'users',
      where: 'id = ?',
      whereArgs: [box.read('user_id')],
    );

    if (users.isNotEmpty) {
      final storedPassword = users[0]['password'] as String;

      // Periksa apakah kata sandi saat ini cocok dengan yang disimpan di database
      if (checkPassword(currentPassword, storedPassword)) {
        // Enkripsi kata sandi baru sebelum disimpan
        final hashedPassword = HashPassword(newPassword);

        // Perbarui kata sandi dalam database
        await db.update(
          'users',
          {'password': hashedPassword},
          where: 'id = ?',
          whereArgs: [box.read('user_id')],
        );

        passC.clear(); // Hapus teks pada field kata sandi saat ini
        passNewC.clear(); // Hapus teks pada field kata sandi baru

        // Tampilkan notifikasi sukses
        Get.snackbar(
          'Berhasil',
          'Password berhasil diperbarui',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColor.primaryColor,
          colorText: Colors.white,
        );
      }
    } else {
      // Password saat ini tidak cocok dengan yang ada di database
      Get.snackbar(
        'Error',
        'Gagal memperbarui password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.secondary,
        colorText: Colors.white,
      );
    }
  }

  // Fungsi untuk memeriksa apakah kata sandi yang dimasukkan cocok dengan yang ada di database
  bool checkPassword(String inputPassword, String storedPassword) {
    // Implementasikan metode enkripsi yang sama seperti yang digunakan sebelumnya
    final hashedInputPassword = HashPassword(inputPassword);

    // Bandingkan password yang dimasukkan dengan yang disimpan di database
    return hashedInputPassword == storedPassword;
  }

  // Fungsi untuk logout pengguna dan menghapus data lokal
  Future<void> logout() async {
    box.remove("user_id"); // Hapus data ID pengguna
    box.remove("username"); // Hapus data username pengguna
    Get.offNamed(Routes.LOGIN); // Kembali ke halaman login
  }

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
}
