// ignore_for_file: prefer_const_declarations, non_constant_identifier_names

import 'dart:convert';
import 'package:crypto/crypto.dart';

String HashPassword(String password) {
  final salt = 'doyatama';
  final bytes = utf8.encode(password + salt);
  final digest = sha256.convert(bytes);
  return digest.toString();
}
