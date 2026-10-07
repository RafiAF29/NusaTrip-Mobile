import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/destination.dart';
import '../models/user_model.dart';

class ApiService {
  // ALAMAT IP:
  // • 'http://10.0.2.2:8080/api'  ➔ Untuk Emulator Android
  // • 'http://127.0.0.1:8080/api' ➔ Untuk Windows Desktop
  static const String baseUrl = 'http://10.0.2.2:8080/api';

  // 1. Ambil Katalog Destinasi dari Laravel MySQL
  static Future<List<Destination>> getDestinations({String? category}) async {
    String url = '$baseUrl/destinations';
    if (category != null && category.isNotEmpty && category != 'Semua') {
      url += '?category=$category';
    }

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      return body.map((json) => Destination.fromJson(json)).toList();
    } else {
      throw Exception('Gagal memuat destinasi');
    }
  }

  // 2. Login Pengguna ke Server Laravel & Cek Password Ter-hash MySQL
  static Future<UserModel?> loginUser({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data['user']);
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message'] ?? 'Email atau password salah');
    }
  }

  // 3. Registrasi Pengguna Baru ke Database MySQL via Laravel
  static Future<UserModel?> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return UserModel.fromJson(data['user']);
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message'] ?? 'Gagal mendaftarkan akun');
    }
  }
}