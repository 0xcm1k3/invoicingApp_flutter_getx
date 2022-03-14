import 'package:get/get.dart';

class Dimensions {
  static double calcH(double height) {
    double factor = Get.size.height / height;
    return (Get.size.height / factor).roundToDouble();
  }

  static double calcW(double width) {
    double factor = Get.size.width / width;
    return (Get.size.width / factor).roundToDouble();
  }
}
