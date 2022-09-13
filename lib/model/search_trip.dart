class SearchTrip {
  String? date;
  String? source;
  String? dest;
  int? agencyId;

  SearchTrip({this.agencyId = 1});

  toMap() => {
        'date': date,
        'source': source,
        'destination': dest,
        'agency': agencyId,
      };
}
