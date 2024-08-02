import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fnge/bloc/network/level_users_bloc.dart';
import 'package:fnge/helpers/response_ob.dart';
import 'package:fnge/resources/colors.dart';
import 'package:fnge/views/widgets/network_user_selector_widget.dart';

class NetworkUsersScreen extends StatefulWidget {
  final String level;
  final String user_count;
  const NetworkUsersScreen({
    super.key,
    required this.level,
    required this.user_count,
  });

  @override
  State<NetworkUsersScreen> createState() => _NetworkUsersScreenState();
}

class _NetworkUsersScreenState extends State<NetworkUsersScreen> {
  bool isLoading = false;
  bool isFetching = false;
  final scroll_controller = ScrollController();

  final _level_users_bloc = LevelUsersBloc();
  late Stream<ResponseOb> _level_users_stream;

  int page = 1;
  int limit = 20;
  bool hasMore = true;

  List users_list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _level_users_stream = _level_users_bloc.levelUsersStream();
    _level_users_stream.listen((ResponseOb resp) {
      if (resp.success) {
        setState(() {
          for (var i = 0; i < resp.data.data.length; i++) {
            users_list.add([
              resp.data.data[i].id,
              resp.data.data[i].name,
              resp.data.data[i].username,
              resp.data.data[i].totalInvestAmount.toString(),
              resp.data.data[i].imageLocation,
            ]);
          }
          isLoading = false;
          page++;
          isFetching = false;
          if (resp.data.data.length < limit) {
            hasMore = false;
          }
        });
      } else {
        isLoading = false;
        print("ERROR");
      }
    });

    fetch();

    //Scroll controller
    scroll_controller.addListener(() {
      if (scroll_controller.position.maxScrollExtent ==
          scroll_controller.offset) {
        fetch();
      }
    });
  }

  Future fetch() async {
    print(hasMore);

    if (isFetching) return;
    isFetching = true;
    if (hasMore == true) {
      _level_users_bloc.getLevelUsers(page, widget.level);
      print("getting page - $page");
    }
  }

  Future refersh() async {
    setState(() {
      isFetching = false;
      hasMore = true;
      page = 1;
      users_list.clear();
    });

    fetch();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(1.0)),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SpinKitFadingFour(
            itemBuilder: (BuildContext context, int index) {
              return DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: index.isEven ? Colors.blue : Colors.grey.shade800,
                ),
              );
            },
          ),
        ),
      );
    } else {
      return Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios, color: colorPrimary),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(
                "Level-${widget.level} Users",
                style: const TextStyle(
                  fontSize: 18,
                  color: colorPrimary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: refersh,
            child: ListView.builder(
              controller: scroll_controller,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: users_list.length + 1,
              itemBuilder: (context, index) {
                if (index < users_list.length) {
                  final user = users_list[index];
                  return NetworkUserSelectorWidget(
                    user_id: user[0],
                    name: user[1],
                    user_name: user[2],
                    amount: user[3],
                    image: user[4],
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Center(
                      child: hasMore
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                              ))
                          : const Text(
                              "No More User",
                              style: TextStyle(
                                fontSize: 13,
                              ),
                            ),
                    ),
                  );
                }
              },
            ),
          ));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scroll_controller.dispose();
  }
}
