
import 'package:get/get.dart';
import 'package:theo/data/api/api_client.dart';

class FlightRepo extends GetxService {
  final ApiClient apiClient;
  FlightRepo({required this.apiClient});

  Future<Response> getFlight() async{
    return await apiClient.getData("end point url");
  }
}