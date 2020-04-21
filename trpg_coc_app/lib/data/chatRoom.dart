class chatMsg{
  String msg;
  bool isFormal;
  int acceptMask;//特定用户可以收到
  int timeStamp;//时间戳，用于排序
  int sender;
  int roomId;
}
