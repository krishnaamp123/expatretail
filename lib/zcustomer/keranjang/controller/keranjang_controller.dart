import 'dart:convert';

import 'package:expatretail/core.dart';
import 'package:expatretail/model/cart_model.dart';

class CartController extends GetxController implements GetxService {
  var listCart = <CartModel>[].obs;
  final cart = CartService();
  var isLoading = false.obs;

  Future<void> getCart() async {
    isLoading.value = true;
    var response = await cart.getCart();

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    var responsedecode = jsonDecode(response.body);
    listCart.clear();
    for (var i = 0; i < responsedecode['data'].length; i++) {
      CartModel data = CartModel.fromJson(responsedecode['data'][i]);
      listCart.add(data);
    }

    isLoading.value = false;
  }
}
