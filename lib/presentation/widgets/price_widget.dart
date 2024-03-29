import 'package:flutter/material.dart';
import 'package:triplaner/domain/entities/site.dart';

class PriceWidget extends StatelessWidget {
  final double fromSize;
  final double priceSize;
  final Site site;
  final FontWeight? priceWeight;
  final FontWeight? fromWeight;


  const PriceWidget({Key? key,required this.fromSize,required this.priceSize,required this.site,this.priceWeight,this.fromWeight}) : super(key: key);

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
                text: "${site.currentCurrencySymbol}${site.price}",
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
