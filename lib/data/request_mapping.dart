import '../screens/requests/widgets/request_card_data.dart';
import '../screens/requests/widgets/request_status.dart';
import 'mock_data.dart';

export '../screens/requests/widgets/request_card_data.dart';

/// الشاشات بتشتغل بموديل عرض بسيط، والدوال دي بتترجم بينه وبين البيانات
/// المشتركة عشان كل الأجزاء تقرأ نفس الطلبات وتكتب الحالة في نفس المكان.
RequestStatus requestStatusFromValue(Object? value) {
  return switch (value?.toString()) {
    'accepted' => RequestStatus.accepted,
    'inProgress' => RequestStatus.inProgress,
    'completed' => RequestStatus.completed,
    'rejected' => RequestStatus.rejected,
    _ => RequestStatus.pending,
  };
}

String requestStatusValue(RequestStatus status) {
  return switch (status) {
    RequestStatus.pending => 'pending',
    RequestStatus.accepted => 'accepted',
    RequestStatus.inProgress => 'inProgress',
    RequestStatus.completed => 'completed',
    RequestStatus.rejected => 'rejected',
  };
}

String requestCarLabel(Map<String, dynamic> request) {
  for (final car in MockData.mockCars) {
    if (car['id'].toString() == request['carId'].toString()) {
      return '${car['brand']} • ${car['year']}';
    }
  }
  return 'عربية غير معروفة';
}

String requestOwnerName(Map<String, dynamic> request) {
  for (final user in MockData.mockUsers) {
    if (user['phone'].toString() == request['ownerPhone'].toString()) {
      return user['name'].toString();
    }
  }
  return request['ownerPhone']?.toString() ?? '';
}

String requestWorkshopName(Map<String, dynamic> request) {
  for (final workshop in MockData.mockMechanics) {
    if (workshop['phone'].toString() == request['mechanicPhone'].toString()) {
      return workshop['workshopName'].toString();
    }
  }
  return '';
}

RequestCardData requestCardFromMap(Map<String, dynamic> request) {
  return RequestCardData(
    id: request['id']?.toString(),
    service: request['serviceType']?.toString() ?? '',
    car: requestCarLabel(request),
    date: request['createdAt']?.toString() ?? '',
    workshop: requestWorkshopName(request),
    status: requestStatusFromValue(request['status']),
    owner: requestOwnerName(request),
    ownerPhone: request['ownerPhone']?.toString(),
    notes: request['notes']?.toString(),
  );
}

/// تغيير حالة الطلب في نفس العنصر المشترك، والسجل بيتضاف مرة واحدة
/// وقت الإكمال فقط عشان مفيش تكرار لنفس الطلب.
void writeRequestStatus(Map<String, dynamic> request, RequestStatus status) {
  final String value = requestStatusValue(status);
  request['status'] = value;

  if (value != 'completed') {
    return;
  }

  final bool hasRecord = MockData.mockMaintenanceRecords.any(
    (record) => record['requestId'].toString() == request['id'].toString(),
  );
  if (hasRecord) {
    return;
  }

  MockData.mockMaintenanceRecords.add(<String, dynamic>{
    'id': DateTime.now().millisecondsSinceEpoch.toString(),
    'carId': request['carId'],
    'requestId': request['id'],
    'title': request['serviceType']?.toString() ?? '',
    'date': DateTime.now().toString().split(' ')[0],
  });
}
