// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'dart:typed_data';
import 'package:fatura_app/models/invoice_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfInvoiceApi {
  static Future<Uint8List> generate(Invoice invoice) async {
    const paymentTerms = '${15} days';
    final titles = <String>['Invoice Number:', 'Invoice Date:', 'Due Date:'];
    final data = <String>[
      "100",
      "15",
      paymentTerms,
      "266",
    ];
    final headers = ['Description', 'Quantity', 'Price per item', 'Total'];
    final invoices_data = [...invoice.items.map((e) => e.toList()).toList()];
    final pdf = Document();
    pdf.addPage(MultiPage(
      header: (context) => Text("INNVOICE ID ${invoice.id}",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
      build: (context) => [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 1 * PdfPageFormat.cm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (invoice.from.logo != null)
                        ? Image(
                            MemoryImage(invoice.from.logo!),
                            height: 80,
                            width: 80,
                          )
                        : Text(""),
                    SizedBox(height: 1 * PdfPageFormat.cm),
                    Text(invoice.from.name!,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 1 * PdfPageFormat.mm),
                    Text(invoice.from.address!),
                  ],
                ),
                Container(
                  height: 80,
                  width: 80,
                  child: BarcodeWidget(
                    barcode: Barcode.qrCode(),
                    data: invoice.id,
                  ),
                ),
              ],
            ),
            SizedBox(height: 1 * PdfPageFormat.cm),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(invoice.to.name,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(invoice.from.address!),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(titles.length, (index) {
                    final title = titles[index];
                    final value = data[index];

                    return buildText(title: title, value: value, width: 200);
                  }),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 3 * PdfPageFormat.cm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Invoice details',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 0.8 * PdfPageFormat.cm),
          ],
        ),
        Table.fromTextArray(
          headers: headers,
          data: invoices_data,
          border: null,
          headerStyle: TextStyle(fontWeight: FontWeight.bold),
          headerDecoration: BoxDecoration(color: PdfColors.grey300),
          cellHeight: 30,
          cellAlignments: {
            0: Alignment.centerLeft,
            1: Alignment.centerRight,
            2: Alignment.centerRight,
            3: Alignment.centerRight,
            4: Alignment.centerRight,
            5: Alignment.centerRight,
          },
        ),
        Divider(),
        Container(
          alignment: Alignment.centerRight,
          child: Row(
            children: [
              Spacer(flex: 6),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildText(
                      title: 'Total amount due',
                      titleStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      value: "\$${invoice.total}",
                      unite: true,
                    ),
                    SizedBox(height: 2 * PdfPageFormat.mm),
                    Container(height: 1, color: PdfColors.grey400),
                    SizedBox(height: 0.5 * PdfPageFormat.mm),
                    Container(height: 1, color: PdfColors.grey400),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 3 * PdfPageFormat.mm),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Payment Instructions",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    invoice.paymentInstructions,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Image(
                  MemoryImage(
                    invoice.signature.buffer.asUint8List(),
                  ),
                  height: 80,
                ),
              )
            ]),
      ],
      footer: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 8 * PdfPageFormat.mm),
          buildSimpleText(title: 'Address', value: invoice.from.address!),
          SizedBox(height: 5 * PdfPageFormat.mm),
          buildSimpleText(
              title: '',
              value:
                  "email: ${invoice.from.email!} / tel: ${invoice.from.phone!}"),
        ],
      ),
    ));
    Uint8List bytes = await pdf.save();
    return bytes;
  }

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
