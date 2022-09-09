// To parse this JSON data, do
//
//     final seat = seatFromMap(jsonString);

import 'dart:convert';

Seat seatFromMap(String str) => Seat.fromMap(json.decode(str));

String seatToMap(Seat data) => json.encode(data.toMap());

class Seat {
    Seat({
        this.id,
        this.seatNum,
        this.isBooked,
        this.dateCreated,
        this.vehicle,
    });

    int? id;
    int? seatNum;
    bool? isBooked;
    DateTime? dateCreated;
    int? vehicle;

    factory Seat.fromMap(Map<String, dynamic> json) => Seat(
        id: json["id"],
        seatNum: json["seat_num"],
        isBooked: json["is_booked"],
        dateCreated: DateTime.parse(json["date_created"]),
        vehicle: json["vehicle"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "seat_num": seatNum,
        "is_booked": isBooked,
        "date_created": dateCreated!.toIso8601String(),
        "vehicle": vehicle,
    };
}
