import 'package:book_app/shelf/concretclass.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final routes = {
  '/class': (context, {arguments}) =>ConcretClassPage(arguments: arguments), 
};

var onGenerateRoute = (RouteSettings settings) {
        final String name = settings.name;
        final Function pageContentBuilder = routes[name];
        if(pageContentBuilder != null) {
          if(settings.arguments != null) {
            final Route route = MaterialPageRoute(
              builder: (context) =>
                pageContentBuilder(context, arguments : settings.arguments)
            );
            return route;
          }else {
            final Route route = MaterialPageRoute(
              builder: (context) =>
                pageContentBuilder(context)
            );
            return route;
          }
        }
};