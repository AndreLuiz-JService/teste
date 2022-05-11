import 'package:intl/intl.dart';

class FormataData {
  String formatEn_US(String value) {
    String newvalue = value.replaceAll('.', '').replaceAll(',', '.');
    NumberFormat formatter = NumberFormat.simpleCurrency(locale: 'en_US');
    return newvalue;
  }

   double formatdoubleEn_US(String value) {
    String newvalue = value.replaceAll('.', '').replaceAll(',', '.');
    return double.tryParse(newvalue)??0;
  }

  String formatPt_Br(String value) {
    final num newValue = double.parse(value);
    NumberFormat formatter = NumberFormat("#,##0.00", "pt_BR");
    return formatter.format(newValue);
  }

  
}
