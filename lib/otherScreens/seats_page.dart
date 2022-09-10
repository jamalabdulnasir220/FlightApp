import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:theo/data/api/backend_api.dart';
import 'package:theo/model/seat.dart';
import 'package:theo/otherScreens/enter_details.dart';
import 'package:theo/otherScreens/payment_method.dart';
import '../components/flight_model.dart';

class SeatsGridPage extends StatefulWidget {
  List<Seat> seats;
  String tripId;
  double price;
  final bool flight;
  SeatsGridPage(
      {required this.flight,
      required this.seats,
      required this.price,
      required this.tripId});

  @override
  _SeatsGridPageState createState() => _SeatsGridPageState();
}

class _SeatsGridPageState extends State<SeatsGridPage> {
  List<int> seatsSelected = [];
  int seatTotal = 50;
  double price = 48.00;
  List unavailableSeats = [1, 3, 6, 9, 15, 18, 20, 11, 13];

  getSeatNumbers() {
    List<String> seatNumbers;
    //the following code converts a list of seat ids to a list of indexes +1 to
    // be used as seat Numbers.
    seatNumbers = seatsSelected
        .map((seatId) =>
            (widget.seats.indexWhere((seat) => seat.id == seatId) + 1)
                .toString())
        .toList();
    return seatNumbers.join(",");
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: HexColor('#f5f5f5'),
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: Text("Choose your seat"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    // row with the legend
                    legend(context),

                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(top: 20),
                      padding:
                          EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                      height: (height / 2),
                      width: width,
                      child: GridView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.seats.length,
                        itemBuilder: (BuildContext context, int index) {
                          Seat thisSeat = widget.seats[index];
                          return InkWell(
                              onTap: () {
                                if (!thisSeat.isBooked! &&
                                    !seatsSelected.contains(thisSeat.id)) {
                                  if (mounted) {
                                    setState(() {
                                      if (!seatsSelected
                                          .contains(thisSeat.id)) {
                                        seatsSelected.add(thisSeat.id!);
                                      }
                                      log(seatsSelected.toString());
                                      print(seatsSelected);
                                    });
                                  }
                                } else if (seatsSelected
                                    .contains(thisSeat.id)) {
                                  if (mounted) {
                                    setState(() {
                                      seatsSelected.remove(thisSeat.id);
                                      print(seatsSelected);
                                    });
                                  }
                                }
                              },
                              child: SeatCard(
                                selectedSeat: seatsSelected,
                                seatId: thisSeat.id!,
                                seatNumber: index + 1,
                                isBooked: !thisSeat.isBooked!,
                                // available:
                                //     !unavailableSeats.contains((index + 1)),
                              ));
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            childAspectRatio: 0.6,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 10),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: height / 5,
              width: width,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30))),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Your Seat',
                              style: TextStyle(
                                  color: HexColor('a0a0a0'),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            ),
                            if (seatsSelected.isNotEmpty)
                              Container(
                                  constraints:
                                      BoxConstraints(maxWidth: width / 2),
                                  child: Text(
                                    getSeatNumbers(),
                                    // 'Seat ${seatsSelected.map((value) => seatsSelected.indexOf(value) + 1).toList().toString().substring(1, seatsSelected.toString().length - 1)}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 16),
                                  )),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Price',
                              style: TextStyle(
                                  color: HexColor('a0a0a0'),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            ),
                            if (seatsSelected.isNotEmpty)
                              Text(
                                'GHC ${widget.price * (seatsSelected.length)}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16),
                              ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () async {
                        if (seatsSelected.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              behavior: SnackBarBehavior.floating,
                              content: Text(
                                "No seat selected.",
                              ),
                            ),
                          );
                        } else {
                          dynamic bookingId = await BackendApi.bookTrip(
                              widget.tripId, seatsSelected);
                          if (bookingId != null) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => PaymentMethod(
                                  bookingId: bookingId,
                                  amount: widget.price * (seatsSelected.length),
                                  flight: widget.flight,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Coudn't book trip, try again"),
                              ),
                            );
                          }
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (_) => EnterDetails(
                          //       flight: widget.flight,
                          //     ),
                          //   ),
                          // );
                        }
                      },
                      child: Container(
                        width: width,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blueAccent),
                        child: Center(
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Row legend(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //selected
        Row(
          children: [
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(5)),
            ),
            SizedBox(width: 10),
            Text(
              'Selected',
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText2?.color,
                  fontWeight: FontWeight.w700,
                  fontSize: 14),
            )
          ],
        ),

        //available
        Row(
          children: [
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.blueAccent,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Available',
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText2?.color,
                  fontWeight: FontWeight.w700,
                  fontSize: 14),
            )
          ],
        ),

        //not available
        Row(
          children: [
            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                  color: HexColor('#A0A0A0'),
                  borderRadius: BorderRadius.circular(5)),
              child: const Icon(Icons.close_rounded, color: Colors.white),
            ),
            SizedBox(width: 10),
            Text(
              'Unavailable',
              style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText2?.color,
                  fontWeight: FontWeight.w700,
                  fontSize: 14),
            )
          ],
        ),
      ],
    );
  }
}

class SeatCard extends StatefulWidget {
  final int seatId;
  final List? selectedSeat;
  final int seatNumber;
  final bool isBooked;
  const SeatCard(
      {Key? key,
      required this.seatId,
      required this.seatNumber,
      required this.isBooked,
      this.selectedSeat})
      : super(key: key);

  @override
  State<SeatCard> createState() => _SeatCardState();
}

class _SeatCardState extends State<SeatCard> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${widget.seatNumber}',
          style: TextStyle(
              color: Theme.of(context).textTheme.bodyText2?.color,
              fontWeight: FontWeight.w700,
              fontSize: 16),
        ),
        SizedBox(
          width: 5,
        ),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: widget.isBooked
                ? ((widget.selectedSeat!.contains((widget.seatId)))
                    ? Colors.blueAccent
                    : Colors.white)
                : HexColor('A0A0A0'),
            borderRadius: BorderRadius.circular(10),
            border:
                widget.isBooked ? Border.all(color: Colors.blueAccent) : null,
          ),
          child: !widget.isBooked
              ? Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                  size: 30,
                )
              : null,
        ),
      ],
    );
  }
}
