import 'package:flutter/material.dart';
import 'package:holopop/create_card/screens/create_details.dart';
import 'package:holopop/create_card/screens/create_final.dart';
import 'package:holopop/create_card/screens/create_marketplace_audio.dart';
import 'package:holopop/create_card/screens/create_marketplace_video.dart';
import 'package:holopop/create_card/screens/create_qr.dart';
import 'package:holopop/create_card/screens/create_record_video.dart';
import 'package:holopop/create_card/screens/create_start.dart';
import 'package:holopop/create_card/screens/create_success.dart';
import 'package:holopop/create_card/screens/create_unlink.dart';
import 'package:holopop/create_card/screens/create_media_type.dart';
import 'package:holopop/create_card/screens/create_upload.dart';
import 'package:holopop/dashboard/screens/dashboard_page.dart';
import 'package:holopop/dashboard/screens/edit_sent_card_page.dart';
import 'package:holopop/dashboard/screens/see_all_page.dart';
import 'package:holopop/dashboard/screens/sent_and_received_card_pages.dart';
import 'package:holopop/login/login_page.dart';
import 'package:holopop/main.dart';
import 'package:holopop/scan/scan.dart';


final Map<String, Widget Function(BuildContext)> routes = {
  "/":                            (_) => const MainPage(),
  "/login":                       (_) => const LoginPage(),
  "/register":                    (_) => const Register(),
  DashboardPage.route():          (_) => const DashboardPage(),
  "/all-received-cards":          (_) => const SeeAllCardsPage(),
  "/received-card":               (_) => const ReceivedCardPage(),
  "/all-sent-cards":              (_) => const SeeAllCardsPage(),
  "/sent-card":                   (_) => const SentCardPage(),
  "/edit-sent-card":              (_) => const EditSentCardPage(),
  "/scan":                        (_) => const Scan(),
  "/create":                      (_) => const CreateStart(),
  "/create/qr":                   (_) => const CreateQr(),
  "/create/details":              (_) => const CreateDetails(),
  "/create/success":              (_) => const CreateSuccess(),
  "/create/unlink":               (_) => const CreateUnlink(),
  "/create/media-type":           (_) => const CreateMediaType(),
  CreateRecordVideo.route():      (_) => const CreateRecordVideo(),
  CreateUpload.route():           (_) => const CreateUpload(),
  CreateMarketplaceVideo.route(): (_) => const CreateMarketplaceVideo(),
  CreateMarketplaceAudio.route(): (_) => const CreateMarketplaceAudio(),
  "/create/final":                (_) => const CreateFinal(),
};