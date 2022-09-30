import 'package:flutter_test/flutter_test.dart';
import 'package:theo/model/search_trip.dart';

void main() {
  test("i want to test whether the default value for the agency is 1", () {
    // step 1
    SearchTrip searchTrip = SearchTrip();

    // step 2
    int result = searchTrip.agencyId!;

    // step 3
    expect(result, 1);
  });
}
