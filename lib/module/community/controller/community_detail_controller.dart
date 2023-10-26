import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:newtest/widget/toast.dart';
import 'package:image_picker/image_picker.dart';
import '../../../admin/module/create_community/model/community_model.dart';
import '../datasource/community_datasource.dart';

class CommunityDetailController extends GetxController with StateMixin {
  CommunityCollections firestoreCollections = CommunityCollections();

  @override
  void onInit() {
    change(null, status: RxStatus.success());

    fetchDetailById(Get.parameters["id"]!);
    super.onInit();
  }

  //data
  RxString nameCommun = ''.obs;
  String sloganCommun = '';
  String pictCommun = '';
  String locationCommun = '';
  String linkFacebook = '';
  String linkInstagram = '';
  String bio = '';

  final Rx<CommunityModel?> dataDetail = Rx<CommunityModel?>(null);

  Future<void> fetchDetailById(String id) async {
    change(null, status: RxStatus.loading());
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Toast.showErrorToastWithoutContext('No Internet Connection');
    } else {
      try {
        final DocumentSnapshot<Object?> snapshot =
            await firestoreCollections.communityCollection.doc(id).get();

        if (snapshot.exists) {
          final dataGet =
              CommunityModel.fromJson(snapshot.data() as Map<String, dynamic>);

          dataDetail.value = dataGet;
          nameCommun.value = dataGet.communityName;
          pictCommun = dataGet.communityPicture;
          sloganCommun = dataGet.communitySlogan;
          locationCommun = dataGet.location['locationName'];
          linkFacebook = dataGet.communitySocialMedia.facebookLink;
          linkInstagram = dataGet.communitySocialMedia.instagramLink;
          bio = dataGet.communityBio;
        } else {
          print('Dokumen tidak ditemukan');
        }
      } catch (e) {
        Toast.showErrorToastWithoutContext('Something Error');
        print(e.toString());
      }
    }

    change(null, status: RxStatus.success());
  }

  //appbar

  final RxBool isAppBarVisible = false.obs;
  final RxBool isSearching = false.obs;

  var selectedImagePath = ''.obs;
  var croppedImagePath = ''.obs;

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
    }
  }

  Future<void> cropImage() async {
    final croppedImage = await ImageCropper().cropImage(
      sourcePath: selectedImagePath.value,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      aspectRatio: CropAspectRatio(ratioX: 360, ratioY: 200),
    );

    if (croppedImage != null) {
      croppedImagePath.value = croppedImage.path;
    }
  }
}
