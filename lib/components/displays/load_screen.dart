import 'package:flutter/material.dart';

import 'package:shimmer/shimmer.dart';

import '../../utils/colours.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: primaryColor,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Info Section
            Row(
              children: [
                const CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.grey, // Skeleton circle
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 12.0,
                        width: double.infinity,
                        color: Colors.grey, // Skeleton line
                      ),
                      const SizedBox(height: 4.0),
                      Container(
                        height: 12.0,
                        width: 100.0,
                        color: Colors.grey, // Another skeleton line
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            // Post Image
            Container(
              height: 280.0,
              color: Colors.grey, // Skeleton rectangle
            ),
            const SizedBox(height: 8.0),
            // Like, Comment, and Share Buttons

            const SizedBox(height: 8.0),
            // Like Count
            Container(
              height: 12.0,
              width: 100.0,
              color: Colors.grey, // Skeleton line
            ),
            const SizedBox(height: 4.0),
            // Caption
            Container(
              height: 12.0,
              width: double.infinity,
              color: Colors.grey, // Skeleton line
            ),
            const SizedBox(height: 20.0),
            //second one
            Row(
              children: [
                const CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.grey, // Skeleton circle
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 12.0,
                        width: double.infinity,
                        color: Colors.grey, // Skeleton line
                      ),
                      const SizedBox(height: 4.0),
                      Container(
                        height: 12.0,
                        width: 100.0,
                        color: Colors.grey, // Another skeleton line
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            // Post Image
            Container(
              height: 280.0,
              color: Colors.grey, // Skeleton rectangle
            ),
            const SizedBox(height: 8.0),
            // Like, Comment, and Share Buttons

            const SizedBox(height: 8.0),
            // Like Count
            Container(
              height: 12.0,
              width: 100.0,
              color: Colors.grey, // Skeleton line
            ),
            const SizedBox(height: 4.0),
            // Caption
            Container(
              height: 12.0,
              width: double.infinity,
              color: Colors.grey, // Skeleton line
            ),
          ],
        ),
      ),
    );
  }
}
