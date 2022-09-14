

class Agency {
    Agency({
        this.id,
        this.name,
        this.address,
        this.phone,
        this.email,
        // this.website,
        // this.dateJoined,
        // this.wallet,
    });

    int? id;
    String? name;
    String? address;
    String? phone;
    String? email;
    // String? website;
    // DateTime? dateJoined;
    // int? wallet;

    factory Agency.fromMap(Map<String, dynamic> json) => Agency(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        phone: json["phone"],
        email: json["email"],
        // website: json["website"],
        // dateJoined: DateTime.parse(json["date_joined"]),
        // wallet: json["wallet"],
    );
}
