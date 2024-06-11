import 'package:eneo_fails/app/outage/data/models/eneo_outage_model/eneo_outage_model.dart';
import 'package:eneo_fails/app/outage/screens/components/outage_card.dart';
import 'package:flutter/material.dart';

class OutageList extends StatelessWidget {
  final List<EneoOutageModel> items;
  const OutageList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (c, i) {
        EneoOutageModel? outage = items[i];
        return OutageCard(outage: outage);
      },
      itemCount: items.length,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }
}
