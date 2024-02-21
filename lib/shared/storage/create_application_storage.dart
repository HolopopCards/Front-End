import 'dart:convert';
import 'package:holopop/shared/monads/result.dart';
import 'package:holopop/shared/storage/create_application.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateApplicationStorage {
  /// Start the application process.
  Future<Result<CreateApplication>> startApplicationAsync(String type) async {
    Logger('Create Application Storage').info("Creating application...");
    final prevApp = await getAppAsync();
    if (prevApp.success == true) {
      Logger('Create Application Storage').info("Deleting previous application...");
      await deleteAppAsync();
    }

    final app = CreateApplication(type: type, cards: []);
    return saveAppAsync(app);
  }

  /// Save app in storage.
  Future<Result<CreateApplication>> saveAppAsync(CreateApplication application) async {
    final prefs = await SharedPreferences.getInstance();

    Logger('Create Application Storage').info("Saving application: $application");
    await prefs.setString('create_application', jsonEncode(application));
    return Result.fromSuccess(application);
  }

  /// Get app from storage.
  Future<Result<CreateApplication>> getAppAsync() async {
    final prefs = await SharedPreferences.getInstance();

    final appString = prefs.getString('create_application');
    if (appString == null) {
      return Result.fromFailure("Application is not in storage.");
    }
    final appJson = jsonDecode(appString);
    return Result.fromSuccess(CreateApplication.fromJson(appJson));
  }

  /// Update app in storage.
  Future<Result<CreateApplication>> updateAppAsync(Function(CreateApplication) func) async {
    final app = await getAppAsync();
    if (app.success == false) {
      return Result.fromFailure(app.error!);
    }
    func(app.value!);
    Logger('Create Application Storage').info("Updated application: $app");
    return saveAppAsync(app.value!);
  }

  /// Update a single card in the app in storage.
  Future<Result> updateCardAsync(String serialNumber, CreateApplicationCard Function(CreateApplicationCard) func) async {
    final app = await getAppAsync();
    if (app.success == false) {
      return Result.fromFailure(app.error!);
    }

    final cardIndex = app.value!.cards.indexWhere((c) => c.serialNumber == serialNumber);
    if (cardIndex == -1) {
      return Result.fromFailure("Card with serial number '$serialNumber' does not exist.");
    }

    app.value!.cards[cardIndex] = func(app.value!.cards[cardIndex]);
    Logger('Create Application Storage').info("Updated card in application: ${app.value!.cards[cardIndex]}");
    return saveAppAsync(app.value!);
  }

  /// Update the most recent card in storage.
  Future<Result> updateLastCardAsync(CreateApplicationCard Function(CreateApplicationCard) func) async {
    final app = await getAppAsync();
    if (app.success == false) {
      return Result.fromFailure(app.error!);
    }

    final cards = app.value!.cards;
    cards.sort((a, b) => a.order.compareTo(b.order));
    final lastCard = cards[cards.length - 1];

    return updateCardAsync(lastCard.serialNumber, func);
  }

  // /// Unlink the card from storage.
  // Future<Result> unlinkCardAsync(String serialNumber) {
  //   return getAppAsync()
  //     .then((appRes) { 
  //       if (appRes.success) {
  //         var cards = appRes.value!.cards;
  //         if 
  //       }
  //     })
  // }

  /// Delete the app in storage.
  Future<Result> deleteAppAsync() async {
    final app = await getAppAsync();
    if (app.success == false) {
      return Result.fromSuccess(null);
    }

    final prefs = await SharedPreferences.getInstance();
    prefs.remove('create_application');
    return Result.fromSuccess(null);
  }
}