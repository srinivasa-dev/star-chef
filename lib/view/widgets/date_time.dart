import 'package:flutter/material.dart';


class CustomDateTime extends StatefulWidget {
  final void Function() onTap;
  final String title;
  final String icon;

  const CustomDateTime({Key? key, required this.onTap, required this.title, required this.icon}) : super(key: key);

  @override
  State<CustomDateTime> createState() => _CustomDateTimeState();
}

class _CustomDateTimeState extends State<CustomDateTime> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            Image.asset(
              widget.icon,
              height: 18.0,
            ),
            const SizedBox(
              width: 8.1,
            ),
            Text(
              widget.title,
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 15.0
              ),
            ),
          ],
        ),
      ),
    );
  }
}
