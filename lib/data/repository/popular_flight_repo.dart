
import 'package:get/get.dart';
import 'package:theo/data/api/api_client.dart';

class PopularFlightRepo extends GetxService {
  final ApiClient apiClient;
  PopularFlightRepo({required this.apiClient});

  Future<Response> getPopularFlightList() async{
    return await apiClient.getData("/api/v1/products/popular");
  }
}