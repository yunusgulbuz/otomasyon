import 'package:otomasyon/view/market/CustomUrl.dart';
import 'package:otomasyon/view/market/Models/UrunListModel.dart';
import 'package:http/http.dart' as http;
class GetProductList{
  final url = Uri.parse(CustomUrl.url + "api/market/UrunlerList?format=json");
  Future callProduct() async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return urunListModelFromJson(response.body);
      }else{
        return response.statusCode.toString();
      }
    } catch (e) {
      print(e);
    }
  }
}