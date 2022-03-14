// ignore_for_file: non_constant_identifier_names

import 'dart:typed_data';

import 'package:fatura_app/models/business_model.dart';
import 'package:fatura_app/models/customer_model.dart';
import 'package:fatura_app/models/invoice_model.dart';
import 'package:fatura_app/models/item_model.dart';
import 'package:fatura_app/utils/functions.dart';
import 'package:get/get.dart';

class InvoiceController extends GetxController {
// new invoice controller
  String id = "0";
  Business? business;
  Customer? customer;
  RxList<Item> itemsList = <Item>[].obs;
  String? paymentInstructions;
  Uint8List? logo;
  ByteData? signature;

  void setBusiness(Business val) async {
    business = val;
    await Future.delayed(const Duration(milliseconds: 20), () {
      update();
    });
  }

  void setCustomer(Customer val) async {
    customer = val;
    await Future.delayed(const Duration(milliseconds: 20), () {
      update();
    });
  }

  void setItems(List<Item> val) async {
    itemsList.addAll(val);
    await Future.delayed(const Duration(milliseconds: 20), () {
      update();
    });
  }

  void setPaymentInstructions(String val) async {
    paymentInstructions = val;
    await Future.delayed(const Duration(milliseconds: 20), () {
      update();
    });
  }

  void setSignature(ByteData val) async {
    signature = val;
    await Future.delayed(const Duration(milliseconds: 20), () {
      update();
    });
  }

  void setBusinessLogo(Uint8List? val) async {
    logo = val;
    await Future.delayed(const Duration(milliseconds: 20), () {
      update();
    });
  }

  Invoice generate_preview_invoice() => Invoice(
      id: id,
      date: Functions.formatDate(DateTime.now()),
      from: business!,
      to: customer!,
      items: itemsList,
      paymentInstructions: paymentInstructions!,
      total: itemsList.fold(
          0, (previousValue, next) => previousValue + (next.price * next.qty)),
      signature: signature!);
  @override
  void onClose() {
    id = "0";
    business = null;
    customer = null;
    paymentInstructions = null;
    itemsList.value = [];
    signature = null;
    super.onClose();
  }
}
