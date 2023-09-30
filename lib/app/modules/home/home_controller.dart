// ignore_for_file: unnecessary_overrides, avoid_print

import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:sertifikasi_irva_pembukuan/app/models/cashflow.dart';
import 'package:sertifikasi_irva_pembukuan/app/utility/database_helper.dart';
import 'package:sertifikasi_irva_pembukuan/app/utility/extract_month.dart';

class HomeController extends GetxController {
  final dbHelper = DatabaseHelper.instance;
  RxList<CashFlow> cashflows = RxList<CashFlow>();

  // Deklarasi dan inisialisasi list data incomeSpots dan expenseSpots (digunakan pada flchart)
  RxList<FlSpot> incomeSpots = RxList<FlSpot>();
  RxList<FlSpot> expenseSpots = RxList<FlSpot>();

  // Fungsi ini digunakan untuk memuat daftar cashflow dari database lokal
  void loadCashflows() async {
    final cashflowList = await dbHelper.getCashflows();
    cashflows.assignAll(cashflowList);

    // Isi data incomeSpots dan expenseSpots dengan data yang baru dimuat
    fillSpotsFromCashflows(cashflowList);

    // Memperbarui tampilan widget
    update();
  }

  // Fungsi ini mengisi data incomeSpots dan expenseSpots dari daftar cashflow
  void fillSpotsFromCashflows(List<CashFlow> cashflows) {
    // Membersihkan list sebelum mengisi ulang
    incomeSpots.clear();
    expenseSpots.clear();

    // Buat map untuk mengelompokkan nilai berdasarkan tanggal
    final incomeMap = <double, double>{};
    final expenseMap = <double, double>{};

    // Iterasi melalui cashflows
    for (final cashflow in cashflows) {
      final date = cashflow.date; // Ubah sesuai dengan format tanggal Anda
      final nominal =
          cashflow.nominal.toDouble(); // Konversi ke tipe data double

      // Tentukan apakah ini income atau expense berdasarkan status
      if (cashflow.status == 'income') {
        if (incomeMap.containsKey(extractMonth(date))) {
          // Jika tanggal sudah ada, tambahkan nominal ke nilai yang sudah ada
          incomeMap[extractMonth(date)] =
              (incomeMap[extractMonth(date)] ?? 0) + nominal;
        } else {
          // Jika tanggal belum ada, tambahkan sebagai kunci baru
          incomeMap[extractMonth(date)] = nominal;
        }
      } else if (cashflow.status == 'expense') {
        if (expenseMap.containsKey(extractMonth(date))) {
          // Jika tanggal sudah ada, tambahkan nominal ke nilai yang sudah ada
          expenseMap[extractMonth(date)] =
              (expenseMap[extractMonth(date)] ?? 0) + nominal;
        } else {
          // Jika tanggal belum ada, tambahkan sebagai kunci baru
          expenseMap[extractMonth(date)] = nominal;
        }
      }
    }

    // Konversi map menjadi daftar FlSpot
    incomeSpots.addAll(
        incomeMap.entries.map((entry) => FlSpot(entry.key, entry.value)));
    expenseSpots.addAll(
        expenseMap.entries.map((entry) => FlSpot(entry.key, entry.value)));

    // Cetak data untuk tujuan debugging
    print(incomeSpots);
    print(expenseSpots);
  }

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

  // Fungsi ini digunakan untuk memulai ulang pengisian data
  void reInitialize() {
    onInit();
  }
}
