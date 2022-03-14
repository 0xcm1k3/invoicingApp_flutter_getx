import 'package:fatura_app/constants/colors.dart';
import 'package:fatura_app/constants/strings.dart';
import 'package:fatura_app/controllers/invoice_controller.dart';
import 'package:fatura_app/env/dimensions.dart';
import 'package:fatura_app/screens/shared_widgets/appbar_eng_view.dart';
import 'package:fatura_app/screens/shared_widgets/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';
import 'dart:ui' as ui;

GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();

class SignatureScreen extends GetView<InvoiceController> {
  const SignatureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kSecondaryColor,
      appBar: AppBar_eng(
        title: AppStrings.ADD_PAYER_TITLE,
        showBackArrow: true,
      ),
      body: SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (scroll) {
              scroll.disallowIndicator();
              return true;
            },
            child: Column(
              children: [
                Container(
                  height: Get.size.height * 0.45,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: SfSignaturePad(
                    key: _signaturePadKey,
                    minimumStrokeWidth: 2,
                    maximumStrokeWidth: 4,
                    strokeColor: Colors.black,
                    backgroundColor: Colors.white,
                  ),
                ),
                SizedBox(
                  height: Dimensions.calcH(20),
                ),
                CustomBtn(
                  label: AppStrings.SAVE_BTN,
                  action: () async {
                    ui.Image image =
                        await _signaturePadKey.currentState!.toImage();
                    final pngBytes =
                        await image.toByteData(format: ui.ImageByteFormat.png);
                    controller.setSignature(pngBytes!);
                    Get.back();
                  },
                  color: AppColors.kPrimaryColor,
                  textColor: Colors.white,
                ),
                CustomBtn(
                  label: AppStrings.CLEAR_BTN,
                  action: () async {
                    _signaturePadKey.currentState!.clear();
                  },
                  color: Colors.red,
                  textColor: Colors.white,
                ),
              ],
            )
            // child: Column(
            //   children: [

            //     // (imgBytes != null)
            //     //     ? Image.memory(
            //     //         Uint8List.view(imgBytes!.buffer),
            //     //       )
            //     //     : const Text("")
            //   ],
            ),
      ),
    );
  }
}
