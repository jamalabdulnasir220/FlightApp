import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:theo/model/search_trip.dart';
import 'package:theo/model/seat.dart';
import 'package:theo/model/ticket.dart';
import 'package:theo/model/trip.dart';

class BackendApi {
  static String _domain = "http://159.65.204.202/api";
  static String _token = "";
  static late int _userId;

  static Map<String, String> headers = {'content-type': "application/json"};

  static Future<bool> login({
    String email = "test@gmail.com",
    String password = "theo",
  }) async {
    Response res = await post(
      Uri.parse("$_domain/login/"),
      headers: headers,
      body: jsonEncode(
        {
          "username": email,
          "password": password,
        },
      ),
    );
    if (res.statusCode == 200) {
      log("Login successfull");
      _token = jsonDecode(res.body)['token'];
      headers.addAll({'authorization': "Token $_token"});
      return true;
    } else {
      log("Login Error: ${res.statusCode} ${res.body}");
      return false;
    }
  }

  static signUp({
    String firstName = "Jamal",
    String lastName = "Abdul",
    String email = "test@gmail.com",
    String password = "theo",
  }) async {
    Response res = await post(
      Uri.parse("$_domain/sign-up/"),
      headers: headers,
      body: jsonEncode(
        {
          "first_name": firstName,
          "last_name": lastName,
          "email": email,
          "password": password,
        },
      ),
    );
    if (res.statusCode == 200) {
      log("signUp successfull");
      return true;
    } else {
      log("signUp Error: ${res.statusCode} ${res.body}");
      return false;
    }
  }

  static getUserProfile() async {
    Response res = await post(Uri.parse("$_domain/user-profile/"),
        headers: headers, body: jsonEncode({'token': _token}));
    if (res.statusCode == 200) {
      log("User Profile successfull");
      _userId = jsonDecode(res.body)['user']['id'];
      return true;
    } else {
      log("User Profile Error: ${res.statusCode} ${res.body}");
      return false;
    }
  }

  static getTrips() async {
    Response res = await get(Uri.parse("$_domain/all-trips"), headers: headers);

    if (res.statusCode == 200) {
      log("GetTrips Successfull");
    } else {
      log("getTrips Error: ");
    }
  }

  static Future<List<Trip>> searchTrip(SearchTrip searchTrip) async {
    Response res = await post(
      Uri.parse("$_domain/search-trips/"),
      headers: headers,
      body: jsonEncode(searchTrip.toMap()),
    );

    if (res.statusCode == 200) {
      log("searchTrip Successfull");
      List tripData = jsonDecode(res.body);
      return tripData.map((trip) => Trip.fromMap(trip)).toList();
    } else if (res.statusCode == 404) {
      return []; //NOT FOUND
    } else {
      log("searchTrip Error: ");
      throw res.body;
    }
  }

  static Future<List<Seat>> getVehicleSeats(id) async {
    Response res = await post(Uri.parse("$_domain/get-vehicle-seats/"),
        headers: headers, body: jsonEncode({'vehicle': id}));

    if (res.statusCode == 200) {
      log("getVehicleSeat successfull");
      List seatData = jsonDecode(res.body);
      return seatData.map((e) => Seat.fromMap(e)).toList();
    } else {
      log("getVehicleSeats Error: ");
      throw res.body;
    }
  }

  // static getBusAgencies() async {
  //   Response res = await get(Uri.parse("$_domain/"), headers: {
  //     'content-type': 'application/json',
  //     'authorization': "Token $_token"
  //   });

  //   if (res.statusCode == 200) {
  //   } else {
  //     log("getBusAgencies: ");
  //   }
  // }

  static getFlightAgencies() {}

  static Future<dynamic> bookTrip(tripId, seatIds) async {
    Response res = await post(
      Uri.parse("$_domain/book-trip/"),
      headers: headers,
      body: jsonEncode(
        {
          "trip": tripId,
          "seats": seatIds,
          'user': _userId,
        },
      ),
    );
    if (res.statusCode == 201) {
      log(jsonDecode(res.body).toString());
      Map results = jsonDecode(res.body);
      List resList = jsonDecode(results['booking']);
      log(resList.first['pk'].toString());
      log("bookTrip successfull");
      return resList.first['pk'];
    } else {
      log("bookTrip Error: ${res.statusCode} ${res.body}");
      return false;
    }
  }

  static makePayment({phone, amount = 1, bookingId, network = "VOD"}) async {
    Response res = await post(Uri.parse("$_domain/pay-for-trip/"),
        headers: headers,
        body: jsonEncode({
          "network": network,
          'source_phone': phone,
          'amount': amount,
          'booking': bookingId,
        }));

    if (res.statusCode == 200) {
      log("makePayment successfull");
    } else {
      log("makePayment Error: ${res.statusCode}");
    }
  }

  static Future<List<Ticket>> getTickets() async {
    Response res = await post(
      Uri.parse("$_domain/user-tickets/"),
      headers: headers,
      body: jsonEncode(
        {'user': _userId},
      ),
    );

    if (res.statusCode == 200) {
      log("getTicets successful");
      List ticketsData = jsonDecode(res.body);
      return ticketsData.map((tic) => Ticket.fromMap(tic)).toList();
    } else {
      log("getTickets Error: ${res.statusCode}");
      throw "getTickets Error";
    }
  }
}
