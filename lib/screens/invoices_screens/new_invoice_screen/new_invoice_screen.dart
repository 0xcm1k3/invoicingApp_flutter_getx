import 'package:fatura_app/constants/colors.dart';
import 'package:fatura_app/constants/strings.dart';
import 'package:fatura_app/controllers/invoice_controller.dart';
import 'package:fatura_app/controllers/invoices_controller.dart';
import 'package:fatura_app/env/dimensions.dart';
import 'package:fatura_app/models/invoice_model.dart';
import 'package:fatura_app/screens/invoices_screens/new_invoice_screen/payment_instructions/payment_instructions.dart';
import 'package:fatura_app/screens/invoices_screens/new_invoice_screen/widgets/option_view_eng.dart';
import 'package:fatura_app/screens/shared_widgets/appbar_eng_view.dart';
import 'package:fatura_app/screens/shared_widgets/custom_btn.dart';
import 'package:fatura_app/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class NewInvoiceScreen extends StatelessWidget {
  const NewInvoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kSecondaryColor,
      appBar: AppBar_eng(
        title: AppStrings.NEW_INVOICE_PAGE_TITLE,
        actions: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset(
              "assets/icons/circle_close.svg",
              color: AppColors.kPrimaryDark,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (scroll) {
            scroll.disallowIndicator();
            return true;
          },
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: GetBuilder<InvoiceController>(
                init: InvoiceController(),
                builder: (controller) {
                  if (controller.id == "0") {
                    String id =
                        DateTime.now().millisecondsSinceEpoch.toString();
                    controller.id = id;
                  } else {}

                  return Column(
                    children: [
                      OptionView_eng(
                        onTap: () {},
                        title: AppStrings.NEW_INVOICE_TITLE + controller.id,
                        subTitle: AppStrings.NEW_INVOICE_SUBTITLE +
                            Functions.formatDate(
                              DateTime.now(),
                            ),
                        showArrow: false,
                      ),
                      OptionView_eng(
                        onTap: () {
                          Get.toNamed("/add_business");
                        },
                        title: AppStrings.NEW_INVOICE_BUSINESS,
                        subTitle: AppStrings.NEW_INVOICE_BUSINESS_SUBTITLE,
                        leading: SvgPicture.asset("assets/icons/business.svg"),
                        isComplete:
                            (controller.business != null) ? true : false,
                        showArrow: (controller.business != null) ? false : true,
                      ),
                      OptionView_eng(
                        onTap: () {
                          Get.toNamed("/add_payer");
                        },
                        title: AppStrings.NEW_INVOICE_PAYER,
                        subTitle: AppStrings.NEW_INVOICE_PAYER_SUBTITLE,
                        leading:
                            SvgPicture.asset("assets/icons/person_add.svg"),
                        isComplete:
                            (controller.customer != null) ? true : false,
                        showArrow: (controller.customer != null) ? false : true,
                      ),
                      OptionView_eng(
                        onTap: () {
                          Get.toNamed("/add_items");
                        },
                        title: AppStrings.NEW_INVOICE_ITEMS,
                        subTitle: (controller.itemsList.isEmpty)
                            ? AppStrings.NEW_INVOICE_ITEMS_SUBTITLE
                            : "${controller.itemsList.length} have been added",
                        leading: SvgPicture.asset("assets/icons/add_item.svg"),
                      ),
                      OptionView_eng(
                        onTap: () {
                          if (controller.paymentInstructions == null) {
                            Get.defaultDialog(
                              title: AppStrings.ADD_PAYMENT_INSTRUCTIONS_TITLE,
                              content: PaymentInstructions(),
                            );
                          }
                        },
                        title: AppStrings.NEW_INVOICE_PAYMENT,
                        subTitle: AppStrings.NEW_INVOICE_PAYMENT_SUBTITLE,
                        leading:
                            SvgPicture.asset("assets/icons/payment_method.svg"),
                        isComplete: (controller.paymentInstructions != null)
                            ? true
                            : false,
                        showArrow: (controller.paymentInstructions != null)
                            ? false
                            : true,
                      ),
                      OptionView_eng(
                        onTap: () {
                          Get.toNamed("/sign_invoice");
                        },
                        title: AppStrings.NEW_INVOICE_SIGNATURE,
                        subTitle: AppStrings.NEW_INVOICE_SIGNATURE_SUBTITLE,
                        leading:
                            SvgPicture.asset("assets/icons/signature_pen.svg"),
                        isComplete:
                            (controller.signature != null) ? true : false,
                        showArrow:
                            (controller.signature != null) ? false : true,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomBtn(
                            label: AppStrings.PREVIEW_BTN,
                            action: () {
                              if (controller.business != null &&
                                  controller.customer != null &&
                                  controller.signature != null &&
                                  controller.paymentInstructions != null &&
                                  controller.itemsList.isNotEmpty) {
                                Invoice invoice =
                                    controller.generate_preview_invoice();
                                Get.toNamed("/preview",
                                    arguments: {"invoice": invoice});
                              } else {
                                Get.snackbar("Error",
                                    "Please enter all the required fields!",
                                    snackPosition: SnackPosition.BOTTOM);
                              }
                            },
                          ),
                          SizedBox(
                            width: Dimensions.calcW(20),
                          ),
                          CustomBtn(
                            label: AppStrings.SAVE_BTN,
                            color: AppColors.kPrimaryColor,
                            textColor: Colors.white,
                            action: () {
                              if (controller.business != null &&
                                  controller.customer != null &&
                                  controller.signature != null &&
                                  controller.paymentInstructions != null) {
                                Invoice invoice =
                                    controller.generate_preview_invoice();
                                Get.find<AllInvoiceController>()
                                    .createNewInvoice(invoice);
                                Get.back();
                              } else {
                                Get.snackbar("Error",
                                    "Please enter all the required fields!",
                                    snackPosition: SnackPosition.BOTTOM);
                              }
                            },
                          ),
                        ],
                      )
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }
}
