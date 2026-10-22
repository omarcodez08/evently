import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/assets_manager.dart';

class BackBtn extends StatelessWidget {
  const BackBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        margin: EdgeInsets.only(left: 16),
        padding: EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 15
        ),
        decoration: BoxDecoration(
            color: Theme
                .of(context)
                .colorScheme
                .onPrimaryContainer,
            border: Border.all(color: Theme
                .of(context)
                .colorScheme
                .secondary),
            borderRadius: BorderRadius.circular(8)
        ),
        child: SvgPicture.asset(AssetsManager.back,
          colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.onPrimary,
              BlendMode.srcIn),),
      ),
    );
  }
}