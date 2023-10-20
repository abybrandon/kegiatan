import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:newtest/widget/sizedbox_extension.dart';

// class PhotoViewer extends StatelessWidget {
//   final List<String> imageList = [
//     'https://firebasestorage.googleapis.com/v0/b/eventku-d1719.appspot.com/o/event_images%2FScreenshot_7.png?alt=media&token=ee2f9bac-f45d-4058-b010-b4bd38f8a050&_gl=1*en66nn*_ga*MTc3MTE3Nzk4OS4xNjc1ODMyNjA1*_ga_CW55HF8NVT*MTY5NzcwNTIzNi40OS4xLjE2OTc3MDUyNDguNDguMC4w',
//     'https://firebasestorage.googleapis.com/v0/b/eventku-d1719.appspot.com/o/event_images%2FScreenshot_1.png?alt=media&token=ff16e608-4ba9-4fa3-beb7-b0e83e000a41&_gl=1*1tq85ck*_ga*MTc3MTE3Nzk4OS4xNjc1ODMyNjA1*_ga_CW55HF8NVT*MTY5NzcwNTIzNi40OS4xLjE2OTc3MDUyNTguMzguMC4w',
//     'https://firebasestorage.googleapis.com/v0/b/eventku-d1719.appspot.com/o/event_images%2FScreenshot_5.png?alt=media&token=c490e068-023f-438a-8b59-d7e90a90845c&_gl=1*dncxim*_ga*MTc3MTE3Nzk4OS4xNjc1ODMyNjA1*_ga_CW55HF8NVT*MTY5NzcwNTIzNi40OS4xLjE2OTc3MDUyNjYuMzAuMC4w',
//     'https://firebasestorage.googleapis.com/v0/b/eventku-d1719.appspot.com/o/event_images%2FScreenshot_2.png?alt=media&token=f30376f6-05dd-423c-9684-b21067c86dfa&_gl=1*240u9e*_ga*MTc3MTE3Nzk4OS4xNjc1ODMyNjA1*_ga_CW55HF8NVT*MTY5NzcwNTIzNi40OS4xLjE2OTc3MDUyNzQuMjIuMC4w',
//     // Tambahkan URL gambar lainnya sesuai kebutuhan Anda
//   ];

//   final RxInt currentImageIndex = 0.obs;
//   final PageController pageController = PageController();

//   void changeImage(int index) {
//     currentImageIndex.value = index;
//     pageController.animateToPage(
//       index,
//       duration: Duration(milliseconds: 500),
//       curve: Curves.easeInOut,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Photo Viewer'),
//       ),
//       body: SizedBox(
//         height: 300,
//         child: Row(
//           children: [
//             Expanded(
//               child: AnimatedBuilder(
//                 animation: pageController,
//                 builder: (context, child) {
//                   return PageView.builder(
//                     controller: pageController,
//                     itemCount: imageList.length,
//                     onPageChanged: (index) {
//                       changeImage(index);
//                     },
//                     itemBuilder: (context, index) {
//                       return Image.network(imageList[index]);
//                     },
//                   );
//                 },
//               ),
//             ),
//             Expanded(
//               child: SizedBox(
//                 height: 300,
//                 child: Column(
//                   children: imageList.asMap().entries.map((entry) {
//                     int index = entry.key;
//                     String url = entry.value;
//                     return GestureDetector(
//                       onTap: () {
//                         changeImage(index);
//                         print(index);
//                       },
//                       child: Container(
//                         width: 75,
//                         height: 75,
//                         margin: EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             color: currentImageIndex == index
//                                 ? Colors.blue
//                                 : Colors.grey,
//                           ),
//                         ),
//                         child: Image.network(url),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

class PhotoViewer extends StatelessWidget {
  PhotoViewer({super.key});

