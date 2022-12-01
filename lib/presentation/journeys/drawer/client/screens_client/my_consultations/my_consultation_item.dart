import 'package:flutter/material.dart';
import 'package:yamaiter/domain/entities/data/client/consultation_entity.dart';

class MyConsultationItem extends StatelessWidget {
  final ConsultationEntity consultationEntity;

  const MyConsultationItem({
    Key? key,
    required this.consultationEntity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(),
    );
  }
}
