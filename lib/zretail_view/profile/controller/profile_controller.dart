import 'dart:convert';
import 'package:expatretail/core.dart';
import 'package:expatretail/model/retail_model/profile_model.dart';

class ProfileController extends GetxController implements GetxService {
  var listProfile = <ProfileModel>[].obs;
  final profile = ProfileService();
  var isLoading = false.obs;
  late int userId;

  // Method untuk mengatur ID pengguna
  void setUserId(int userid) {
    userId = userid;
    getProfile();
  }

  Future<void> getProfile() async {
    isLoading.value = true;
    try {
      var response = await profile.getProfile(userId);
      var responsedecode = jsonDecode(response.body);

      // Check if the 'data' field exists and is not null
      if (responsedecode.containsKey('data') &&
          responsedecode['data'] != null) {
        listProfile.clear();

        // Convert 'data' object to ProfileModel
        ProfileModel data = ProfileModel.fromJson(responsedecode['data']);
        listProfile.add(data);
      } else {
        throw Exception("'data' field is missing or null");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
