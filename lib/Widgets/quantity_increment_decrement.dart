import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class QuantityIncrementDecrement extends StatefulWidget {
  final int currentNumber;
  final Function() onAdd;
  final Function() onRemove;
  const QuantityIncrementDecrement(
      {super.key,
      required this.currentNumber,
      required this.onAdd,
      required this.onRemove});

  @override
  State<QuantityIncrementDecrement> createState() =>
      _QuantityIncrementDecrementState();
}

class _QuantityIncrementDecrementState
    extends State<QuantityIncrementDecrement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(width: 2.5),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              onPressed: widget.onRemove, icon: const Icon(Iconsax.minus)),
          const SizedBox(
            width: 10,
          ),
          Text(
            widget.currentNumber.toString(),
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(onPressed: widget.onAdd, icon: const Icon(Iconsax.add)),
        ],
      ),
    );
  }
}
