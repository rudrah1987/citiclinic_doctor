import 'package:city_clinic_doctor/modal/staticResponse/faqModel.dart';
import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'NotificationPage.dart';

class FaqsPage extends StatelessWidget {
  final List<String> searchCategories = [
    "City Clinic",
    "Order",
    "Cancellation & Returns",
    "Payment"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
            backgroundColor: kPrimaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(14),
              ),
            ),
            title: Text("Faqs"),
            //Ternery operator use for condition check
            elevation:
                defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
            centerTitle: false,
            leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.notifications_none,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => NotificationPage()));
                },
              )
            ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300)),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      title: Text(
                        "Commonly Searched FAQs",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                    ListView(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      children: DemoData.faqs.map((e) {
                        return Container(
                          color: Colors.white,
                          child: ExpansionTile(
                            trailing: Container(
                              width: 0,
                            ),
                            onExpansionChanged: (isExpanded) {},
                            title: Text(
                              e.question,
                              style: TextStyle(color: kPrimaryColor),
                            ),
                            expandedAlignment: Alignment.centerLeft,
                            children: <Widget>[
                              Container(
                                child: Text(
                                  e.answer,
                                  style: TextStyle(color: Colors.grey.shade500),
                                ),
                                padding: EdgeInsets.only(
                                    left: 16, right: 16, bottom: 16),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300)),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      title: Text(
                        "Select Categories",
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    ListView.separated(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (_, i) {
                        return ListTile(
                          onTap: () {
                            launch(
                                "https://raw.githubusercontent.com/Entrepreter/Lavado-App/master/lib/ui/help/components/faq_page.dart?token=AO6DLWMRQBXHOK6LZE7VDV275WFUU");
                          },
                          title: Text(
                            searchCategories[i],
                          ),
                        );
                      },
                      itemCount: searchCategories.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          Divider(
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}