// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:holopop/create_card/screens/create_details.dart';
import 'package:holopop/create_card/screens/create_final.dart';
import 'package:holopop/create_card/screens/create_qr.dart';
import 'package:holopop/create_card/screens/create_record_video.dart';
import 'package:holopop/create_card/screens/create_success.dart';
import 'package:holopop/create_card/screens/create_type.dart';
import 'package:holopop/create_card/screens/create_unlink.dart';
import 'package:holopop/create_card/screens/create_media_type.dart';
import 'package:holopop/dashboard/screens/dashboard_page.dart';
import 'package:holopop/dashboard/screens/edit_sent_card_page.dart';
import 'package:holopop/dashboard/screens/see_all_page.dart';
import 'package:holopop/dashboard/screens/sent_and_received_card_pages.dart';
import 'package:holopop/main.dart';
import 'package:holopop/shared/storage/create_application.dart';
import 'package:holopop/shared/widgets/holopop_placeholder.dart';


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
            // First check if this is a named push. TODO: make better.
            if (settings.name != "/" && settings.name != null) {
              switch (settings.name) {
                case "/dashboard":           return const DashboardPage();
                case "/all-received-cards":  return SeeAllCardsPage(args: settings.arguments as SeeAllCardsArgs);
                case "/received-card":       return ReceivedCardPage(args: settings.arguments as SentAndReceivedCardArgs);
                case "/all-sent-cards":      return SeeAllCardsPage(args: settings.arguments as SeeAllCardsArgs);
                case "/sent-card":           return SentCardPage(args: settings.arguments as SentAndReceivedCardArgs);
                case "/edit-sent-card":      return const EditSentCardPage();
                case "/create":              return const CreateType();
                case "/create/qr":           return const CreateQr();
                case "/create/details":      return const CreateDetails();
                case "/create/success":      return const CreateSuccess();
                case "/create/unlink":       return CreateUnlink(card: settings.arguments as CreateApplicationCard);
                case "/create/media-type":   return const CreateMediaType();
                case "/create/record-video": return const CreateRecordVideo();
                case "/create/final":        return const CreateFinal();
              }
            }

            // If it's not a named push, it's probably one of the nav buttons.
            final title = widget.destination.title;

            switch(title) {
              case "Dashboard":
                return const DashboardPage();
              case "Create Card":
                return const CreateRecordVideo(); //TODO: DEVEVEVEVEVE
              default:
                return const HolopopPlaceholder();
            }
          },
        );
      },
    );
  }
}
