/// @author 强周亮(qiangzhouliang)
/// @desc 判断对象操作工具类
/// @email 2538096489@qq.com
/// @time 2020/7/27 16:43
class ObjectUtil {
  /// 判断String是否为空.
  static bool isEmptyString(String str) {
    return str == null || str.isEmpty;
  }

  /// 判断List是否为空.
  static bool isEmptyList(Iterable list) {
    return list == null || list.isEmpty;
  }

  /// 判断Map是否为空.
  static bool isEmptyMap(Map map) {
    return map == null || map.isEmpty;
  }

  /// 判断对象是否为空.(String List Map).
  static bool isEmpty(Object object) {
    if (object == null) return true;
    if (object is String && object.isEmpty) {
      return true;
    } else if (object is Iterable && object.isEmpty) {
      return true;
    } else if (object is Map && object.isEmpty) {
      return true;
    }
    return false;
  }

  /// 判断对象是否非空.(String List Map).
  static bool isNotEmpty(Object object) {
    return !isEmpty(object);
  }

  /// 判断两个List是否相等.
  static bool twoListIsEqual(List listA, List listB) {
    if (listA == listB) return true;
    if (listA == null || listB == null) return false;
    int length = listA.length;
    if (length != listB.length) return false;
    for (int i = 0; i < length; i++) {
      if (!listA.contains(listB[i])) {
        return false;
      }
    }
    return true;
  }

  /// 获取对象长度
  static int getLength(Object value) {
    if (value == null) return 0;
    if (value is String) {
      return value.length;
    } else if (value is Iterable) {
      return value.length;
    } else if (value is Map) {
      return value.length;
    } else {
      return 0;
    }
  }
}
