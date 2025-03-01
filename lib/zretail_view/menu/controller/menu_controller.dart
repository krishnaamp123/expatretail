import 'dart:convert';

import 'package:expatretail/core.dart';
export 'package:expatretail/model/retail_model/customerproduct_model.dart';

class MenuRetailItemController extends GetxController implements GetxService {
  var listMenu = <CustomerProductModel>[].obs;
  final menu = CustomerProductRetailService();
  var isLoading = false.obs;

  Future<void> getMenu() async {
    isLoading.value = true;
    var response = await menu.getCustomerProduct();

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var responsedecode = jsonDecode(response.body);
    listMenu.clear();
    for (var i = 0; i < responsedecode['data'].length; i++) {
      CustomerProductModel data =
          CustomerProductModel.fromJson(responsedecode['data'][i]);
      listMenu.add(data);
    }

    isLoading.value = false;
  }
}
