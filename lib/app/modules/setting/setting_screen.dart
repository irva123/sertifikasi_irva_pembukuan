// ignore_for_file: use_key_in_widget_constructors, unrelated_type_equality_checks, sized_box_for_whitespace, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sertifikasi_irva_pembukuan/app/routes/app_pages.dart';
import 'package:sertifikasi_irva_pembukuan/app/utility/app_color.dart';
import 'package:sertifikasi_irva_pembukuan/app/widgets/custom_input.dart';
import 'setting_controller.dart';

// ignore: must_be_immutable
class SettingScreen extends GetView<SettingController> {
  late double mWidth;
  late double mHeight;
  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height / 1.2;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 59, 5, 66),
        title: const Text('Pengaturan'), // Judul halaman
        centerTitle: true,
      ),
      bottomNavigationBar: Container(
        height: mHeight / 7,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Image.asset(
              "assets/images/irva.jpg", // Gambar profil atau identitas pembuat aplikasi
              width: mWidth / 3,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "About this app...", // Informasi tentang aplikasi
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 5), // Spasi
                Text("Aplikasi ini dibuat oleh:"), // Info pembuat
                Text("Nama\t\t\t  : Irva Putri Finisha"), // Nama pembuat
                Text("NIM\t\t\t\t\t\t  : 2141764103"), // NIM pembuat
                Text("Tanggal\t: 29 September 2023"), // Tanggal pembuatan
              ],
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: mHeight,
          margin: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ganti Password', // Judul untuk mengganti kata sandi
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'montserrat',
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline, // Tambahkan garis bawah
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => CustomInput(
                  controller: controller.passC,
                  label: "Password Saat Ini",
                  hint: "Masukkan password anda saat ini",
                  obsecureText: controller
                      .obsecureText.value, // Kontrol visibilitas teks saat ini
                  suffixIcon: IconButton(
                    icon: (controller.obsecureText != false)
                        ? SvgPicture.asset('assets/icons/show.svg')
                        : SvgPicture.asset('assets/icons/hide.svg'),
                    onPressed: () {
                      controller.obsecureText.value = !(controller.obsecureText
                          .value); // Toggle visibilitas teks saat ini
                    },
                  ),
                ),
              ),
              Obx(
                () => CustomInput(
                  controller: controller.passNewC,
                  label: "Password Baru",
                  hint: "Masukkan password baru anda",
                  obsecureText: controller.obsecureTextNew
                      .value, // Kontrol visibilitas teks kata sandi baru
                  suffixIcon: IconButton(
                    icon: (controller.obsecureTextNew != false)
                        ? SvgPicture.asset('assets/icons/show.svg')
                        : SvgPicture.asset('assets/icons/hide.svg'),
                    onPressed: () {
                      controller.obsecureTextNew.value = !(controller
                          .obsecureTextNew
                          .value); // Toggle visibilitas teks kata sandi baru
                    },
                  ),
                ),
              ),
              Obx(
                () => Container(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (controller.isLoading.isFalse) {
                        await controller.changePassword();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      elevation: 0,
                      primary: Color.fromARGB(255, 63, 72, 100),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      (controller.isLoading.isFalse) ? 'Simpan' : 'Loading...',
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
              Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    Get.back(); // Kembali ke halaman sebelumnya
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    elevation: 0,
                    primary: AppColor.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    '<< Kembali', // Tombol kembali
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
              Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    Get.offAllNamed(Routes.LOGIN); // Kembali ke halaman login
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    elevation: 0,
                    primary: AppColor.warning,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Logout', // Tombol logout
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
      ),
    );
  }
}
