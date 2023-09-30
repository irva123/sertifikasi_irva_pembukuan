// ignore_for_file: non_constant_identifier_names, unnecessary_string_interpolations, unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:sertifikasi_irva_pembukuan/app/utility/app_color.dart';
import 'package:sertifikasi_irva_pembukuan/app/utility/currency_format.dart';

class CashFlowWidget extends StatelessWidget {
  final bool status_income;
  final int nominal;
  final String description;
  final String date;
  const CashFlowWidget(
      {super.key,
      required this.status_income,
      required this.nominal,
      required this.description,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey, // Warna border
            width: 1.0, // Lebar border
          ),
        ),
      ),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${status_income ? "[ + ] " : "[ - ] "}${FormattedNominal(nominal)}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "${description}",
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                "${date}",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          Icon(
            status_income
                ? Icons.arrow_circle_left_outlined
                : Icons.arrow_circle_right_outlined,
            size: 50,
            color: status_income ? AppColor.arrowGreen : AppColor.arrowRed,
          ),
        ],
      ),
    );
  }
}
