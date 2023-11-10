import 'package:flutter/material.dart';
import 'package:holopop/dashboard/screens/dashboard_page.dart';


/// Represents destination.
class Destination {
  const Destination(this.title, this.icon);
  final String title;
  final IconData icon;
}


/// Current destinations on the nav bar.
const List<Destination> allDestinations = <Destination>[
  Destination('Dashboard',   Icons.wallet),
  Destination('Holopop',     Icons.qr_code_scanner),
  Destination('Create Card', Icons.add_circle_outlined),
  Destination('Shop',        Icons.shop)
];


/// View for displaying the nav bar over everything.
class DestinationView extends StatefulWidget {
  const DestinationView({super.key, required this.destination });

  final Destination destination;

  @override
  State<StatefulWidget> createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            switch(settings.name) {
              default:
                return const DashboardPage();
            }
          },
        );
      },
    );
  }
}
