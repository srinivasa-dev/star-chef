import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class PopularListShimmer extends StatelessWidget {
  const PopularListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(4, (index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[400]!,
          highlightColor: Colors.grey[300]!,
          child: Container(
            height: 68.0,
            width: 68.0,
            margin: EdgeInsets.only(right: 10.0, left: index == 0 ? 23.0 : 0),
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        );
      }),
    );
  }
}
