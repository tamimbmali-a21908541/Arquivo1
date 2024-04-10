import 'package:intl/intl.dart';

class Incident {
  int severity;
  String description;
  DateTime createdDate;

  Incident({
    required this.severity,
    required this.description,
    required this.createdDate,
  });

  String getSeverity() {
    switch (severity) {
      case 1:
        return 'Baixa';
      case 2:
        return 'Média - Baixa';
      case 3:
        return 'Média';
      case 4:
        return 'Média - Alta';
      case 5:
        return 'Alta';
      default:
        return 'Desconhecida';
    }
  }

  String getFormattedDate() {
    return DateFormat("dd/MM/yyyy HH:mm").format(createdDate);
  }
}
