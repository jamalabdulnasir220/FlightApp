import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:theo/data/api/backend_api.dart';
import 'package:theo/model/agency.dart';
import 'package:theo/model/category.dart';
import 'package:theo/model/search_trip.dart';
import 'package:theo/model/trip.dart';
import 'package:theo/otherScreens/select_bus.dart';
import 'package:theo/style.dart';

import '../components/color.dart';
import '../components/widget_component.dart';
import '../dimensions/dimensions.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  List<Category>? cats = [];
  bool isLoading = false;

  // final formats = DateFormat("yyyy-MM-dd");
  DateTime? journeys;
  DateTime? date;
  int? selectedAgencyId = null;
  late Category selectedCat;
  String? source;
  List<String> locations = [];
  String? arrivalId;
  SearchTrip searchTrip = SearchTrip();

  @override
  void initState() {
    super.initState();
    getDatas();
  }

  getDatas() async {
    cats = [];
    setState(() {});
    try {
      cats = await BackendApi.getCategories();
      selectedCat = cats!.first;
      searchTrip.catId = selectedCat.id;
      for (Category cat in cats!) {
        cat.agencies = await BackendApi.getAgencies(catId: cat.id);
      }
      locations = await BackendApi.getLocations();
    } catch (e) {
      log(e.toString());
      cats = null;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: cats == null
          ? Center(
              child: ElevatedButton(
                  onPressed: () {
                    getDatas();
                  },
                  child: Text("Reload")),
            )
          : cats!.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                )
              : ListView(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 25.0),
                  children: <Widget>[
                    SizedBox(
                        height: height / 9,
                        child: Image.asset('images/easygo.png')),
                    const SizedBox(height: 20),

                    SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ListView(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        scrollDirection: Axis.horizontal,
                        children: cats!.map((e) => catItem(width, e)).toList(),
                      ),
                    ),
                    const SizedBox(height: 20),
                    agancySelector(),
                    const SizedBox(height: 20),
                    depAndArivSelectors(),
                    const SizedBox(height: 20),
                    dateSelector(context),
                    const SizedBox(height: 50),
                    searchButton(context),
                    const SizedBox(height: 20),
                    // if (bus) BusScreen(),

                    // if (!bus) PlaneScreen()

                    // Text("Prefered Bus",
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.w500,
                    //       fontSize: 16.0),
                    // ),
                    //
                    // Text("Favorite Bus",
                    //   style: TextStyle(
                    //       fontWeight: FontWeight.w500,
                    //       fontSize: 16.0),
                    // ),
                  ],
                ),
    );
  }

  Widget catItem(double width, Category cat) {
    return GestureDetector(
      onTap: () {
        if (mounted) {
          selectedAgencyId = null;
          setState(() {
            selectedCat = cat;
            searchTrip.catId = cat.id;
          });
        }
      },
      child: Container(
        width: width / 3,
        margin: EdgeInsets.only(right: 30),
        height: 40,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(spreadRadius: 1, blurRadius: 4, color: Colors.black26)
          ],
          color: selectedCat.id == cat.id ? Colors.blueAccent : Colors.white,
        ),
        child: Center(
          child: Text(
            cat.name ?? "~",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: selectedCat.id == cat.id ? Colors.white : Colors.black,
              fontFamily: "Gilroy-Regular",
            ),
          ),
        ),
      ),
    );
  }

  Widget agancySelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: DropdownButton<int?>(
        isExpanded: true,
        style: const TextStyle(color: Colors.black),
        value: selectedAgencyId,
        hint: Text("Select Agency"),
        icon: const Icon(Icons.keyboard_arrow_down),
        items: selectedCat.agencies!.map((Agency agency) {
          return DropdownMenuItem<int>(
            value: agency.id,
            child: Text(
              agency.name!,
              style: const TextStyle(fontFamily: "Gilroy-Regular"),
            ),
          );
        }).toList(),
        onChanged: (int? newValue) {
          setState(() {
            selectedAgencyId = newValue;
            searchTrip.agencyId = newValue;
          });
        },
      ),
    );
  }

  Column depAndArivSelectors() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: DropdownButtonFormField<String>(
            value: source,
            decoration: dropDownDecoration(hintText: "Select depature"),
            items: locations
                .map(
                  (dep) => DropdownMenuItem<String>(
                    value: dep,
                    child: Text(
                      dep,
                      style: const TextStyle(color: Colors.black, fontSize: 13),
                    ),
                  ),
                )
                .toList(),
            onChanged: (val) {
              searchTrip.source = val;
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: DropdownButtonFormField<String>(
            value: source,
            decoration: dropDownDecoration(hintText: "Select arrival"),
            items: locations
                .map(
                  (dep) => DropdownMenuItem<String>(
                    value: dep,
                    child: Text(
                      dep,
                      style: const TextStyle(color: Colors.black, fontSize: 13),
                    ),
                  ),
                )
                .toList(),
            onChanged: (val) {
              searchTrip.dest = val;
            },
          ),
        ),
        SizedBox(height: Dimensions.height20),
      ],
    );
  }

  Card dateSelector(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(left: 18),
              child: Text(
                "Journey Date",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontFamily: "Gilroy-Regular",
                ),
              ),
            ),
            InkWell(
              onTap: () async {
                final initialDate = DateTime.now();
                final newDate = await showDatePicker(
                    context: context,
                    initialDate: initialDate,
                    firstDate: DateTime(DateTime.now().year - 30),
                    lastDate: DateTime(DateTime.now().year + 30));
                if (newDate == null) return;
                setState(() {
                  date = newDate;
                  searchTrip.date = newDate.toString().substring(0, 10);
                  log(newDate.toString().substring(0, 11));
                });
                print(date);
              },
              child: Container(
                height: 48,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white10),
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        date == null
                            ? 'dd/mm/yy'
                            : '${date?.day}/${date?.month}/${date?.year}',
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Gilroy-Regular',
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).textTheme.caption?.color,
                            letterSpacing: -0.1),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox searchButton(BuildContext context) {
    return SizedBox(
      height: 50,
      width: MediaQuery.of(context).size.width / 1.5,
      child: WidgetComponent.buttons(
        "Search Bus",
        size: 18,
        textColor: Colors.white,
        loading: isLoading,
        bolds: FontWeight.w500,
        elevas: 2.0,
        radius: 20.0,
        padding: const EdgeInsets.symmetric(vertical: 10),
        coloring: Colours.magenta,
        onPressed: () async {
          try {
            isLoading = true;
            setState(() {});
            List<Trip> trips = await BackendApi.searchTrip(searchTrip);
            if (trips.isNotEmpty) {
              if (!mounted) return;
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => SelectBus(trips: trips),
                ),
              );
            } else {
              if (!mounted) return;
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("No trips found")));
            }
          } catch (e) {
            //TODO: show error dialog
          }
          setState(() {
            isLoading = false;
          });
        },
      ),
    );
  }
}

