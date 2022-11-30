import 'dart:convert';

import 'package:yamaiter/domain/entities/data/client/consultation_entity.dart';


List<ConsultationModel> listOfConsultationsFromJson(String str) {
  final List<ConsultationModel> consultationsList = [];
/*
  if (json.decode(str)["consultations"] != null) {
    json.decode(str)["consultations"].forEach((v) {
      consultationsList.add(ConsultationModel.fromJson(v));
    });
  }*/
  return consultationsList;
}

class ConsultationModel extends ConsultationEntity {}
