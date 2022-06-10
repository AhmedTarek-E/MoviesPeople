import 'package:flutter/material.dart';
import 'package:movies_people/people/domain/models/person_info.dart';
import 'package:movies_people/utils/app_colors.dart';
import 'package:movies_people/utils/dimensions.dart';
import 'package:movies_people/utils/image_preview/app_network_image.dart';
import 'package:movies_people/utils/text_styles.dart';

class PersonItemView extends StatelessWidget {
  final PersonInfo person;
  final void Function(PersonInfo person)? onPressed;

  const PersonItemView({
    Key? key,
    required this.person,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onPressed != null) {
          onPressed!(person);
        }
      },
      child: Row(
        children: [
          _buildProfilePic(),

          SizedBox(width: PaddingDimensions.normal,),

          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                person.name,
                style: TextStyles.semiBold(
                  color: AppColors.textPrimaryColor,
                  fontSize: Dimensions.large
                ),
              ),

              Text(
                person.formatKnownForTitle(),
                style: TextStyles.regular(
                  color: AppColors.textSecondaryColor,
                  fontSize: Dimensions.normal
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildProfilePic() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: AppNetworkImage(
        image: person.profilePicture,
        width: 64,
        height: 64,
      ),
    );
  }
}

extension on PersonInfo {
  String formatKnownForTitle() {
    return "Known for: $knownForTitle";
  }
}
