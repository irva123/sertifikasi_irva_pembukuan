// ignore_for_file: unnecessary_overrides
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sertifikasi_irva_pembukuan/app/routes/app_pages.dart';
import 'package:sertifikasi_irva_pembukuan/app/utility/app_color.dart';
import 'package:sertifikasi_irva_pembukuan/app/utility/database_helper.dart';
import 'package:sertifikasi_irva_pembukuan/app/utility/hash_password.dart';

class LoginController extends GetxController {
  // Variabel RxBool digunakan untuk membuat variabel yang dapat di-observe (diamati) perubahan nilainya.
  RxBool isLoading = false.obs; // Mengamati status loading.
  RxBool obsecureText =
      true.obs; // Mengamati apakah teks password bersifat tersembunyi.
  TextEditingController usernameC = TextEditingController();
  TextEditingController passC = TextEditingController();

  @override
  void onInit() {
    // Fungsi onInit() dijalankan ketika controller ini diinisialisasi.
    // Di sini, kita menambahkan pengguna awal ke database.
    final hashedPassword = HashPassword('user');
    DatabaseHelper.instance.addUser("user", hashedPassword);
    super.onInit(); // Memanggil onInit() dari kelas induk.
  }

  @override
  void onReady() {
    // Fungsi onReady() dijalankan ketika controller ini siap digunakan.
    super.onReady(); // Memanggil onReady() dari kelas induk.
  }

  @override
  void onClose() {
    // Fungsi onClose() dijalankan ketika controller ini ditutup atau tidak lagi digunakan.
    super.onClose(); // Memanggil onClose() dari kelas induk.
  }

  Future<void> login() async {
    // Fungsi ini digunakan untuk meng-handle proses login.
    final username = usernameC.text;
    final password = passC.text;

    if (username.isEmpty || password.isEmpty) {
      // Menampilkan pesan jika username atau password kosong.
      Get.snackbar(
        'Tidak bisa login',
        'Masukkan username atau password',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.warning,
        colorText: Colors.white,
      );
      return;
    }

    try {
      // Mencoba melakukan login dengan username dan password yang dimasukkan.
      final isLoginSuccessful =
          await DatabaseHelper.instance.login(username, password);

      if (isLoginSuccessful) {
        // Jika login berhasil, navigasi ke halaman HOME dan tampilkan pesan selamat datang.
        Get.offNamed(Routes.HOME);
        Get.snackbar(
          'Selamat Datang',
          'Terima kasih',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColor.primaryColor,
          colorText: Colors.white,
        );
      } else {
        // Jika login gagal, tampilkan pesan kesalahan.
        Get.snackbar(
          'Login Telah Gagal',
          'Username atau password salah',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColor.secondary,
          colorText: Colors.white,
        );
      }
    } catch (error) {
      // Tangani kesalahan jika terjadi error.
      Get.snackbar(
        'Error !!!',
        'Terjadi kesalahan pada: $error',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppColor.secondary,
        colorText: Colors.white,
      );
    }
  }
}
