import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:theo/EasyGoIcons.dart';
import 'package:theo/data/api/backend_api.dart';
import 'package:theo/model/ticket.dart';
import 'package:theo/otherScreens/bus_ticket_screen.dart';
import 'package:theo/otherScreens/flight_ticket_screen.dart';

class PaymentMethod extends StatefulWidget {
  int bookingId;
  double amount;
  final bool flight;
  PaymentMethod({
    Key? key,
    this.amount = 1,
    required this.flight,
    this.bookingId = 26,
  }) : super(key: key);

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  bool mtn = true;
  String phone = "";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment method'),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Container(
                  // color: momo ? HexColor('EBF0FF') : null,
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: ListTile(
                    onTap: () {
                      if (mounted) {
                        // setState(() {
                        //   momo = !momo;
                        //   //       creditCard = false;
                        // });
                      }
                    },
                    leading: Icon(
                      Icons.mobile_screen_share_rounded,
                      color: HexColor('27AE60'),
                    ),
                    title: Text(
                      'Mobile Money',
                      style: TextStyle(color: HexColor('#003049')),
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              if (mounted) {
                                setState(() {
                                  mtn = true;
                                });
                              }
                            },
                            child: Container(
                              width: (width / 2) - 40,
                              height: 48,
                              decoration: BoxDecoration(
                                color: mtn ? Colors.yellow : Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: !mtn
                                    ? Border.all(color: HexColor('e0e0e0'))
                                    : null,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 20),
                                child: Center(
                                    child: Text(
                                  'MTN',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                      color: Colors.black),
                                )),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              if (mounted) {
                                setState(() {
                                  mtn = false;
                                });
                              }
                            },
                            child: Container(
                              width: (width / 2) - 40,
                              height: 48,
                              decoration: BoxDecoration(
                                color: !mtn ? Colors.red : Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: mtn
                                    ? Border.all(color: HexColor('e0e0e0'))
                                    : null,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 20),
                                child: Center(
                                    child: Text(
                                  'Vodafone',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                      color:
                                          !mtn ? Colors.white : Colors.black),
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: width,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: HexColor('e0e0e0')),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 20),
                          child: Container(
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              onChanged: (val) {
                                phone = val;
                              },
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      ?.color,
                                  letterSpacing: -0.1),
                              cursorHeight: 20,
                              autofocus: false,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Moblie Number",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: InkWell(
                    onTap: onMakePayment,
                    child: Container(
                      width: width,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueAccent),
                      child: Center(
                        child: isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                                'Pay GHC ${widget.amount}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  onMakePayment() async {
    if (phone.isNotEmpty) {
      isLoading = true;
      setState(() {});
      String? status = await BackendApi.makePayment(
        phone: phone,
        // amount: widget.amount, // TODO: uncomment
        bookingId: widget.bookingId,
        network: mtn ? "MTN" : "VOD",
      );

      // Ticket ticket = await BackendApi.getTicket(4);
      // Navigator.of(context).push(
      //   MaterialPageRoute(
      //     builder: (_) => BusTicketScreen(ticket: ticket),
      //   ),
      // );

      if (status == null) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Text("Transaction unsuccessful, please try again"),
          ),
        );
        //pending
      } else if (status.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Transaction pending, please check your approvals")));
        //failed
      } else {
        //successful
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Transaction successful")));
        Ticket ticket = await BackendApi.getTicket(status);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => BusTicketScreen(ticket: ticket),
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("please enter mobile number")));
    }
    isLoading = false;
    setState(() {});
  }
}
