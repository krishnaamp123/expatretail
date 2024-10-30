import 'dart:convert';
import 'package:expatretail/core.dart';
import 'package:expatretail/model/supermarket_model/profileretail_model.dart';

class ProfileRetailSuperController extends GetxController
    implements GetxService {
  var listProfileRetail = <ProfileRetailModel>[].obs;
  final profileretailService = ProfileRetailSuperService();
  var isLoading = false.obs;

  Future<void> getProfileRetail() async {
    isLoading.value = true;
    try {
      var response = await profileretailService.getProfileRetail();

      print('response status: ${response.statusCode}');
      print('response body: ${response.body}');

      var responsedecode = jsonDecode(response.body);
      listProfileRetail.clear();
      for (var i = 0; i < responsedecode['data'].length; i++) {
        ProfileRetailModel data =
            ProfileRetailModel.fromJson(responsedecode['data'][i]);
        listProfileRetail.add(data);
      }
    } catch (e) {
      print("Error fetching stocks: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
