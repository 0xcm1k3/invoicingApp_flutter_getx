// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'package:fatura_app/constants/colors.dart';
import 'package:fatura_app/constants/strings.dart';
import 'package:fatura_app/controllers/invoices_controller.dart';
import 'package:fatura_app/env/dimensions.dart';
import 'package:fatura_app/screens/invoices_screens/invoice_preview/pdf_ai.dart';
import 'package:fatura_app/screens/shared_widgets/appbar_eng_view.dart';
import 'package:fatura_app/screens/shared_widgets/custom_btn.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class InvoicePreviewScreen extends StatelessWidget {
  Map<String, dynamic> args = Get.arguments;

  InvoicePreviewScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kSecondaryColor,
      appBar: AppBar_eng(
        title: AppStrings.PREVIEW_TITLE,
        showBackArrow: true,
      ),
      body: FutureBuilder(
          future: PdfInvoiceApi.generate(args['invoice']),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              dynamic _documentBytes = snapshot.data;

              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: Dimensions.calcW(15),
                              vertical: Dimensions.calcH(8)),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50)),
                          child: SfPdfViewer.memory(
                            _documentBytes,
                            initialZoomLevel: 0.5,
                          )),
                    ),
                    SizedBox(
                      height: Get.size.height * 0.2,
                      child: Column(
                        children: [
                          CustomBtn(
                            label: AppStrings.SAVE_BTN,
                            action: () {
                              Get.find<AllInvoiceController>()
                                  .createNewInvoice(args["invoice"]);
                              Get.back();
                            },
                            color: AppColors.kPrimaryColor,
                            textColor: Colors.white,
                          ),
                          // InkWell(
                          //   onTap: () {},
                          //   splashColor: AppColors.kPrimaryLight,
                          //   child: Container(
                          //       padding: const EdgeInsets.symmetric(
                          //           vertical: 10, horizontal: 16),
                          //       decoration: BoxDecoration(
                          //         border:
                          //             Border.all(color: AppColors.kPrimaryDark),
                          //         borderRadius: BorderRadius.circular(4),
                          //       ),
                          //       child: Text(
                          //         AppStrings.HOME_BTN.toUpperCase(),
                          //         style: TextStyle(
                          //           color: AppColors.kPrimaryDark,
                          //           fontWeight: FontWeight.bold,
                          //           fontSize: Dimensions.calcH(15),
                          //         ),
                          //       )),
                          // )
                        ],
                      ),
                    )
                  ]);
            } else {
              return Center(
                child: SizedBox(
                  height: Dimensions.calcH(80),
                  width: Dimensions.calcW(80),
                  child: CircularProgressIndicator(
                    color: AppColors.kPrimaryColor,
                  ),
                ),
              );
            }
          }),
    );
  }
}
