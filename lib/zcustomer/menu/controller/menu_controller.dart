// import 'package:get/get.dart';
// import 'package:expatretail/core.dart';

// class MenuController extends GetxController implements GetxService {
//   var listPaket = <PaketModel>[].obs;
//   final paket = PaketService();
//   var isLoading = false.obs;

//   Future<void> getPaket() async {
//     isLoading.value = true;
//     var response = await paket.getPaket();
//     var responsedecode = jsonDecode(response.body);
//     listPaket.clear();
//     for (var i = 0; i < responsedecode['datas'].length; i++) {
//       PaketModel data = PaketModel.fromJson(responsedecode['datas'][i]);
//       listPaket.add(data);
//     }
//     isLoading.value = false;
//   }
// }
