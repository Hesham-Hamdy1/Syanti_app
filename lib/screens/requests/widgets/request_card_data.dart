import 'request_status.dart';

class RequestCardData {
  const RequestCardData({
    required this.service,
    required this.car,
    required this.date,
    required this.workshop,
    required this.status,
    this.id,
    this.owner,
    this.ownerPhone,
    this.notes,
  });

  final String service;
  final String car;
  final String date;
  final String workshop;
  final RequestStatus status;
  final String? id;
  final String? owner;
  final String? ownerPhone;
  final String? notes;
}
