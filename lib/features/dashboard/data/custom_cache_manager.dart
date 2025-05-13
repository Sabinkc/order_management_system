import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class LimitedCacheManager extends CacheManager {
  static const key = 'limitedImageCache'; // ✅ More generic key name

  static final LimitedCacheManager _instance = LimitedCacheManager._();

  factory LimitedCacheManager() {
    return _instance;
  }

  LimitedCacheManager._()
      : super(
          Config(
            key,
            stalePeriod: const Duration(days: 7), // Clear older files
            maxNrOfCacheObjects: 200, // Max number of files
            repo: JsonCacheInfoRepository(databaseName: key),
            fileService: HttpFileService(),
          ),
        );
}
