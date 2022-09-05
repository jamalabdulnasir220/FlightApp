
import 'package:get/get.dart';
import 'package:theo/data/repository/popular_flight_repo.dart';
import 'package:theo/model/product_model.dart';

class PopularFlightController extends GetxController {
  final PopularFlightRepo popularFlightRepo;

  PopularFlightController({required this.popularFlightRepo});
  List<dynamic> _popularFlightList=[];
  List<dynamic> get popularFlightList => _popularFlightList;

  Future<void> getPopularFlightList() async {
    Response response =  await popularFlightRepo.getPopularFlightList();
    if(response.statusCode==200){
      print("got products");
      _popularFlightList=[];
      _popularFlightList.addAll(Product.fromJson(response.body).products);
      print(_popularFlightList);
      update();
    } else {

    }
  }
}