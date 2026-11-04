import 'package:flutter/material.dart';

class RequestScreenShellWidget extends StatelessWidget {
  const RequestScreenShellWidget({
    required this.title,
    required this.body,
    this.bottomAction,
    this.actions = const <Widget>[],
    this.onBack,
    super.key,
  });

  final String title;
  final Widget body;
  final Widget? bottomAction;
  final List<Widget> actions;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          leading: IconButton(
            onPressed:
                onBack ??
                () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
            icon: const Icon(Icons.arrow_back),
          ),
          actions: actions,
        ),
        body: SafeArea(child: body),
        bottomNavigationBar: bottomAction == null
            ? null
            : SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(17, 8, 17, 12),
                  child: bottomAction,
                ),
              ),
      ),
    );
  }
}
