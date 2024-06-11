import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Chip outageChip({required String title, required BuildContext context, required String icon}) {
  return Chip(
    label: Text(title, style: Theme.of(context).textTheme.bodySmall),
    avatar: SvgPicture.asset(icon, color: Theme.of(context).primaryColorDark),
  );
}
