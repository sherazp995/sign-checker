import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(16),
        child: CardField(
          onCardChanged: (card) {
            print(card);
          },
        ),
      ),
    );
  }
}