  final List<String> imageList = [
    'https://firebasestorage.googleapis.com/v0/b/eventku-d1719.appspot.com/o/event_images%2FScreenshot_7.png?alt=media&token=ee2f9bac-f45d-4058-b010-b4bd38f8a050&_gl=1*en66nn*_ga*MTc3MTE3Nzk4OS4xNjc1ODMyNjA1*_ga_CW55HF8NVT*MTY5NzcwNTIzNi40OS4xLjE2OTc3MDUyNDguNDguMC4w',
    'https://firebasestorage.googleapis.com/v0/b/eventku-d1719.appspot.com/o/event_images%2FScreenshot_1.png?alt=media&token=ff16e608-4ba9-4fa3-beb7-b0e83e000a41&_gl=1*1tq85ck*_ga*MTc3MTE3Nzk4OS4xNjc1ODMyNjA1*_ga_CW55HF8NVT*MTY5NzcwNTIzNi40OS4xLjE2OTc3MDUyNTguMzguMC4w',
    'https://firebasestorage.googleapis.com/v0/b/eventku-d1719.appspot.com/o/event_images%2FScreenshot_5.png?alt=media&token=c490e068-023f-438a-8b59-d7e90a90845c&_gl=1*dncxim*_ga*MTc3MTE3Nzk4OS4xNjc1ODMyNjA1*_ga_CW55HF8NVT*MTY5NzcwNTIzNi40OS4xLjE2OTc3MDUyNjYuMzAuMC4w',
    'https://firebasestorage.googleapis.com/v0/b/eventku-d1719.appspot.com/o/event_images%2FScreenshot_2.png?alt=media&token=f30376f6-05dd-423c-9684-b21067c86dfa&_gl=1*240u9e*_ga*MTc3MTE3Nzk4OS4xNjc1ODMyNjA1*_ga_CW55HF8NVT*MTY5NzcwNTIzNi40OS4xLjE2OTc3MDUyNzQuMjIuMC4w',
    // Tambahkan URL gambar lainnya sesuai kebutuhan Anda
  ];

  final RxInt currentImageIndex = 0.obs;
  final PageController pageController = PageController();

  void changeImage(int index) {
    currentImageIndex.value = index;
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2, // Mengambil 2/3 dari lebar
                  child: Container(
                    height: 300,
                    child: AnimatedBuilder(
                      animation: pageController,
                      builder: (context, child) {
                        return PageView.builder(
                          controller: pageController,
                          itemCount: imageList.length,
                          onPageChanged: (index) {
                            changeImage(index);
                          },
                          itemBuilder: (context, index) {
                            return Image.network(imageList[index]);
                          },
                        );
                      },
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Container(
                      height: 300,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            20.h.heightBox,
                            Column(
                              children: imageList.asMap().entries.map((entry) {
                                int index = entry.key;
                                String url = entry.value;
                                return GestureDetector(
                                  onTap: () {
                                    changeImage(index);
                                    print(index);
                                  },
                                  child: Container(
                                    width: 75,
                                    height: 75,
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: currentImageIndex == index
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                    ),
                                    child: Image.network(url),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    )),
              ],
            ),
            Text('ini dibawah'),
            Text('ini dibawah'),
            Text('ini dibawah'),
            Text('ini dibawah'),
            Text('ini dibawah'),
            Text('ini dibawah'),
            Text('ini dibawah'),
            Text('ini dibawah'),
            Text('ini dibawah'),
            Text('ini dibawah'),
            Text('ini dibawah'),
            Text('ini dibawah'),
            Text('ini dibawah'),
            Text('ini dibawah'),
          ],
        ),
      ),
    );
  }
}

class ScrolledHorizontalRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: List.generate(10, (index) {
          return Container(
            width: 100,
            height: 300,
            color: Colors.blue,
            margin: EdgeInsets.all(8),
          );
        }),
      ),
    );
  }
}

class ScrolledVerticalColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView(
        scrollDirection: Axis.vertical,
        children: List.generate(10, (index) {
          return Container(
            width: 100,
            height: 300,
            color: Colors.green,
            margin: EdgeInsets.all(8),
          );
        }),
      ),
    );
  }
}
