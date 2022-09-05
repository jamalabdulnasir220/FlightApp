
import 'package:get/get.dart';
import 'package:theo/data/api/api_client.dart';
import 'package:theo/data/repository/popular_flight_repo.dart';

import '../controllers/popular_flight_controllers.dart';

Future<void> init() async {
 // api client
 Get.lazyPut(()=>ApiClient(appBaseUrl: "http://mvs.bslmeiyu.com"));

 // repo
 Get.lazyPut(() => PopularFlightRepo(apiClient: Get.find()));

 // controller

 Get.lazyPut(() => PopularFlightController(popularFlightRepo: Get.find()));
}
