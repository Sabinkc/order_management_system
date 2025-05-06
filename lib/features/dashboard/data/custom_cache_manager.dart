import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomCache {
  static final CacheManager instance = CacheManager(
    Config(
      'customThumbnailCache',                 // Unique key
      stalePeriod: const Duration(days: 7),   // Clean files older than 7 days
      maxNrOfCacheObjects: 100,    
                  // Max 50 files

      repo: JsonCacheInfoRepository(databaseName: 'thumbnailCache'),
      fileService: HttpFileService(),
    ),
  );
}
