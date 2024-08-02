import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fnge/resources/colors.dart';

class NetworkUserSelectorWidget extends StatelessWidget {
  final String name;
  final String user_name;
  final String amount;
  final String image;
  final int user_id;
  const NetworkUserSelectorWidget({
    super.key,
    required this.name,
    required this.user_id,
    required this.user_name,
    required this.amount,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1.0)),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        onPressed: () {},
        child: SizedBox(
          height: 70,
          width: double.infinity,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: AspectRatio(
                  aspectRatio: 1 / 1,
                  child: CachedNetworkImage(
                    imageUrl: image,
                    // placeholder: (context, url) => CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      user_name,
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.grey.shade800,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 13,
                        color: colorPrimary,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                "$amount USD",
                style: TextStyle(
                  fontSize: 15, color: Colors.grey.shade800,
                  // fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
