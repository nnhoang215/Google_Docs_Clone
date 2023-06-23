import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_docs_clone/app/constants.dart';

abstract class Dependency {
  static Provider<Client> get client => _clientProvider;
  static Provider<Database> get database => _databaseProvider;
  static Provider<Account> get account => _accountProvider;
  static Provider<Realtime> get realtime => _realtimeProvider;
}

final _clientProvider = Provider<Client>(
  (ref) => Client()
    ..setProject(appwriteProjectId)
    ..setSelfSigned(status: true)
    ..setEndpoint(appwriteEndpoint),
);

final _databaseProvider = Provider<Database>( //store collections & documents
  (ref) => Database(ref.read(_clientProvider))
);

final _accountProvider = Provider<Account>( // for authentications
  (ref) => Account(ref.read(_clientProvider))
);

// realtime events -> react to changes
final _realtimeProvider = Provider<Realtime>( 
  (ref) => Realtime(ref.read(_clientProvider))
);