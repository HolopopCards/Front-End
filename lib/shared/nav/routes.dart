import 'package:flutter/material.dart';
import 'package:holopop/create_card/screens/create_details.dart';
import 'package:holopop/create_card/screens/create_final.dart';
import 'package:holopop/create_card/screens/create_qr.dart';
import 'package:holopop/create_card/screens/create_record_video.dart';
import 'package:holopop/create_card/screens/create_start.dart';
import 'package:holopop/create_card/screens/create_success.dart';
import 'package:holopop/create_card/screens/create_unlink.dart';
import 'package:holopop/create_card/screens/create_media_type.dart';
import 'package:holopop/dashboard/screens/dashboard_page.dart';
import 'package:holopop/dashboard/screens/edit_sent_card_page.dart';
import 'package:holopop/dashboard/screens/see_all_page.dart';
import 'package:holopop/dashboard/screens/sent_and_received_card_pages.dart';
import 'package:holopop/home_page.dart';
import 'package:holopop/login/login_page.dart';
import 'package:holopop/scan/scan.dart';


final Map<String, Widget Function(BuildContext)> routes = {
  "/":                     (context) => const HomePage(),
  "/login":                (context) => const LoginPage(),
  "/register":             (context) => const Register(),
  DashboardPage.route():   (context) => const DashboardPage(),
  "/all-received-cards":   (context) => const SeeAllCardsPage(),
  "/received-card":        (context) => const ReceivedCardPage(),
  "/all-sent-cards":       (context) => const SeeAllCardsPage(),
  "/sent-card":            (context) => const SentCardPage(),
  "/edit-sent-card":       (context) => const EditSentCardPage(),
  "/scan":                 (context) => const Scan(),
  "/create":               (context) => const CreateStart(),
  "/create/qr":            (context) => const CreateQr(),
  "/create/details":       (context) => const CreateDetails(),
  "/create/success":       (context) => const CreateSuccess(),
  "/create/unlink":        (context) => const CreateUnlink(),
  "/create/media-type":    (context) => const CreateMediaType(),
  "/create/record-video":  (context) => const CreateRecordVideo(),
  "/create/final":         (context) => const CreateFinal(),
};