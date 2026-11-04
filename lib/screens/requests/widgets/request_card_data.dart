import 'request_status.dart';

class RequestCardData {
  const RequestCardData({
    required this.service,
    required this.car,
    required this.date,
    required this.workshop,
    required this.status,
    this.owner,
  });

  final String service;
  final String car;
  final String date;
  final String workshop;
  final RequestStatus status;
  final String? owner;
}
