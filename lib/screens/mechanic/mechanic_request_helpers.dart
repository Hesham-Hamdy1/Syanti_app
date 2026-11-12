import '../../data/mock_data.dart';
import '../requests/widgets/request_card_data.dart';
import '../requests/widgets/request_status.dart';

/// إيهاب بيشتغل بموديل خاص بيه، والدوال دي بتترجم بينه وبين البيانات المشتركة
/// عشان شاشات الميكانيكي تقرأ نفس الطلبات اللي شغال عليها باقي الفريق.
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
    // النسخة الحالية مفيهاش حالة قيد الصيانة في البيانات، فبنحفظها مقبولة
    RequestStatus.inProgress => 'accepted',
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
    service: request['serviceType']?.toString() ?? '',
    car: requestCarLabel(request),
    date: request['createdAt']?.toString() ?? '',
    workshop: requestWorkshopName(request),
    status: requestStatusFromValue(request['status']),
    owner: requestOwnerName(request),
  );
}
