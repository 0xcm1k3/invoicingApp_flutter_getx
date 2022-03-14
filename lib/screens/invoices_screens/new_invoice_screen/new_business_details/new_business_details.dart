import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:fatura_app/constants/colors.dart';
import 'package:fatura_app/constants/strings.dart';
import 'package:fatura_app/controllers/business_controller.dart';
import 'package:fatura_app/controllers/invoice_controller.dart';
import 'package:fatura_app/env/dimensions.dart';
import 'package:fatura_app/screens/shared_widgets/appbar_eng_view.dart';
import 'package:fatura_app/screens/shared_widgets/custom_btn.dart';
import 'package:fatura_app/screens/shared_widgets/custom_input_eng.dart';
import 'package:fatura_app/screens/shared_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NewBusinessScreen extends StatelessWidget {
  const NewBusinessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar_eng(
        title: AppStrings.ADD_BUSINESS_TITLE,
        showBackArrow: true,
      ),
      body: SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (scroll) {
            scroll.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            child: GetBuilder<BusinessController>(
              init: BusinessController(),
              builder: (controller) => Container(
                margin: EdgeInsets.symmetric(
                  vertical: Dimensions.calcH(5),
                  horizontal: Dimensions.calcW(15),
                ),
                child: Column(
                  children: [
                    Column(
                      children: [
                        CustomInput_eng(
                          controller: controller.businessNameInputController,
                          label: AppStrings.ADD_BUSINESS_NAME,
                          isRequired: true,
                        ),
                        CustomInput_eng(
                          controller: controller.businessEmailInputController,
                          label: AppStrings.ADD_BUSINESS_EMAIL,
                          isRequired: true,
                          type: TextInputType.emailAddress,
                        ),
                        CustomInput_eng(
                          controller: controller.businessPhoneInputController,
                          label: AppStrings.ADD_BUSINESS_PHONE,
                          isRequired: true,
                          type: TextInputType.phone,
                        ),
                        CustomInput_eng(
                          controller: controller.businessAddressInputController,
                          label: AppStrings.ADD_BUSINESS_ADDRESS,
                          height: Dimensions.calcH(100),
                          isRequired: true,
                        ),
                      ],
                    ),
                    GetBuilder<InvoiceController>(
                      builder: (controller) => DottedBorder(
                        color: AppColors.kPrimaryLight,
                        child: SizedBox(
                          height: 150,
                          width: 200,
                          child: (controller.logo != null)
                              ? InkWell(
                                  onTap: () async {
                                    XFile? file = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    if (file != null) {
                                      Uint8List imageBytes =
                                          await file.readAsBytes();
                                      controller.setBusinessLogo(imageBytes);
                                    }
                                  },
                                  child: Image.memory(controller.logo!))
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        XFile? file = await ImagePicker()
                                            .pickImage(
                                                source: ImageSource.gallery);
                                        if (file != null) {
                                          Uint8List imageBytes =
                                              await file.readAsBytes();
                                          controller
                                              .setBusinessLogo(imageBytes);
                                        }
                                      },
                                      splashRadius: 20,
                                      icon: Icon(
                                        Icons.add,
                                        color: AppColors.kPrimaryColor,
                                        size: 30,
                                      ),
                                    ),
                                    CustomText(
                                      text: "Add your logo",
                                      fontSize: Dimensions.calcH(15),
                                      weight: FontWeight.bold,
                                      color: AppColors.kPrimaryColor,
                                    )
                                  ],
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Dimensions.calcH(50),
                    ),
                    CustomBtn(
                      label: AppStrings.SAVE_BTN,
                      action: () {
                        bool isValid = controller.validate();
                        if (isValid) {
                          Get.back();
                        }
                      },
                      color: AppColors.kPrimaryColor,
                      textColor: Colors.white,
                      width: Dimensions.calcW(150),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
