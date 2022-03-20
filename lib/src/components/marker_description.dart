import 'package:flutter/material.dart';

class MarkerDescription extends StatelessWidget {
  final String neighborhood;
  final String direction;
  final int currentLimit;
  final int totalLimit;
  const MarkerDescription({
    Key? key,
    required this.neighborhood,
    required this.direction,
    required this.currentLimit,
    required this.totalLimit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.fromLTRB(40, 20, 20, 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                offset: Offset.zero)
          ]),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(neighborhood,
                          style: TextStyle(
                              color: Colors.grey[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                      Text(direction),
                      Text(
                        '$currentLimit/$totalLimit',
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.location_pin, color: Colors.red, size: 50)
              ],
            ),
          )
        ],
      ),
    );
  }
}
