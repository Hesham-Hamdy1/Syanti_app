import 'package:flutter/material.dart';

import '../../../theme/app_theme.dart';

class RequestSectionHeadingWidget extends StatelessWidget {
  const RequestSectionHeadingWidget(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: Text(title, style: AppText.sectionTitle),
    );
  }
}
