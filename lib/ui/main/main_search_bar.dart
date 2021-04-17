import 'package:flutter/material.dart';
import 'package:smartcycle/Utils/TabletDetector.dart';
import 'package:smartcycle/app_localizations.dart';
import 'package:smartcycle/assets.dart';
import 'package:smartcycle/ui/search/search_main.dart';

class MainSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double margin = TabletDetector.isTablet(context) ? 30 : 15;
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: EdgeInsets.only(left: margin, right: margin, top: 15, bottom: 15),
        child: InkWell(
          child: Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.search),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    AppLocalizations.of(context).translate('main_search_bar'),
                  ),
                ],
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(34),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 6),
                      blurRadius: 6)
                ]),
          ),
          onTap: () {
            Route route = MaterialPageRoute(builder: (context) => SearchMain());
            Navigator.push(context, route);
          },
        ),
      ),
    );
  }
}
