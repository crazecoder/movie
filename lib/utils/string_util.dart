class StringUtil{
  static var oldStr = "/";
  static var replaceStr = "]";
  static String encodeUrl(String url){
    return url.replaceAll(oldStr, replaceStr);
  }
  static String decodeUrl(String url){
    return url.replaceAll(replaceStr, oldStr);
  }
}