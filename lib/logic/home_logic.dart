import 'package:flutter/material.dart';

import '../bean/tab_item.dart';

abstract class HomeLogicIml {
  List<MovieTabItem> getTabItems();
}

class HomeLogic implements HomeLogicIml {
  @override
  List<MovieTabItem> getTabItems() {
    return <MovieTabItem>[
      const MovieTabItem(Icons.home, "最新更新","/"),
      const MovieTabItem(Icons.movie, "电影","/type/1.html"),
      const MovieTabItem(Icons.video_label, "电视剧","/type/2.html"),
      const MovieTabItem(Icons.warning, "恐怖","/type/9.html"),
      const MovieTabItem(Icons.camera_roll, "综艺","/type/4.html"),
      const MovieTabItem(Icons.music_note, "音乐","/type/6.html"),
      const MovieTabItem(Icons.child_care, "动漫","/type/7.html"),
      const MovieTabItem(Icons.queue_music, "舞曲","/type/11.html"),
    ];
  }
}
