import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newtest/theme.dart';

class ExpandableWidget extends StatelessWidget {
  final String tittle;
  final Widget widget;

  const ExpandableWidget(
      {super.key, required this.tittle, required this.widget});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.r),
        topRight: Radius.circular(10.r),
      ),
      child: ExpandableNotifier(
          initialExpanded: false,
          child: Container(
            decoration: BoxDecoration(color: bgRed, border: null),
            child: Column(
              children: <Widget>[
                ScrollOnExpand(
                  scrollOnCollapse: true,
                  scrollOnExpand: true,
                  theme: const ExpandableThemeData(),
                  child: ExpandablePanel(
                    theme: ExpandableThemeData(
                        headerAlignment: ExpandablePanelHeaderAlignment.center,
                        tapBodyToCollapse: true,
                        iconColor: bgWhite),
                    header: Padding(
                      padding: EdgeInsets.only(left: 14.w),
                      child: Text(tittle,
                          style: TextStyle(
                              fontWeight: Config.semiBold,
                              fontSize: textBig,
                              color: bgWhite)),
                    ),
                    collapsed: const SizedBox.shrink(),
                    expanded: Container(
                      color: bgWhite,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
                            child: widget,
                          )
                        ],
                      ),
                    ),
                    builder: (_, collapsed, expanded) {
                      return Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      );
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
