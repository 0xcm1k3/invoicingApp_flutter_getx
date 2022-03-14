import 'package:fatura_app/controllers/items_controller.dart';
import 'package:get/get.dart';

class ItemsBidning extends Bindings {
  @override
  void dependencies() {
    Get.put(ItemsController(), permanent: true);
  }
}
