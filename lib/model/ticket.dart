class Ticket {
  Ticket(
      {this.user,
      this.agency,
      this.vehicleNumber,
      this.bookingCode,
      this.source,
      this.destination,
      this.date,
      this.time,
      this.seats,
      this.amount,
      this.ticketId,
      this.tripType});

  String? user;
  String? agency;
  String? vehicleNumber;
  String? bookingCode;
  String? source;
  String? destination;
  DateTime? date;
  String? time;
  String? seats;
  double? amount;
  String? ticketId;
  String? tripType;

  factory Ticket.fromMap(
          {required Map<String, dynamic> json, isBookings = false}) =>
      Ticket(
        user: json["user"],
        agency: json["agency"],
        vehicleNumber: json["vehicle_number"],
        bookingCode: json["booking_code"],
        source: json["source"],
        destination: json["destination"],
        date: DateTime.parse(json[isBookings ? "departure_date" : "date"]),
        time: json[isBookings ? "departure_time" : "time"],
        seats: json["seats"],
        amount: isBookings ? json['price'] : json["amount"],
        ticketId: json["ticket_id"],
        tripType: isBookings ? null : json['trip_type'],
      );

  // Map<String, dynamic> toMap() => {
  //     "user": user,
  //     "agency": agency,
  //     "vehicle_number": vehicleNumber,
  //     "booking_code": bookingCode,
  //     "source": source,
  //     "destination": destination,
  //     "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
  //     "time": time,
  //     "seats": seats,
  //     "amount": amount,
  //     "ticket_id": ticketId,
  // };
}
