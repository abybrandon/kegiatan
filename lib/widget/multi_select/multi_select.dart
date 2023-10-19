import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/widget/custom_badge.dart';

import '../../theme.dart';
part 'badge_select_list.dart';

part 'badge_selector_field.dart';
part 'checkbox_list.dart';

class SelectItem<T extends Object> {
  final String label;
  final T value;

  SelectItem({
    required this.label,
    required this.value,
  });
}
