class ResponseOb {
  dynamic data;
  String? message;
  bool success;
  LoadPostState? loadPostState;
  bool? authorized = true;

  ResponseOb(
      {this.data,
      this.message,
      required this.success,
      this.loadPostState,
      this.authorized});
}

enum LoadPostState {
  firstPage,
  midPage,
  lastPage,
}
