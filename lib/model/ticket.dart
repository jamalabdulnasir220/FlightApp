class Ticket {
    Ticket({
        this.id,
        this.ticketId,
        // this.dateCreated,
        this.transaction,
    });

    int? id;
    String? ticketId;
    // DateTime? dateCreated;
    int? transaction;

    factory Ticket.fromMap(Map<String, dynamic> json) => Ticket(
        id: json["id"],
        ticketId: json["ticket_id"],
        // dateCreated: DateTime.parse(json["date_created"]),
        transaction: json["transaction"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "ticket_id": ticketId,
        // "date_created": dateCreated.toIso8601String(),
        "transaction": transaction,
    };
}