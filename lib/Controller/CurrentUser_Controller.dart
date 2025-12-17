import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Model/CurrentUser_Model.dart';
import '../configurations/http_helpers.dart';


class CurrentUserController extends GetxController {
  final isLoading = false.obs;
  final user = Rxn<CurrentUser>();
  final errorMessage = ''.obs;
  final box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    box.write('lastSeen', DateTime.now().toIso8601String());
    fetchCurrentUser();
  }

  Future<void> fetchCurrentUser() async {
    print('TOKEN: ${GetStorage().read("token")}');
    print('TOKEN: ${GetStorage().read("token")}');

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await HttpHelper.getRequest(
        endpoint: 'users/GetCurrentUser',
      );

      if (response['success'] == true) {
        user.value = CurrentUser.fromJson(response['data']);
      } else {
        errorMessage.value =
            response['message'] ?? 'Failed to load user data';
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
