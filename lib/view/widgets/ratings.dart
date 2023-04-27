import 'package:flutter/material.dart';
import 'package:star_chef/res/app_colors.dart';


class Ratings extends StatelessWidget {
  final String starCount;
  const Ratings({Key? key, required this.starCount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.vegGreen,
        borderRadius: BorderRadius.circular(2.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 1.0),
      child: Row(
        children: [
          Text(
            starCount,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: AppColors.white,
            ),
          ),
          const SizedBox(width: 3,),
          Image.asset(
            'assets/images/2x/star@2x.png',
            height: 6.0,
          )
        ],
      ),
    );
  }
}
