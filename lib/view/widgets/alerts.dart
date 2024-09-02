import 'package:flutter/material.dart';
import 'package:news_appp/core/app_constants/colors.dart';
import 'package:status_alert/status_alert.dart';

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

void showStatusAlert(BuildContext context,
    {required bool isSaved, required bool isRepeated}) {
  final isDarkMode = Theme.of(context).brightness == Brightness.dark;
  if ((isRepeated == false && isSaved)) {
    StatusAlert.show(
      dismissOnBackgroundTap: true,
      context,
      duration: const Duration(seconds: 1),
      borderRadius: BorderRadius.circular(20),
      title: isSaved ? 'Saved' : 'Deleted',
      configuration: IconConfiguration(
        icon: isSaved ? Icons.done : Icons.delete_rounded,
        color: isDarkMode ? Colors.greenAccent : Colors.blueAccent,
      ),
      backgroundColor: isDarkMode
          ? Colors.blueGrey[600]!.withOpacity(0.9)
          : Colors.grey[300]!.withOpacity(0.9),
      maxWidth: 220,
      titleOptions: StatusAlertTextConfiguration(
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  } else if (isRepeated == true && !isSaved) {
    StatusAlert.show(
      dismissOnBackgroundTap: true,
      context,
      duration: const Duration(seconds: 2),
      borderRadius: BorderRadius.circular(20),
      title: isSaved ? 'Saved' : 'Deleted',
      configuration: IconConfiguration(
        icon: isSaved ? Icons.done : Icons.delete_rounded,
        color: isDarkMode ? Colors.greenAccent : Colors.blueAccent,
      ),
      backgroundColor: isDarkMode
          ? Colors.blueGrey[600]!.withOpacity(0.9)
          : Colors.grey[300]!.withOpacity(0.9),
      maxWidth: 220,
      titleOptions: StatusAlertTextConfiguration(
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  } else {
    return;
  }
}
