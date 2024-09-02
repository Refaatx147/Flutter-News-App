import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_appp/core/blocs/layout_cubit/home_layout_cubit.dart';
import 'package:shimmer/shimmer.dart'; 

class LoadingListPage extends StatelessWidget {
  const LoadingListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if dark mode is enabled
    final isDarkMode = context.read<HomeCubit>().darkMode;

    // Define color themes for light and dark modes
    final Color baseColor =
        isDarkMode ? Colors.blueGrey[800]! : Colors.grey[300]!;
    final Color highlightColor =
        isDarkMode ? Colors.blueGrey[600]! : Colors.grey[100]!;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 200.0, left: 30, right: 30),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: baseColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  // Image placeholder
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const SizedBox(width: 10),
                  // Text placeholders
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 20,
                          color: baseColor,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          width: 150,
                          height: 15,
                          color: baseColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
