import 'dart:convert';
import 'package:expatretail/core.dart';
import 'package:expatretail/model/cart_model.dart';
import 'package:expatretail/model/order_model.dart';

class OrderController extends GetxController implements GetxService {
  var listOrder = <OrderModel>[].obs;
  var listCart = <CartModel>[].obs;
  var isLoading = false.obs;

  final orderService = OrderService();
  final cartService = CartService();

  Future<void> getOrder() async {
    isLoading.value = true;
    try {
      var response = await orderService.getOrder();

      print('response status: ${response.statusCode}');
      print('response body: ${response.body}');

      var responsedecode = jsonDecode(response.body);
      listOrder.clear();
      for (var i = 0; i < responsedecode['data'].length; i++) {
        OrderModel data = OrderModel.fromJson(responsedecode['data'][i]);
        listOrder.add(data);
      }
    } catch (e) {
      print("Error fetching orders: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> gettCart() async {
    isLoading.value = true;
    var response = await cartService.getCart();

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

  Future<void> createOrder(int idCustomer) async {
    try {
      isLoading.value = true;

      // Panggil getCart untuk mengisi listCart sebelum membuat order
      await gettCart();

      if (listCart.isEmpty) {
        print("Cart is empty, cannot create order.");
        return;
      }

      // Siapkan data details dari listCart
      List<Map<String, dynamic>> details = listCart.map((cart) {
        return {
          'id': cart.id,
          'qty': cart.qty,
        };
      }).toList();

      print("Details: $details");

      // Kirim order ke API
      var response = await orderService.postOrder(
        idCustomer: idCustomer,
        details: details,
      );

      print('Order response status: ${response.statusCode}');
      print('Order response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Order successfully created!");
        listCart.clear();
      } else {
        print("Failed to create order: ${response.body}");
      }
    } catch (e) {
      print("Error while creating order: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
