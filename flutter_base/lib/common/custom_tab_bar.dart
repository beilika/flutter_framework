import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends PreferredSize {
  /// tab 集合
  final List<CustomHeightTab> _tabs = new List();

  /// 指示器长度类型
  final TabBarIndicatorSize indicatorSize;

  /// tabBar 背景色
  final Color backgroundColor;

  /// 无图标tabBar高度
  final double kTabHeight;

  /// 有图标tabBar高度
  final double kTextAndIconTabHeight;

  /// 选中指示器高度
  final double indicatorWeight;

  /// 指示器颜色
  final Color indicatorColor;

  /// 多标签是否可以滚动
  final bool isScrollable;

  /// tab控制器
  final TabController controller;

  /// 指示器边距
  final EdgeInsetsGeometry indicatorPadding;

  /// 指示器样式
  final Decoration indicator;

  /// 标签颜色
  final Color labelColor;

  /// 标签字体样式
  final TextStyle labelStyle;

  /// 标签边距
  final EdgeInsetsGeometry labelPadding;

  /// 未选中标签样式
  final Color unselectedLabelColor;

  /// 未选中标签字体样式
  final TextStyle unselectedLabelStyle;

  final DragStartBehavior dragStartBehavior;

  /// 点击tab触发函数
  final ValueChanged<int> onTap;

  /// TabBar中添加Tab
  void addTab(text, [Icon icon, Widget child]) {
    // 添加真正使用到的自定义tab
    _tabs.add(CustomHeightTab(
      text: text,
      icon: icon,
      child: child,
      kTabHeight: this.kTabHeight,
      kTextAndIconTabHeight: this.kTextAndIconTabHeight,
    ));
  }

  CustomTabBar({
    Key key,
    @required List<Tab> tabs,
    this.backgroundColor = Colors.white,
    this.kTabHeight = 30,
    this.kTextAndIconTabHeight = 46,
    this.controller,
    this.isScrollable = false,
    this.indicatorColor,
    this.indicatorWeight = 2.0,
    this.indicatorPadding = EdgeInsets.zero,
    this.indicator,
    this.indicatorSize,
    this.labelColor=Colors.black,
    this.labelStyle,
    this.labelPadding,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
    this.dragStartBehavior = DragStartBehavior.start,
    this.onTap,
  })  : assert(tabs != null),
        assert(isScrollable != null),
        assert(dragStartBehavior != null),
        assert(indicator != null ||
            (indicatorWeight != null && indicatorWeight > 0.0)),
        assert(indicator != null || (indicatorPadding != null)) {
    // 普通Tab全部转为自定义Tab，多一层转换是为了统一高度解耦，防止直接传入LogisticsTab自定义高度冲突
    for (Tab item in tabs) {
      addTab(item.text, item.icon, item.child);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 为了添加背景色，又包装了一层，高度都要统一
    return Material(
      //这里设置tab的背景色
      color: Colors.white,
      child: CustomHeightTabBar(
          isScrollable: this.isScrollable,
          indicatorColor: this.indicatorColor,
          indicatorWeight: this.indicatorWeight,
          indicator: this.indicator,
          indicatorSize: this.indicatorSize,
          indicatorPadding: this.indicatorPadding,
          labelStyle: this.labelStyle,
          labelColor: this.labelColor,
          labelPadding: this.labelPadding,
          unselectedLabelColor: this.unselectedLabelColor,
          unselectedLabelStyle: this.unselectedLabelStyle,
          dragStartBehavior:this.dragStartBehavior,
          onTap: this.onTap,
          kTabHeight: this.kTabHeight,
          kTextAndIconTabHeight: this.kTextAndIconTabHeight,
          tabs: this._tabs),
    );
  }

  @override
  Size get preferredSize {
    for (Widget item in _tabs) {
      if (item is Tab) {
        final Tab tab = item;
        if (tab.text != null && tab.icon != null) {
          return Size.fromHeight(kTextAndIconTabHeight + indicatorWeight);
        }
      }
    }
    // tab高度加上指示器高度
    return Size.fromHeight(kTabHeight + indicatorWeight);
  }
}

class CustomHeightTabBar extends TabBar {
  final double kTabHeight;
  final double kTextAndIconTabHeight;

  CustomHeightTabBar(
      {indicatorSize,
        indicatorColor,
        controller,
        isScrollable,
        indicatorPadding,
        indicator,
        double indicatorWeight = 2,
        tabs,
        labelStyle,
        labelColor = Colors.black,
        labelPadding,
        unselectedLabelColor,
        unselectedLabelStyle,
        onTap,
        dragStartBehavior,
        this.kTabHeight = 23,
        this.kTextAndIconTabHeight = 46})
      : super(
    indicatorColor: indicatorColor,
    controller: controller,
    isScrollable: isScrollable,
    indicatorPadding: indicatorPadding,
    indicatorSize: indicatorSize,
    indicator: indicator,
    indicatorWeight: indicatorWeight,
    tabs: tabs,
    labelStyle: labelStyle,
    labelColor: labelColor,
    labelPadding: labelPadding,
    unselectedLabelColor: unselectedLabelColor,
    unselectedLabelStyle: unselectedLabelStyle,
    onTap: onTap,
    dragStartBehavior: dragStartBehavior,
  );
  // 重写获取定义高度方法
  @override
  Size get preferredSize {
    for (Widget item in tabs) {
      if (item is Tab) {
        final Tab tab = item;
        if (tab.text != null && tab.icon != null) {
          return Size.fromHeight(kTextAndIconTabHeight + indicatorWeight);
        }
      }
    }
    return Size.fromHeight(kTabHeight + indicatorWeight);
  }
}

class CustomHeightTab extends Tab {
  final double kTabHeight;
  final double kTextAndIconTabHeight;
  final String text;
  final Icon icon;
  final Widget child;

  CustomHeightTab(
      {Key key,
        this.text,
        this.icon,
        this.child,
        this.kTabHeight = 23,
        this.kTextAndIconTabHeight = 23})
      : super(text: text, icon: icon, child: child);

  Widget _buildLabelText() {
    return child ?? Text(text, softWrap: false, overflow: TextOverflow.fade);
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasMaterial(context));

    double height;
    Widget label;
    if (icon == null) {
      height = kTabHeight;
      label = _buildLabelText();
    } else if (text == null && child == null) {
      height = kTabHeight;
      label = icon;
    } else {
      height = kTextAndIconTabHeight;
      label = Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            child: icon,
            margin: const EdgeInsets.only(bottom: 10.0),
          ),
          _buildLabelText(),
        ],
      );
    }

    return SizedBox(
      height: height,
      child: Center(
        child: label,
        widthFactor: 1.0,
      ),
    );
  }
}
