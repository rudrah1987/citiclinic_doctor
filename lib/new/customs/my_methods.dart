import 'package:flutter/material.dart';

Future<Data> showSheet<Data>(List<Data> data, title, context) async {
  // in any case if the context is null
  if (context == null) {
    print("Context is null");
    return null;
  }
  List<String> innerData = [];
  title = "Select $title";
  // if (Data == Relative) {
  //   data.forEach(
  //     (e) {
  //       innerData.add((e as Relative).name);
  //     },
  //   );
  // }
  if (Data == String) {
    data.forEach(
      (e) {
        innerData.add(e as String);
      },
    );
  }
  Data d = await showModalBottomSheet<Data>(
    context: context,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    builder: (_) {
      return SafeArea(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "$title".toUpperCase(),
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(24),
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
              Divider(),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (_, i) {
                    return ListTile(
                      onTap: () {
                        Navigator.pop(context, data[i]);
                      },
                      title: Text(innerData[i]),
                    );
                  },
                  itemCount: innerData.length,
                ),
              )
            ],
          ),
        ),
      );
    },
  );
  return d;
}













