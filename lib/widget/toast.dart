import 'package:newtest/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remixicon/remixicon.dart';

import '../main.dart';

class Toast {
  static showErrorToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(12),
        backgroundColor: const Color(0xFFFF0022),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        content: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 5),
              child: const Icon(
                Icons.error,
                color: Colors.white,
                size: 13,
              ),
            ),
            Flexible(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static showSuccessToast(BuildContext context, String message) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 500),
        behavior: SnackBarBehavior.floating,
        width: MediaQuery.of(context).size.width * 0.9,
        padding: const EdgeInsets.all(12),
        backgroundColor: const Color(0xFF00A455),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        content: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(right: 5),
              child: const Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 13,
              ),
            ),
            Flexible(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static showErrorToastWithoutContext(String message) {
    rootScaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 700),
        behavior: SnackBarBehavior.floating,
        width: 320.sp,
        padding: EdgeInsets.all(12.sp),
        backgroundColor: bgWhite,
        elevation: 1,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFFE6E6E6)),
          borderRadius: BorderRadius.circular(8),
        ),
        content: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 8.sp),
              child: Icon(
                Icons.error,
                color: bgRed,
                size: 16.sp,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Error',
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: bgRed,
                        fontWeight: Config.semiBold),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: bgGrey,
                        fontWeight: Config.reguler),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static showWarningToastWithoutContext(String message) {
    rootScaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 700),
        behavior: SnackBarBehavior.floating,
        width: 320.sp,
        padding: const EdgeInsets.all(12),
        backgroundColor: bgWhite,
        elevation: 1,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFFE6E6E6)),
          borderRadius: BorderRadius.circular(8),
        ),
        content: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 8.sp),
              child: Icon(
                Icons.warning,
                color: yellowMap,
                size: 16.sp,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Warning',
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: yellowMap,
                        fontWeight: Config.semiBold),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: bgGrey,
                        fontWeight: Config.reguler),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static showSuccessToastWithoutContext(String message) {
    rootScaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 700),
        behavior: SnackBarBehavior.floating,
        width: 320.sp,
        padding: const EdgeInsets.all(12),
        backgroundColor: bgWhite,
        elevation: 1,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: Color(0xFFE6E6E6)),
          borderRadius: BorderRadius.circular(8),
        ),
        content: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 8.sp),
              child: Icon(
                Icons.check_circle,
                color: Color(0xFF00A455),
                size: 16.sp,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Success',
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: Color(0xFF00A455),
                        fontWeight: Config.semiBold),
                  ),
                  Text(
                    message,
                    style: TextStyle(
                        fontSize: 12.sp,
                        color: bgGrey,
                        fontWeight: Config.reguler),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomToast {
  static void showErrorToast(BuildContext context, String message) {
    final overlay = Overlay.of(context);
    OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).size.height * 0.5,
        left: MediaQuery.of(context).size.width * 0.1,
        child: Material(
          color: Colors.transparent,
          child: Container(
            width: 320.sp,
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              color: bgRed,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.error,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(width: 8),
                Flexible(
                  child: Text(
                    message,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    // Hapus Toast setelah beberapa detik
    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}

// Panggil CustomToast.showErrorToast seperti berikut in
