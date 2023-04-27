import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';


class RecommendedListShimmer extends StatelessWidget {
  const RecommendedListShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(2, (index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[400]!,
          highlightColor: Colors.grey[300]!,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 180,
                      height: 10.0,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 10.0,),
                    Container(
                      width: 130,
                      height: 10.0,
                      color: Colors.grey,
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  width: 94.0,
                  height: 68.0,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
