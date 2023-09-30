import 'package:get/get.dart';
import 'login_controller.dart';

// Kelas ini adalah bagian dari manajemen dependencies (ketergantungan) di GetX.
// Binding digunakan untuk menghubungkan (bind) controller dengan view atau halaman tertentu.
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    // Get.lazyPut digunakan untuk menginisialisasi LoginController ketika diperlukan
    // dan menyimpannya dalam penyimpanan yang efisien sehingga tidak perlu
    // menginisialisasi ulang controller setiap kali diperlukan.
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}
