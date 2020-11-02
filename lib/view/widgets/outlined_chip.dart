import 'package:flutter/material.dart';

class OutlinedChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  OutlinedChip(this.label, this.selected, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        height: 32.0,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
                color: selected ? Colors.blue.shade200 : Colors.black26),
            color: selected ? Colors.blue.shade50 : Colors.transparent),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16.0),
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                this.label,
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                    color: selected ? Colors.blue.shade700 : Colors.black87),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
