import 'dart:convert';

import 'package:expatretail/core.dart';
import 'package:expatretail/model/retail_model/cart_model.dart';

class CartRetailController extends GetxController implements GetxService {
  var listCart = <CartModel>[].obs;
  final cart = CartRetailService();
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

  Future<void> sendCart(int idCustomer, int idCustomerProduct, int qty) async {
    try {
      var response = await cart.postCart(
        idCustomer: idCustomer,
        idCustomerProduct: idCustomerProduct,
        qty: qty,
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Cart successfully sent!");
      } else {
        print("Failed to send cart: ${response.body}");
      }
    } catch (e) {
      print("Error while sending cart: $e");
    }
  }

  Future<void> deleteCart(int idCart) async {
    try {
      var response = await cart.deleteCart(idCart);

      if (response.statusCode == 200 || response.statusCode == 204) {
        listCart.removeWhere((item) => item.id == idCart);
        print("Item successfully removed from cart!");
      } else {
        print("Failed to remove item from cart: ${response.body}");
      }
    } catch (e) {
      print("Error while deleting item from cart: $e");
    }
  }
}
