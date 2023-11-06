import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_cfg_repository.g.dart';

class RemoteCfgRepository {
  const RemoteCfgRepository(this.instance);
  final FirebaseRemoteConfig instance;

  bool getBool(String key) => instance.getBool(key);
  double getDouble(String key) => instance.getDouble(key);
  int getInt(String key) => instance.getInt(key);
  String getString(String key) => instance.getString(key);
  RemoteConfigValue getValue(String key) => instance.getValue(key);

  // Note: This repository can have specific methods for given
  // configurations of the app.
}

@Riverpod(keepAlive: true)
RemoteCfgRepository remoteCfgRepository(RemoteCfgRepositoryRef ref) {
  // We use UnimplementedError as the Firebase Remote Config may not be available
  // at the startup of the app so we rely on Dependency Override from riverpod
  // to set the value for this provider.
  // Which is going to be RemoteCfgRepository(FirebaseRemoteConfig.instance)
  throw UnimplementedError();
}
