import 'package:flutter/material.dart';

import '../../theme/app_theme.dart';
import 'widgets/request_actions_widget.dart';
import 'widgets/request_card_data.dart';
import 'widgets/request_detail_card_widget.dart';
import 'widgets/request_screen_shell_widget.dart';
import 'widgets/request_section_heading_widget.dart';
import 'widgets/request_status.dart';
import 'widgets/status_badge_widget.dart';

class RequestDetailsScreen extends StatefulWidget {
  const RequestDetailsScreen({this.request, super.key});

  final RequestCardData? request;

  @override
  State<RequestDetailsScreen> createState() => _RequestDetailsScreenState();
}

class _RequestDetailsScreenState extends State<RequestDetailsScreen> {
  late RequestStatus _status;

  @override
  void initState() {
    super.initState();
    _status = widget.request?.status ?? RequestStatus.pending;
  }

  RequestCardData _updatedRequest() {
    final RequestCardData? request = widget.request;
    if (request == null) {
      return RequestCardData(
        service: 'تغيير زيت المحرك',
        car: 'تويوتا كورولا • 2022',
        date: '04 نوفمبر 2026 • 10:30 ص',
        workshop: 'مركز الأمان لصيانة السيارات',
        status: _status,
        owner: 'أحمد محمد',
      );
    }

    return RequestCardData(
      service: request.service,
      car: request.car,
      date: request.date,
      workshop: request.workshop,
      status: _status,
      owner: request.owner,
    );
  }

  void _updateStatus(RequestStatus status, String message) {
    setState(() {
      _status = status;
    });

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return RequestScreenShellWidget(
      title: 'تفاصيل الطلب',
      onBack: () => Navigator.pop(context, _updatedRequest()),
      bottomAction: RequestActionsWidget(
        onAccept: () => _updateStatus(RequestStatus.accepted, 'تم قبول الطلب'),
        onReject: () => _updateStatus(RequestStatus.rejected, 'تم رفض الطلب'),
        onComplete: () =>
            _updateStatus(RequestStatus.completed, 'تم إكمال الطلب'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(17, 8, 17, 20),
        children: <Widget>[
          Container(
            height: 145,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  Color(0xFF29343D),
                  Color(0xFF080D12),
                  Color(0xFF151C23),
                ],
              ),
            ),
            child: const Center(
              child: Icon(
                Icons.directions_car_filled,
                size: 78,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.request?.service ?? 'تغيير زيت المحرك',
                  style: AppText.screenTitle,
                ),
              ),
              RequestStatusBadge(status: _status),
            ],
          ),
          const SizedBox(height: 7),
          Text(
            'رقم الطلب: #REQ-1048',
            style: AppText.fieldLabel.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 19),
          const RequestSectionHeadingWidget('بيانات السيارة'),
          RequestDetailCardWidget(
            items: <RequestDetailItem>[
              RequestDetailItem(
                'السيارة',
                widget.request?.car ?? 'تويوتا كورولا 2022',
              ),
              RequestDetailItem('رقم اللوحة', 'أ ب ج 1234'),
              RequestDetailItem('عداد المسافة', '45,000 كم'),
            ],
          ),
          const SizedBox(height: 17),
          const RequestSectionHeadingWidget('بيانات صاحب السيارة'),
          const RequestDetailCardWidget(
            items: <RequestDetailItem>[
              RequestDetailItem('الاسم', 'أحمد محمد'),
              RequestDetailItem('رقم الهاتف', '01012345678'),
            ],
          ),
          const SizedBox(height: 17),
          const RequestSectionHeadingWidget('تفاصيل الموعد والورشة'),
          RequestDetailCardWidget(
            items: <RequestDetailItem>[
              RequestDetailItem(
                'الورشة',
                widget.request?.workshop ?? 'مركز الأمان لصيانة السيارات',
              ),
              RequestDetailItem(
                'الموعد',
                widget.request?.date ?? '04 نوفمبر 2026 • 10:30 ص',
              ),
              RequestDetailItem('ملاحظات', 'صوت غير معتاد عند تشغيل المحرك'),
            ],
          ),
        ],
      ),
    );
  }
}
