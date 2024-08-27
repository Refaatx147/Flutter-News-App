
import 'package:flutter/material.dart';
import 'package:news_appp/core/app_constants/colors.dart';

class AlertError extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onRetry;

  const AlertError(
      {Key? key, required this.errorMessage, required this.onRetry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 100),
            const SizedBox(height: 20),
            Text(
              errorMessage,
              style: const TextStyle(fontSize: 18, color: Colors.black54),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: Icon(
                Icons.refresh,
                color: whiteColor,
              ),
              label: Text(
                'Retry',
                style: TextStyle(color: whiteColor),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: blueColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
