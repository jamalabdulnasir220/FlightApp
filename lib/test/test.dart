import 'dart:convert';
import 'package:http/http.dart' as http;

main() async {
  AuthService authService = AuthService();
  var responseBody = await authService.registration("abdallah", "saeed", "imama@gmail.com", "1234");
  print(responseBody);
}

class AuthService {
  final registrationUri = Uri.parse("http://104.248.50.27/api/sign-up/");

  Future<String> registration(String firstname, String lastname, String email, String password) async {

    var response = await http.post(registrationUri, body: {
    "first_name":firstname,
    "last_name": lastname,
    "email":email,
    "password":password,
  });
    return response.body;
}
}