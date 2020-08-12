import 'package:flutter/material.dart';
import 'package:mental_health/constants/strings.dart';

class MedicalRecordsInputPage extends StatelessWidget {
  final List<String> list = List<String>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: <Widget>[
                  Text(
                    Strings.medicalRecords,
                    style: Theme.of(context).textTheme.headline5.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w400),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.info_outline),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Expanded(
                child: list.isEmpty ? ListEmptyWidget() : FileList(list)),
          ],
        ),
    );
  }
}

class FileList extends StatelessWidget {
  final List<String> list;

  FileList(this.list);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          return Container();
        },
        separatorBuilder: (context, index) => Divider(),
        itemCount: list.length);
  }
}


class ListEmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        Strings.emptyListMessage,
        style: Theme
            .of(context)
            .textTheme
            .subtitle1,
      ),
    );
  }
}
