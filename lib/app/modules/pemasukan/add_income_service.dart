// Mengimpor package 'get' yang diperlukan untuk menggunakan fitur GetX.
import 'package:get/get.dart';

// Mengimpor AddIncomeController yang akan dihubungkan dengan halaman atau widget.
import 'add_income_controller.dart';

// Membuat class AddIncomeBinding yang merupakan turunan dari Bindings (binding).
class AddIncomeBinding extends Bindings {
  @override
  void dependencies() {
    // Pada saat dependencies() dipanggil, kita mendefinisikan ketergantungan (dependencies).
    // Dalam hal ini, kita menggunakan Get.lazyPut untuk menginisialisasi AddIncomeController
    // secara "lazy", artinya controller hanya akan dibuat ketika pertama kali dibutuhkan.
    Get.lazyPut<AddIncomeController>(
      () => AddIncomeController(),
    );
  }
}
