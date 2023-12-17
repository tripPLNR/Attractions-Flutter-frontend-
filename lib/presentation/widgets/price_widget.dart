import 'package:flutter/material.dart';

class PriceWidget extends StatelessWidget {
  final double fromSize;
  final double priceSize;
  final String price;
  final FontWeight? priceWeight;
  final FontWeight? fromWeight;


  const PriceWidget({Key? key,required this.fromSize,required this.priceSize,required this.price,this.priceWeight,this.fromWeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
        TextSpan(
            text: "from ",
            style: TextStyle(
              fontSize: fromSize,
              fontWeight: fromWeight??FontWeight.w300,
              letterSpacing: 0,
              color: Theme.of(context).colorScheme.primary,
            ),
            children: [
              TextSpan(
                text: "\$$price",
                style: TextStyle(
                  fontSize:priceSize,
                  fontWeight: priceWeight??FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary,
                ),
              )
            ]
        )
    );
  }
}
