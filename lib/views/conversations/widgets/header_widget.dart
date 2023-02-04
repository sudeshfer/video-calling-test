import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.network(
                // AssetConstants.profileImgUrl,
                "https://previews.123rf.com/images/triken/triken1608/triken160800029/61320775-male-avatar-profile-picture-default-user-avatar-guest-avatar-simply-human-head-vector-illustration-i.jpg",

                width: 45,
                height: 45,
              ),
              const SizedBox(width: 10),
              const Text(
                "Sudesh Fernando",
              ),
            ],
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout),
          )
        ],
      ),
    );
  }
}
