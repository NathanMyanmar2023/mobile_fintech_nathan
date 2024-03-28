class ResponseDataOb {
  dynamic data;
  String? status;

  ResponseDataOb(
      {this.data,
        required this.status,
        });
}

enum LoadPostState {
  firstPage,
  midPage,
  lastPage,
}
