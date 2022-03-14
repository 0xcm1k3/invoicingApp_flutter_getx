import 'package:fatura_app/models/invoice_model.dart';
import 'package:get/get.dart';

class AllInvoiceController extends GetxController {
  final RxList _invoicesList = [].obs;

  get invoicesList => _invoicesList;
  // get invoicesList => _invoicesList;
  // get all invoices
  // creeate new invoice
  void createNewInvoice(Invoice invoice) => _invoicesList.add(invoice);
  // download inovice
  // delete invoice
}
