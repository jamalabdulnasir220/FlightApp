class SearchTrip {
  String? date;
  String? source;
  String? dest;
  int? catId;
  int? agencyId;

  SearchTrip({this.agencyId = 1, this.source = "Accra", this.dest = "Kumasi"});

  toMap() => {
        'date': date,
        'source': source,
        'destination': dest,
        'agency': agencyId,
        'category': catId,
      };
}
