import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';

import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/global/globals.dart' as global;
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels_renter/src/mainSection/profile/widgets/profile_options_widget.dart';

class ProfileMock extends StatelessWidget {
  const ProfileMock({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: rentWheelsNeutralLight0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes().height(context, 0.02)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Profile",
                style: heading3Information,
              ),
              Space().height(context, 0.03),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: Sizes().height(context, 0.081),
                    width: Sizes().width(context, 0.162),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          '${global.baseURL}/${global.userDetails!.profilePicture}',
                        ),
                      ),
                      border: Border.all(color: rentWheelsNeutralLight200),
                      color: rentWheelsNeutralLight0,
                      borderRadius: BorderRadius.circular(
                        Sizes().height(context, 0.015),
                      ),
                    ),
                  ),
                  Space().width(context, 0.03),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        global.userDetails!.name,
                        style: heading5Neutral,
                      ),
                      Space().height(context, 0.005),
                      Text(
                        global.userDetails!.email,
                        style: heading6Neutral900,
                      ),
                    ],
                  )
                ],
              ),
              Space().height(context, 0.03),
              buildProfileOptions(
                context: context,
                section: 'Account Profile',
                svg: 'assets/svgs/account_profile.svg',
                onTap: () {},
              ),
              const Divider(),
              buildProfileOptions(
                context: context,
                section: 'Change Password',
                svg: 'assets/svgs/change_password.svg',
                onTap: () {},
              ),
              const Divider(),
              buildProfileOptions(
                context: context,
                section: 'Notifications',
                svg: 'assets/svgs/notifications.svg',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        alignment: Alignment.center,
        height: Sizes().height(context, 0.1),
        color: rentWheelsNeutralLight0,
        child: buildGenericButtonWidget(
          width: Sizes().width(context, 0.85),
          isActive: true,
          buttonName: 'Logout',
          context: context,
          onPressed: () {},
        ),
      ),
    );
  }
}
