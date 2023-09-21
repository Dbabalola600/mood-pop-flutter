import 'package:flutter/material.dart';

class JournalProps {
  final String title;
  final String date;

  JournalProps({
    required this.title,
    required this.date,
  });
}

class JournalDisplay extends StatelessWidget {
  final JournalProps props;

  JournalDisplay({required this.props});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: 10), // Add horizontal padding
      child: Container(
        margin: const EdgeInsets.only(bottom: 5),
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              margin: const EdgeInsets.only(bottom: 2),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Title: ${props.title}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Date: ${props.date}",
                          style:const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
