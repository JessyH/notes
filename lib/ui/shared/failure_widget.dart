import 'package:flutter/material.dart';

class FailureWidget extends StatelessWidget {
  final String failureReason;

  FailureWidget({required this.failureReason});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Icon(Icons.error_outline),
          Text(failureReason),
        ],
      ),
    );
  }
}
