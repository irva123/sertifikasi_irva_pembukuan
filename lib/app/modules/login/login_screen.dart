// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, deprecated_member_use, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sertifikasi_irva_pembukuan/app/utility/app_color.dart';
import 'package:sertifikasi_irva_pembukuan/app/widgets/custom_input.dart';
import 'login_controller.dart';

// ignore: must_be_immutable
class LoginScreen extends GetView<LoginController> {
  late double mWidth;
  late double mHeight;

  @override
  Widget build(BuildContext context) {
    mWidth = MediaQuery.of(context).size.width;
    mHeight = MediaQuery.of(context).size.height;

    // Scaffold adalah widget utama untuk tampilan halaman login.
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: mHeight,
        margin: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Bagian atas halaman, termasuk logo dan judul aplikasi.
            Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Image.asset(
                  'assets/images/logo.png',
                  width: mWidth / 1.5,
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'MyBudget',
                      style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'montserrat',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
                      'V 1.0',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'montserrat',
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ],
                )
              ],
            ),

            //form untuk login
            Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomInput(
                    controller: controller.usernameC,
                    label: "Username",
                    hint: "Masukkan username anda",
                  ),
                  CustomInput(
                    controller: controller.passC,
                    label: "Password",
                    hint: "Masukkan password anda",
                    obsecureText: controller.obsecureText.value,
                    suffixIcon: IconButton(
                      icon: (controller.obsecureText != false)
                          ? SvgPicture.asset('assets/icons/show.svg')
                          : SvgPicture.asset('assets/icons/hide.svg'),
                      onPressed: () {
                        controller.obsecureText.value =
                            !(controller.obsecureText.value);
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Tombol untuk melakukan login.
            Obx(
              () => Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () async {
                    if (controller.isLoading.isFalse) {
                      await controller.login();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 18),
                    elevation: 0,
                    primary: Color.fromARGB(255, 44, 0, 61),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    (controller.isLoading.isFalse) ? 'Masuk' : 'Loading...',
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: 'montserrat',
                      fontWeight: FontWeight.w500,
                    ),
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
