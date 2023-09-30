// ignore_for_file: depend_on_referenced_packages

import 'package:get_storage/get_storage.dart';
import 'package:sertifikasi_irva_pembukuan/app/models/cashflow.dart';
import 'package:sertifikasi_irva_pembukuan/app/utility/hash_password.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Buat kelas untuk pembantu basis data
class DatabaseHelper {
  // Buat instance singleton dari pembantu basis data
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // Tentukan properti basis data
  static const _databaseName = 'database.db';
  static const _databaseVersion = 1;
  final box = GetStorage(); // Inisialisasi GetStorage untuk penyimpanan lokal

  Database? _database;

  // Konstruktor privat untuk pola singleton
  DatabaseHelper._privateConstructor();

  // Getter untuk instance basis data
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Inisialisasi basis data
  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  // Buat tabel basis data saat basis data pertama kali dibuat
  Future<void> _onCreate(Database db, int version) async {
    // Buat tabel 'users'
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        username TEXT NOT NULL,
        password TEXT NOT NULL
      )
    ''');

    // Buat tabel 'cashflow'
    await db.execute('''
    CREATE TABLE cashflow (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER NOT NULL,
      date DATE NOT NULL,
      nominal INTEGER NOT NULL,
      description TEXT,
      status TEXT NOT NULL
    )
    ''');
  }

  // Tambahkan pengguna ke tabel 'users'
  Future<void> addUser(String username, String password) async {
    final db = await instance.database;
    await db.insert(
      'users',
      {
        'username': username,
        'password': password,
      },
    );
  }

  // Autentikasi pengguna saat login
  Future<bool> login(String username, String password) async {
    final db = await instance.database;
    final List<Map<String, dynamic>> users = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );

    if (users.isNotEmpty) {
      final storedPassword = users[0]['password'] as String;
      final hashedPassword = HashPassword(password);

      if (storedPassword == hashedPassword) {
        final id =
            users[0]['id'] as int; // Dapatkan ID pengguna dari hasil query

        // Simpan ID pengguna dan nama pengguna dalam GetStorage untuk manajemen sesi
        box.write("user_id", id);
        box.write("username", username);

        return true; // Login berhasil
      }
    }

    return false;
  }

  // Masukkan entri cashflow ke dalam tabel 'cashflow'
  Future<int?> insertCashflow(Map<String, dynamic> row) async {
    final db = await instance.database;
    return await db.insert('cashflow', row);
  }

  // Dapatkan entri cashflow untuk pengguna yang saat ini masuk
  Future<List<CashFlow>> getCashflows() async {
    final db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query(
      'cashflow',
      where: 'user_id = ?',
      whereArgs: [box.read('user_id')],
    );

    return List.generate(maps.length, (i) {
      return CashFlow(
        id: maps[i]['id'],
        user_id: maps[i]['user_id'],
        date: maps[i]['date'],
        nominal: maps[i]['nominal'],
        description: maps[i]['description'],
        status: maps[i]['status'], // Konversi dari integer ke boolean
      );
    });
  }

  // Dapatkan entri cashflow untuk bulan ini dan pengguna yang saat ini masuk
  Future<List<CashFlow>> getCashflowsByMonth() async {
    final db = await instance.database;
    final now = DateTime.now();
    final currentMonth = now.month;
    final currentYear = now.year;

    final List<Map<String, dynamic>> maps = await db.query(
      'cashflow',
      where: 'user_id = ? AND date LIKE ?',
      whereArgs: [box.read('user_id'), "%-$currentMonth-$currentYear"],
    );

    return List.generate(maps.length, (i) {
      return CashFlow(
        id: maps[i]['id'],
        user_id: maps[i]['user_id'],
        date: maps[i]['date'],
        nominal: maps[i]['nominal'],
        description: maps[i]['description'],
        status: maps[i]['status'], // Konversi dari integer ke boolean
      );
    });
  }
}
