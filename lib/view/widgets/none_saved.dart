import 'package:flutter/material.dart';

class NoSavedNewsMessage extends StatelessWidget {
  const NoSavedNewsMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if the app is in dark mode
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add an illustration or icon
            Icon(
              Icons.bookmark_outline,
              size: 90,
              color: isDarkMode ? Colors.blueGrey[300] : Colors.blue[900],
            ),
            const SizedBox(height: 20),
            // Friendly message
            Text(
              "No Saved News",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.blueGrey[800],
              ),
            ),
            const SizedBox(height: 10),
            // Subtext with guidance
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "You haven't saved any articles yet. Tap the bookmark icon on any article to save it here.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
