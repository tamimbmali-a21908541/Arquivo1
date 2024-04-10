import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:spot_saver/models/incident.dart';
import 'package:spot_saver/shared/config.dart';
import 'package:toastification/toastification.dart';

class AddIncident extends StatefulWidget {
  final int id;
  const AddIncident({super.key, required this.id});

  @override
  State<AddIncident> createState() => _AddIncidentState();
}

class _AddIncidentState extends State<AddIncident> {
  var descriptionController = TextEditingController();
  var dateController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var incident =
      Incident(description: '', severity: 1, createdDate: DateTime.now());

  @override
  Widget build(BuildContext context) {
    var park = lisbonParks.firstWhere((element) => element.id == widget.id);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adicionar incidente"),
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
        child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Severidade"),
                Slider(
                  value: incident.severity.toDouble(),
                  max: 5,
                  min: 1,
                  divisions: 4,
                  label: incident.getSeverity(),
                  onChanged: (double value) {
                    setState(() {
                      incident.severity = value.toInt();
                    });
                  },
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Descrição',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira uma descrição';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    labelText: 'Data',
                  ),
                  readOnly: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira uma data';
                    }
                    return null;
                  },
                  onTap: () {
                    showDatePicker(
                      context: context,
                      initialDatePickerMode: DatePickerMode.day,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    ).then((date) {
                      if (date != null) {
                        showTimePicker(
                                context: context, initialTime: TimeOfDay.now())
                            .then((time) {
                          if (time != null) {
                            var dateTime = date.add(Duration(
                                hours: time.hour, minutes: time.minute));
                            dateController.text =
                                DateFormat("dd/MM/yyyy HH:mm").format(dateTime);
                            incident.createdDate = dateTime;
                          }
                        });
                      }
                    });
                  },
                ),
                const Spacer(),
                Center(
                  child: ElevatedButton(
                      child: const Text('Adicionar'),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          incident.description = descriptionController.text;
                          park.addIncident(incident);
                          toastification.show(
                            context: context,
                            type: ToastificationType.success,
                            title: const Text('Incidente adicionado!'),
                          );
                          context.pop();
                        } else {
                          toastification.show(
                            context: context,
                            type: ToastificationType.error,
                            title: const Text('Erro ao adicionar incidente!'),
                          );
                        }
                      }),
                ),
              ],
            )),
      ),
    );
  }
}
