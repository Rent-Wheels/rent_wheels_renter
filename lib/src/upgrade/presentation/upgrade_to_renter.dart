import 'package:flutter/material.dart';

import 'package:rent_wheels_renter/src/home/presentation/home.dart';
import 'package:rent_wheels_renter/src/login/presentation/login.dart';

import 'package:rent_wheels_renter/core/auth/auth_service.dart';
import 'package:rent_wheels_renter/core/widgets/sizes/sizes.dart';
import 'package:rent_wheels_renter/core/widgets/theme/colors.dart';
import 'package:rent_wheels_renter/core/widgets/spacing/spacing.dart';
import 'package:rent_wheels_renter/core/global/globals.dart' as global;
import 'package:rent_wheels_renter/core/widgets/popups/error_popup.dart';
import 'package:rent_wheels_renter/core/widgets/textStyles/text_styles.dart';
import 'package:rent_wheels_renter/core/backend/users/methods/user_methods.dart';
import 'package:rent_wheels_renter/core/widgets/buttons/generic_button_widget.dart';
import 'package:rent_wheels_renter/core/widgets/loadingIndicator/loading_indicator.dart';

class UpgradeUser extends StatefulWidget {
  const UpgradeUser({super.key});

  @override
  State<UpgradeUser> createState() => _UpgradeUserState();
}

class _UpgradeUserState extends State<UpgradeUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: rentWheelsNeutralLight0,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: rentWheelsNeutralLight0,
        actions: [
          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: Sizes().height(context, 0.01)),
            child: IconButton(
              icon: const Icon(
                Icons.logout,
                color: rentWheelsErrorDark700,
              ),
              onPressed: () async {
                buildLoadingIndicator(context, 'Upgrading account');

                try {
                  await AuthService.firebase().logout();
                  if (!mounted) return;
                  Navigator.pop(context);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => const Login(),
                      ),
                      (route) => false);
                } catch (e) {
                  if (!mounted) return;
                  Navigator.pop(context);
                  showErrorPopUp(e.toString(), context);
                }
              },
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_outlined,
              color: rentWheelsErrorDark700,
              size: Sizes().height(context, 0.15),
            ),
            Space().height(context, 0.02),
            const Text(
              'You are not a renter!',
              style: heading3Information,
            ),
            Space().height(context, 0.02),
            const Text(
              'You can upgrade your user account to a renter account.',
              style: body1Information,
              textAlign: TextAlign.center,
            ),
            Space().height(context, 0.04),
            buildGenericButtonWidget(
              context: context,
              isActive: true,
              width: Sizes().width(context, 0.5),
              btnColor: rentWheelsSuccessDark700,
              buttonName: 'Upgrade to Renter',
              onPressed: () async {
                buildLoadingIndicator(context, 'Upgrading account');

                try {
                  final upgradedUser = await RentWheelsUserMethods()
                      .upgradeToRenter(userId: global.user!.uid);

                  global.setGlobals(fetchedUserDetails: upgradedUser);

                  if (!mounted) return;
                  Navigator.pop(context);
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Home(),
                    ),
                    (route) => false,
                  );
                } catch (e) {
                  if (!mounted) return;
                  Navigator.pop(context);
                  showErrorPopUp(e.toString(), context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
