import 'package:flutter/material.dart';
import 'package:greycells/view/widgets/therapist_list_tile.dart';

// TODO: Add pagination here
class TherapistListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 4.0,
          title: Text(
            'All Therapists',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(color: Colors.black87),
          )),
      body: SafeArea(
        child: Container(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return TherapistListTile();
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
              itemCount: 20),
        ),
      ),
    );
  }
}
