import 'package:get/get.dart';

import '../Model/CurrentUser_Model.dart';
import '../configurations/http_helpers.dart';


class CurrentUserController extends GetxController {
  final isLoading = false.obs;
  final user = Rxn<CurrentUser>();
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentUser();
  }

  Future<void> fetchCurrentUser() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final response = await HttpHelper.getRequest(
        endpoint: 'users/GetCurrentUser',
        headers: {
          'accept': 'text/plain',
        },
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
