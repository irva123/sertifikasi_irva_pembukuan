// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_local_variable, prefer_const_literals_to_create_immutables, unused_element
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sertifikasi_irva_pembukuan/app/modules/home/widgets/flchart_widget.dart';
import 'package:sertifikasi_irva_pembukuan/app/modules/home/widgets/menu_widget.dart';
import 'package:sertifikasi_irva_pembukuan/app/routes/app_pages.dart';
import 'package:sertifikasi_irva_pembukuan/app/utility/app_color.dart';
import 'package:sertifikasi_irva_pembukuan/app/utility/currency_format.dart';
import 'home_controller.dart';

//Nama Mahasiswa : Raden Dimas Erlangga SIB 4F
//NIM : 2141764121
//Nama Asesor : EKOJONO, ST., M.KOM

class HomeScreen extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final mWidth = MediaQuery.of(context).size.width;
    final mHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 20), // Spacing above "Rangkuman Bulan Ini"

            // Bagian Ringkasan Pemasukan dan Pengeluaran Bulan Ini
            _buildSummaryContainer(mWidth),
            const SizedBox(height: 40),

            // Bagian Grafik Garis untuk Data Cash Flow
            _buildChartContainer(),

            // Bagian Menu-Menu Aplikasi
            _buildMenuGrid(),
          ],
        ),
      ),
    );
  }

  // Bagian Ringkasan Pemasukan dan Pengeluaran Bulan Ini
  Widget _buildSummaryContainer(double mWidth) {
    return Obx(
      () {
        int totalIncome = 0;
        int totalExpense = 0;

        // Loop melalui data pemasukan dan pengeluaran dalam controller
        for (final cashflow in controller.cashflows) {
          if (cashflow.status == "income") {
            totalIncome += cashflow.nominal;
          } else if (cashflow.status == "expense") {
            totalExpense += cashflow.nominal;
          }
        }

        return Column(
          children: [
            SizedBox(height: 10), // Spacing above the text

            // Judul "Rangkuman Bulan Ini" with shadow
            Text(
              'Rangkuman Bulan Ini',
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.w800,
                shadows: [
                  Shadow(
                    color: Color.fromARGB(255, 0, 0, 0),
                    offset: Offset(0, 1), // Shadow position
                    blurRadius: 1, // SShadow blur radius
                  ),
                ],
              ),
            ),

            // Total Pengeluaran with shadow
            Text(
              'Pengeluaran ${FormattedNominal(totalExpense)}',
              style: TextStyle(
                color: Color.fromARGB(255, 255, 81, 81),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                shadows: [
                  Shadow(
                    color: Color.fromARGB(255, 168, 168, 168),
                    offset: Offset(0, 1), // Shadow position
                    blurRadius: 1, // S// Shadow blur radius
                  ),
                ],
              ),
            ),

            // Total Pemasukan with shadow
            Text(
              "Pemasukan ${FormattedNominal(totalIncome)}",
              style: TextStyle(
                color: Color.fromARGB(255, 0, 255, 17),
                fontSize: 14,
                fontWeight: FontWeight.w500,
                shadows: [
                  Shadow(
                    color: Color.fromARGB(255, 168, 168, 168),
                    offset: Offset(0, 1), // Shadow position
                    blurRadius: 1, // Shadow blur radius
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

// Bagian Grafik Garis untuk Data Cash Flow
  Widget _buildChartContainer() {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        height: 200,
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: const FlChartWidget(
          isShowingMainData: true,
        ),
      ),
    );
  }

  // Bagian Menu-Menu Aplikasi
  Widget _buildMenuGrid() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildMenuCard(
            title: 'Tambah Pemasukan',
            image: AssetImage('assets/images/pemasukan.png'),
            onTap: () => Get.toNamed(Routes.ADD_INCOME),
          ),
          _buildMenuCard(
            title: 'Tambah Pengeluaran',
            image: AssetImage('assets/images/pengeluaran.png'),
            onTap: () => Get.toNamed(Routes.ADD_EXPENSE),
          ),
          _buildMenuCard(
            title: 'Detail Cash Flow',
            image: AssetImage('assets/images/detail.png'),
            onTap: () => Get.toNamed(Routes.DETAIL_CASH_FLOW),
          ),
          _buildMenuCard(
            title: 'Pengaturan',
            image: AssetImage('assets/images/pengaturan.png'),
            onTap: () => Get.toNamed(Routes.SETTING),
          ),
        ],
      ),
    );
  }

// wrap pilihan menu untuk efek elevation
  Widget _buildMenuCard({
    required String title,
    required AssetImage image,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        child: MenuItem(
          title: title,
          image: image,
        ),
      ),
    );
  }

  // Fungsi untuk membuat item menu
  Widget _buildMenuItem({
    required String title,
    required AssetImage image,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: MenuItem(
        title: title,
        image: image,
      ),
    );
  }
}
