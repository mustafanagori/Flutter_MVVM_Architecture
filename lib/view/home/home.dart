import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mvvm/data/reponse/status.dart';
import 'package:mvvm/res/color/colors.dart';
import 'package:mvvm/res/components/general_exception.dart';
import 'package:mvvm/res/components/internet_exception_widget.dart';
import 'package:mvvm/res/routes/routes_name.dart';
import 'package:mvvm/view_models/controller/user_prefrence/user_prefrence_view_model.dart';

import '../../view_models/controller/home/home_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final homeController = Get.put(HomeController());
  UserPreference userPreference = UserPreference();
  @override
  void initState() {
    super.initState();
    homeController.userListApi();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: AppColor.primaryColor,
          title: const Text(
            "Home screen",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  userPreference.removeUser().then((value) => {
                        Get.toNamed(RouteName.loginScreen),
                      });
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 25,
                ))
          ],
        ),
        body: Obx(() {
          switch (homeController.rxRequestStatus.value) {
            case Status.LOADING:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case Status.ERROR:
              if (homeController.error.value == 'No internet') {
                return InternetExceptionWidget(
                  onPress: () {
                    homeController.refreshApi();
                  },
                );
              } else {
                return GeneralExceptionWidget(onPress: () {
                  homeController.refreshApi();
                }); // Return the Text widget
              }

            case Status.COMPLETED:
              return ListView.builder(
                  itemCount: homeController.userList.value.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(homeController
                              .userList.value.data![index].avatar
                              .toString()),
                        ),
                        title: Text(homeController
                            .userList.value.data![index].firstName
                            .toString()),
                        subtitle: Text(homeController
                            .userList.value.data![index].email
                            .toString()),
                        trailing: Text(homeController
                            .userList.value.data![index].id
                            .toString()),
                      ),
                    );
                  });
          }
        }),
      ),
    );
  }
}
