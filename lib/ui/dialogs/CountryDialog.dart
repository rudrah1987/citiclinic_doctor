import 'package:city_clinic_doctor/utils/Colors.dart';
import 'package:flutter/material.dart';

class CountryDialog extends StatefulWidget {
  List<String> countryList;
  CountryDialog(this.countryList);
  @override
  _CountryDialogState createState() => _CountryDialogState();
}

class _CountryDialogState extends State<CountryDialog> {

  TextEditingController searchController = new TextEditingController();
  List<String> _searchResult = [];

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }

    widget.countryList.forEach((searchResult) {
      if (searchResult.toLowerCase().contains(text.toLowerCase()))
        _searchResult.add(searchResult);
    });

    setState(() {
      // _searchResult = _searchResult;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6)
      ),
      elevation: 12,
      backgroundColor: Colors.white,
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select Country",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  color: Colors.black,),
              ),
              SizedBox(height: 8,),
              Divider(color: kPrimaryColor, thickness: 1,),
              SizedBox(height: 12,),
              Container(
                child: Card(
                  child: new ListTile(
                    leading: new Icon(Icons.search),
                    title: new TextField(
                      controller: searchController,
                      decoration: new InputDecoration(
                          hintText: 'Search country here.....', border: InputBorder.none),
                      onChanged: onSearchTextChanged,
                    ),
                    trailing: new IconButton(icon: new Icon(Icons.cancel), onPressed: () {
                      searchController.clear();
                      onSearchTextChanged('');
                    },),
                  ),
                )
              ),
              SizedBox(height: 16,),

              Expanded(
                child: _searchResult.length != 0 || searchController.text.isNotEmpty
                    ? new ListView.builder(
                  itemCount: _searchResult.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(_searchResult[i]),
                            SizedBox(height: 4,),
                            Divider(color: Colors.grey[200], thickness: 1,)
                          ],
                        ),
                      ),
                      onTap: (){
                        Navigator.pop(context, _searchResult[i]);
                      },
                    );
                  },
                )
                    : new ListView.builder(
                  itemCount: widget.countryList.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      child: Container(
                        padding: EdgeInsets.fromLTRB(0, 4, 0, 4),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.countryList[i]),
                            SizedBox(height: 3,),
                            Divider(color: Colors.grey[300], thickness: 1,)
                          ],
                        ),
                      ),
                      onTap: (){
                        Navigator.pop(context, widget.countryList[i]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}