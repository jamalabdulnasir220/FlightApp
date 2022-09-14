// To parse this JSON data, do
//
//     final trip = tripFromMap(jsonString);

import 'dart:convert';

Trip tripFromMap(String str) => Trip.fromMap(json.decode(str));

String tripToMap(Trip data) => json.encode(data.toMap());

class Trip {
  Trip({
    this.id = 1,
    this.source = "Accra",
    this.destination = "Kumasi",
    this.date,
    this.time,
    this.dateCreated,
    this.vehicle,
    this.price = "25",
  });

  int? id;
  String? source;
  String? destination;
  DateTime? date;
  String? time;
  DateTime? dateCreated;
  int? vehicle;
  String? price;

  factory Trip.fromMap(Map<String, dynamic> json) => Trip(
        id: json["id"],
        source: json["source"],
        destination: json["destination"],
        date: DateTime.parse(json["date"]),
        time: json["time"],
        dateCreated: DateTime.parse(json["date_created"]),
        vehicle: json["vehicle"],
        price: json['price'],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "source": source,
        "destination": destination,
        "date": date!.toIso8601String(),
        "time": time,
        "date_created": dateCreated!.toIso8601String(),
        "vehicle": vehicle,
      };
}
