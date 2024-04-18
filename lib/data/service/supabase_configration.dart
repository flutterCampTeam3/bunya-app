import 'package:bunya_app/data/service/supabase_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';

databaseConfig() async {
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
      url: dotenv.env["urlSupabase"]!,
      anonKey: dotenv.env["anoneKeySupabase"]!);
}

Future<void> setup() async {
  await GetStorage.init();
  GetIt.instance;
  GetIt.I.registerSingleton<DBService>(DBService());
}
