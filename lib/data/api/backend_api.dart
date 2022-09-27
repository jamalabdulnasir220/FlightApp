import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart';
import 'package:theo/model/agency.dart';
import 'package:theo/model/category.dart';
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
    String email = "stc1@gmail.com",
    String password = "1234567",
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
    } else {
      log("signUp Error: ${res.statusCode} ${res.body}");
      throw jsonDecode(res.body);
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

  static Future<List<Category>> getCategories() async {
    Response res = await get(
      Uri.parse("$_domain/categories/"),
      headers: headers,
    );

    if (res.statusCode == 200) {
      log("getCategories Successfull");
      List catData = jsonDecode(res.body);
      return catData.map((e) => Category.fromMap(e)).toList();
    } else {
      log("getCategories Error");
      throw res.body;
    }
  }

  static Future<List<Agency>> getAgencies({catId = 1}) async {
    Response res = await post(
      Uri.parse("$_domain/all-agencies/"),
      headers: headers,
      body: jsonEncode({"category": catId}),
    );

    if (res.statusCode == 200) {
      log("getAgencies Successfull");
      List agencyData = jsonDecode(res.body);
      return agencyData.map((e) => Agency.fromMap(e)).toList();
    } else {
      log("getAgencies Error");
      throw res.body;
    }
  }

  static Future<List<String>> getLocations() async {
    Response res = await get(
      Uri.parse("$_domain/locations/"),
      headers: headers,
    );

    if (res.statusCode == 200) {
      log("getLocation successful");
      List result = jsonDecode(res.body)['locations'];
      return <String>[...result];
    } else {
      log("getLocations Error: ${res.statusCode}");
      throw res.body;
    }
  }

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

  static Future<String?> makePayment(
      {phone, amount = 1, bookingId, network = "VOD"}) async {
    Response res = await post(
      Uri.parse("$_domain/pay-for-trip/"),
      headers: headers,
      body: jsonEncode(
        {
          "network": network,
          'source_phone': phone,
          'amount': amount,
          'booking': bookingId,
        },
      ),
    );

    if (res.statusCode == 200) {
      log("makePayment successfull");
      Map<String, dynamic> resData = jsonDecode(res.body);
      if (resData['data']['status_code'] == "000") {
        // transaction successful
        return resData['data']['transaction_id'];
      } else if (resData['data']["status_code"] == "004" ||
          resData['data']["status_code"] == "007") {
        // transaction pending
        return "";
      } else {
        // transaction failed
        return null;
      }
    } else {
      log("makePayment Error: ${res.statusCode}");
      return null;
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
      return ticketsData.map((tic) => Ticket.fromMap(json: tic)).toList();
    } else {
      log("getTickets Error: ${res.statusCode}");
      throw "getTickets Error";
    }
  }

  static getTicket(transId) async {
    Response res = await post(
      Uri.parse("$_domain/get-ticket/"),
      headers: headers,
      body: jsonEncode(
        {'transaction_id': transId},
      ),
    );

    if (res.statusCode == 200) {
      log("getTicket successful");
      Map<String, dynamic> ticketData = jsonDecode(res.body)['ticket_data'];
      return Ticket.fromMap(json: ticketData);
    } else {
      log("getTicket Error ${res.statusCode}");
    }
  }

  static Future<List<Ticket>> getUserTickets() async {
    Response res = await post(
      Uri.parse("$_domain/user-tickets/"),
      headers: headers,
      body: jsonEncode(
        {'user': _userId},
      ),
    );

    if (res.statusCode == 200) {
      log("getUserTickets Success");
      try {
        List ticketData = jsonDecode(res.body)['user_tickets'];
        return ticketData
            .map((t) => Ticket.fromMap(json: t, isBookings: true))
            .toList();
      } catch (e) {
        log(e.toString());
        throw e.toString();
      }
    } else {
      log("getUserTickets Error ${res.statusCode}");
      throw res.body;
    }
  }
}
