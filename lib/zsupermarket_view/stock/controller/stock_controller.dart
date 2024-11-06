import 'dart:convert';
import 'package:expatretail/core.dart';
import 'package:expatretail/model/supermarket_model/stock_model.dart';
import 'package:flutter/material.dart';

class StockController extends GetxController implements GetxService {
  var listStock = <StockModel>[].obs;
  final stockService = StockService();
  var isLoading = false.obs;

  Future<void> getStock(int idCustomer) async {
    isLoading.value = true;
    try {
      var response = await stockService.getStock(idCustomer);

      print('response status: ${response.statusCode}');
      print('response body: ${response.body}');

      var responsedecode = jsonDecode(response.body);
      listStock.clear();
      for (var i = 0; i < responsedecode['data'].length; i++) {
        StockModel data = StockModel.fromJson(responsedecode['data'][i]);
        listStock.add(data);
      }
    } catch (e) {
      print("Error fetching stocks: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> sendStockSold(BuildContext context, int idCustomer,
      int idCustomerProduct, int jumlahSold, int idSupermarket) async {
    try {
      var response = await stockService.postStockSold(
        idCustomer: idCustomer,
        idCustomerProduct: idCustomerProduct,
        soldQty: jumlahSold,
        idSupermarket: idSupermarket,
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Stock successfully change!");
        const snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Success!',
            color: Color.fromRGBO(114, 162, 138, 1),
            message: 'Stock successfully changed!',
            contentType: ContentType.success,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      } else if (response.statusCode == 400) {
        print("Insufficient stock to decrease!");
        const snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Error!',
            message: 'Insufficient stock to decrease!',
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      } else if (response.statusCode == 404) {
        print("Stock not found!");
        const snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Error!',
            message: 'Stock not found!',
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      } else {
        print("Failed to send cart: ${response.body}");
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Failed!',
            message: 'Failed to change password: ${response.body}',
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (e) {
      print("Error while sending cart: $e");
      const snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Error!',
          message: 'Something went wrong!',
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  Future<void> sendStockLost(BuildContext context, int idCustomer,
      int idCustomerProduct, int jumlahLost, int idSupermarket) async {
    try {
      var response = await stockService.postStockLost(
        idCustomer: idCustomer,
        idCustomerProduct: idCustomerProduct,
        lostQty: jumlahLost,
        idSupermarket: idSupermarket,
      );

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Stock successfully change!");
        const snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Success!',
            color: Color.fromRGBO(114, 162, 138, 1),
            message: 'Stock successfully changed!',
            contentType: ContentType.success,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      } else if (response.statusCode == 400) {
        print("Insufficient stock to decrease!");
        const snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Error!',
            message: 'Insufficient stock to decrease!',
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      } else if (response.statusCode == 404) {
        print("Stock not found!");
        const snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Error!',
            message: 'Stock not found!',
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      } else {
        print("Failed to send cart: ${response.body}");
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Failed!',
            message: 'Failed to change password: ${response.body}',
            contentType: ContentType.failure,
          ),
        );

        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    } catch (e) {
      print("Error while sending cart: $e");
      const snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Error!',
          message: 'Something went wrong!',
          contentType: ContentType.failure,
        ),
      );

      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }
}