// class BusScreen extends StatefulWidget {
//   const BusScreen({Key? key}) : super(key: key);

//   @override
//   State<BusScreen> createState() => _BusScreenState();
// }

// class _BusScreenState extends State<BusScreen> {
//   DateTime? date;
//   List<String> agencies = [
//     'Select',
//     'VIP',
//     'Theo transport',
//     'Metro Mass',
//     'KPS',
//     'STC'
//   ];
//   late String dropDownValue;

//   List<dynamic> departures = ["Accra", "Kumasi", "Takoradi"];
//   String? source;

//   String? departureId;

//   List<dynamic> arrivals = ["Accra", "Kumasi", "Takoradi"];
//   String? arrivalId;
//   SearchTrip searchTrip = SearchTrip();

//   @override
//   void initState() {
//     super.initState();
//     dropDownValue = agencies.first;
//   }

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     return Column(
//       children: [
//         // SizedBox(
//         //   width: MediaQuery.of(context).size.width,
//         //     child: Text('Where do you want to travel to?', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25),)),
//         agancySelector(),
//         const SizedBox(height: 20),
//         depAndArivSelectors(),
//         const SizedBox(height: 20),
//         dateSelector(context),
//         const SizedBox(height: 50),
//         searchButton(context),
//         const SizedBox(height: 20),
//       ],
//     );
//   }

  
// }

// class PlaneScreen extends StatefulWidget {
//   const PlaneScreen({Key? key}) : super(key: key);

//   @override
//   State<PlaneScreen> createState() => _PlaneScreenState();
// }

// class _PlaneScreenState extends State<PlaneScreen> {
//   TextEditingController fromController = new TextEditingController();
//   TextEditingController toController = new TextEditingController();
//   DateTime? date;
//   var agencies = ['Select Airline', 'Emirates', 'Ghana Airways', 'Kotoka ITL'];
//   String dropDownValue = 'Select Airline';
//   bool oneWay = true;

//   List<dynamic> departure = [];

//   String? departureId;

//   List<dynamic> arrival = [];
//   String? arrivalId;

//   @override
//   void initState() {
//     super.initState();

//     this.departure.add({"id": 1, "label": "Accra"});
//     this.departure.add({"id": 2, "label": "Kumasi"});
//     this.departure.add({"id": 3, "label": "Takoradi"});

//     this.arrival.add({"id": 1, "label": "Accra"});
//     this.arrival.add({"id": 2, "label": "Kumasi"});
//     this.arrival.add({"id": 3, "label": "Takoradi"});
//   }

//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     return Column(
//       children: [
//         // SizedBox(
//         //   width: MediaQuery.of(context).size.width,
//         //     child: Text('Where do you want to travel to?', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 25),)),
//         DropdownButton(
//           style: TextStyle(color: Colors.black),
//           value: dropDownValue,
//           icon: const Icon(Icons.keyboard_arrow_down),
//           items: agencies.map((String items) {
//             return DropdownMenuItem(
//               value: items,
//               child: Text(
//                 items,
//                 style: TextStyle(fontFamily: "Gilroy-Regular"),
//               ),
//             );
//           }).toList(),
//           onChanged: (String? newValue) {
//             setState(() {
//               dropDownValue = newValue!;
//             });
//           },
//         ),
//         // FormHelper.dropDownWidget(
//         //   context,
//         //   "select departure",
//         //   this.departureId,
//         //   this.departure,
//         //   (onChanged) {
//         //     this.departureId = onChanged;
//         //   },
//         //   (onValidate) {
//         //     if (onValidate == null) {
//         //       "please select departure";
//         //     }
//         //     return null;
//         //   },
//         //   borderColor: Theme.of(context).primaryColor,
//         //   borderFocusColor: Theme.of(context).primaryColor,
//         //   borderRadius: 10,
//         //   optionValue: "id",
//         //   optionLabel: 'label',
//         // ),
//         SizedBox(
//           height: Dimensions.height20,
//         ),
//         // FormHelper.dropDownWidget(
//         //   context,
//         //   "select arrival",
//         //   this.arrivalId,
//         //   this.arrival,
//         //   (onChanged) {
//         //     this.arrivalId = onChanged;
//         //   },
//         //   (onValidate) {
//         //     if (onValidate == null) {
//         //       "please select arrival";
//         //     }
//         //     return null;
//         //   },
//         //   borderColor: Theme.of(context).primaryColor,
//         //   borderFocusColor: Theme.of(context).primaryColor,
//         //   borderRadius: 10,
//         //   optionValue: "id",
//         //   optionLabel: 'label',
//         // ),
//         SizedBox(
//           height: 20.0,
//         ),

//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             InkWell(
//               onTap: () {
//                 if (mounted) {
//                   setState(() {
//                     oneWay = true;
//                   });
//                 }
//               },
//               child: Container(
//                 width: width / 3,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   boxShadow: oneWay
//                       ? [
//                           BoxShadow(
//                               spreadRadius: 1,
//                               blurRadius: 4,
//                               color: Colors.black26)
//                         ]
//                       : null,
//                   color: oneWay ? Colors.blueAccent : Colors.white,
//                 ),
//                 child: Center(
//                   child: Text(
//                     'One-way',
//                     style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                         color: oneWay ? Colors.white : Colors.black,
//                         fontFamily: "Gilroy-Regular"),
//                   ),
//                 ),
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 if (mounted) {
//                   setState(() {
//                     oneWay = false;
//                   });
//                 }
//               },
//               child: Container(
//                 width: width / 3,
//                 height: 40,
//                 decoration: BoxDecoration(
//                     color: !oneWay ? Colors.blueAccent : Colors.white,
//                     boxShadow: !oneWay
//                         ? [
//                             BoxShadow(
//                                 spreadRadius: 1,
//                                 blurRadius: 4,
//                                 color: Colors.black26)
//                           ]
//                         : null),
//                 child: Center(
//                   child: Text(
//                     'Return trip',
//                     style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w500,
//                         color: !oneWay ? Colors.white : Colors.black,
//                         fontFamily: "Gilroy-Regular"),
//                   ),
//                 ),
//               ),
//             )
//           ],
//         ),

//         SizedBox(
//           height: 15.0,
//         ),

//         Card(
//             elevation: 2.0,
//             child: Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.only(left: 18),
//                     child: Text(
//                       "Journey Date",
//                       style: TextStyle(fontFamily: "Gilroy-Regular"),
//                     ),
//                   ),
//                   // DateTimeField(
//                   //   format: formats,
//                   //   onShowPicker: (context, currentValue) {
//                   //     return showDatePicker(
//                   //         context: context,
//                   //         initialDate: currentValue ?? DateTime.now(),
//                   //         firstDate: DateTime(1970), lastDate: DateTime(2119));
//                   //   },
//                   //   onChanged: (dates) {
//                   //     setState(() {
//                   //       journeys = dates;
//                   //     });
//                   //   },
//                   //   decoration: InputDecoration(
//                   //       border: InputBorder.none,
//                   //       prefixIcon: Icon(Icons.date_range),
//                   //       suffixIcon: FlatButton(onPressed: (){
//                   //         setState(() {
//                   //           journeys = DateTime.now();
//                   //         });
//                   //       }, child: Text("Today"))
//                   //   ),
//                   // ),
//                   //date time picker
//                   InkWell(
//                     onTap: () async {
//                       final initialDate = DateTime.now();
//                       final newDate = await showDatePicker(
//                           context: context,
//                           initialDate: initialDate,
//                           firstDate: DateTime(DateTime.now().year - 30),
//                           lastDate: DateTime(DateTime.now().year + 30));
//                       if (newDate == null) return;
//                       setState(() {
//                         date = newDate;
//                       });
//                       print(date);
//                     },
//                     child: Container(
//                       height: 48,
//                       decoration: BoxDecoration(
//                           border: Border.all(color: Colors.white10),
//                           borderRadius: BorderRadius.circular(8)),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 20),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text(
//                               date == null
//                                   ? 'dd/mm/yy'
//                                   : '${date?.day}/${date?.month}/${date?.year}',
//                               style: TextStyle(
//                                   fontSize: 14,
//                                   fontFamily: 'Gilroy-Regular',
//                                   fontWeight: FontWeight.w400,
//                                   color: Theme.of(context)
//                                       .textTheme
//                                       .caption
//                                       ?.color,
//                                   letterSpacing: -0.1),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             )),

//         if (!oneWay) ...[
//           SizedBox(
//             height: 8.0,
//           ),
//           Card(
//               elevation: 2.0,
//               child: Padding(
//                 padding: EdgeInsets.all(8.0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Padding(
//                       padding: const EdgeInsets.only(left: 18),
//                       child: Text(
//                         "Return Date",
//                         style: TextStyle(fontFamily: "Gilroy-Regular"),
//                       ),
//                     ),
//                     // DateTimeField(
//                     //   format: formats,
//                     //   onShowPicker: (context, currentValue) {
//                     //     return showDatePicker(
//                     //         context: context,
//                     //         initialDate: currentValue ?? DateTime.now(),
//                     //         firstDate: DateTime(1970), lastDate: DateTime(2119));
//                     //   },
//                     //   onChanged: (dates) {
//                     //     setState(() {
//                     //       journeys = dates;
//                     //     });
//                     //   },
//                     //   decoration: InputDecoration(
//                     //       border: InputBorder.none,
//                     //       prefixIcon: Icon(Icons.date_range),
//                     //       suffixIcon: FlatButton(onPressed: (){
//                     //         setState(() {
//                     //           journeys = DateTime.now();
//                     //         });
//                     //       }, child: Text("Today"))
//                     //   ),
//                     // ),
//                     //date time picker
//                     InkWell(
//                       onTap: () async {
//                         final initialDate = DateTime.now();
//                         final newDate = await showDatePicker(
//                             context: context,
//                             initialDate: initialDate,
//                             firstDate: DateTime(DateTime.now().year - 30),
//                             lastDate: DateTime(DateTime.now().year + 30));
//                         if (newDate == null) return;
//                         setState(() {
//                           date = newDate;
//                         });
//                         print(date);
//                       },
//                       child: Container(
//                         height: 48,
//                         decoration: BoxDecoration(
//                             border: Border.all(color: Colors.white10),
//                             borderRadius: BorderRadius.circular(8)),
//                         child: Padding(
//                           padding: const EdgeInsets.symmetric(horizontal: 20),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 date == null
//                                     ? 'dd/mm/yy'
//                                     : '${date?.day}/${date?.month}/${date?.year}',
//                                 style: TextStyle(
//                                     fontSize: 14,
//                                     fontFamily: 'Gilroy-Regular',
//                                     fontWeight: FontWeight.w400,
//                                     color: Theme.of(context)
//                                         .textTheme
//                                         .caption
//                                         ?.color,
//                                     letterSpacing: -0.1),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               )),
//         ],
//         SizedBox(
//           height: 50,
//         ),

//         Container(
//           height: 50,
//           width: MediaQuery.of(context).size.width / 1.5,
//           child: WidgetComponent.buttons("Search Flight",
//               textColor: Colors.white,
//               bolds: FontWeight.bold,
//               elevas: 2.0,
//               radius: 20.0,
//               padding: EdgeInsets.symmetric(vertical: 10),
//               coloring: Colours.magenta, onPressed: () {
//             Navigator.of(context)
//                 .push(MaterialPageRoute(builder: (_) => SelectFlight()));
//           }),
//         ),
//         SizedBox(
//           height: 50,
//         ),
//       ],
//     );
//   }
// }
