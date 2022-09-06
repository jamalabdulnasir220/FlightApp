import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final registrationUri = Uri.parse("http://104.248.50.27/api/sign-up/");
  
  Future<String> registration(String firstname, String lastname, String email, String password) async {
    var response = await http.post(registrationUri, body: {
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      "password": password
    });
    return response.body;
  }
}