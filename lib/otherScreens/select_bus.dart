import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:theo/data/api/backend_api.dart';
import 'package:theo/model/seat.dart';
import 'package:theo/model/trip.dart';
import 'package:theo/otherScreens/seats_page.dart';

class SelectBus extends StatefulWidget {
  List<Trip> trips;
  SelectBus({Key? key, required this.trips}) : super(key: key);

  @override
  State<SelectBus> createState() => _SelectBusState();
}

class _SelectBusState extends State<SelectBus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Trips"),
      ),
      body: ListView(
        children: widget.trips
            .map((trip) => Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: BusCard(trip: trip),
                ))
            .toList(),
        // children: [
        //   Padding(
        //     padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        //     child: Column(
        //       children: [
        //         BusCard(),
        //         BusCard(),
        //         BusCard(),
        //       ],
        //     ),
        //   )
        // ],
      ),
    );
  }
}

class BusCard extends StatefulWidget {
  final Trip trip;
  const BusCard({Key? key, required this.trip}) : super(key: key);

  @override
  State<BusCard> createState() => _BusCardState();
}

class _BusCardState extends State<BusCard> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return InkWell(
      onTap: () async {
        setState(() {
          isLoading = true;
        });
        try {
          List<Seat> seats =
              await BackendApi.getVehicleSeats(widget.trip.vehicle);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => SeatsGridPage(
                tripId: widget.trip.id.toString(),
                price: double.parse(widget.trip.price!),
                seats: seats,
                flight: false,
              ),
            ),
          );
        } catch (e) {
          //TODO: show error dialog
        }
        setState(() {
          isLoading = false;
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        height: 200,
        width: width,
        decoration: BoxDecoration(
          color: HexColor('56CCF2'),
          borderRadius: BorderRadius.circular(8),
          // boxShadow:[
          //   BoxShadow(spreadRadius: 0, blurRadius: 6, offset: Offset(0, 3), color: Colors.black26)
          // ]
        ),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(color: Colors.white),
              )
            : Stack(
                children: [
                  //Top half circle
                  Align(
                    alignment: Alignment(0.35, -1.1),
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                    ),
                  ),

                  //middle circles
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Align(
                      alignment: Alignment(0.334, 0),
                      child: SizedBox(
                        child: Column(
                          children: List.generate(
                              15,
                              (index) => Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: index % 2 == 0
                                            ? Colors.transparent
                                            : Colors.white,
                                      ),
                                      height: 6,
                                      width: 6,
                                    ),
                                  )),
                        ),
                      ),
                    ),
                  ),

                  //lower half circle
                  Align(
                    alignment: Alignment(0.35, 1.1),
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                    ),
                  ),

                  // percentage off at the left
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      child: Container(
                        width: width / 1.7,
                        height: 110,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Row(
                              //   crossAxisAlignment: CrossAxisAlignment.center,
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Text('$percentageOff', style: TextStyle(color: Theme.of(context).textTheme.bodyText2?.color,fontWeight: FontWeight.w700,fontSize: 30 ),),
                              //     Text('%', style: TextStyle(color: Theme.of(context).textTheme.bodyText2?.color,fontWeight: FontWeight.w700,fontSize: 20 ),),
                              //
                              //   ],
                              // ),
                              // Text('OFF', style: TextStyle(color: Theme.of(context).textTheme.bodyText2?.color,fontWeight: FontWeight.w700,fontSize: 21 ),),
                              //
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Center(
                                      child: Icon(
                                        Icons.gps_fixed,
                                        color: HexColor('#434D80'),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.trip.source!,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      Text(
                                        formatDate(widget.trip.date!,
                                            [D, " ", dd, " ", M, " ", yyyy]),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                            color: Colors.white),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    width: 45,
                                    height: 45,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.location_pin,
                                        color: HexColor('#434D80'),
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.trip.destination!,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      Text(
                                          formatDate(widget.trip.date!,
                                              [D, " ", dd, " ", M, " ", yyyy]),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white)),
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // column of text at the right
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Container(
                        // color: Colors.red,
                        width: width / 4.2,
                        // height: 100,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,                                          children: [
                              //   Text(title, style: TextStyle(color: Theme.of(context).textTheme.headline6?.color,fontWeight: FontWeight.w400,fontSize: 12 ),),
                              //   Text(expirationDate, style: TextStyle(color: Theme.of(context).textTheme.caption?.color,fontWeight: FontWeight.w400,fontSize: 12 ),),
                              //
                              // ],
                              // ),
                              // Text(description, style: TextStyle(color: Theme.of(context).textTheme.bodyText2?.color,fontWeight: FontWeight.w600,fontSize: 12 ),),
                              // Row(
                              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,                                          children: [
                              //   Text(actualCouponCode, style: TextStyle(color:Theme.of(context).textTheme.headline6?.color,fontWeight: FontWeight.w600,fontSize: 16 ),),
                              //   Container(
                              //     width: 69,
                              //     height: 26,
                              //     decoration: BoxDecoration(
                              //       borderRadius: BorderRadius.circular(4),
                              //       color: Colors.white,
                              //       border: Border.all(
                              //           color: HexColor('333333'),
                              //           width: 0.5
                              //       ),
                              //
                              //
                              //     ),
                              //
                              //     child: Center(
                              //       child: Text('Copy', style: TextStyle(color: HexColor('131313'),fontWeight: FontWeight.w600,fontSize: 12 ),),
                              //
                              //     ),
                              //   )

                              // ],
                              // ),
                              Text(
                                widget.trip.time!.substring(0, 5) + " GMT",
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.color,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16),
                              ),
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                width: width / 5,
                                height: 45,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: Text(
                                    'Buy Ticket',
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            ?.color,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                'Price: GHC ${widget.trip.price}',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.color,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
