import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ve_amor_app/common/widgets/appbar/appbar.dart';
import 'package:ve_amor_app/common/widgets/bottom_button/bottom_button.dart';
import 'package:ve_amor_app/common/widgets/list_tile/settings_menu_tile.dart';
import 'package:ve_amor_app/data/services/location/location_service.dart';
import 'package:ve_amor_app/features/authentication/controller/initial_information/initial_information_controller.dart';
import 'package:ve_amor_app/utils/constants/colors.dart';
import 'package:ve_amor_app/utils/constants/sizes.dart';
import 'package:ve_amor_app/utils/constants/text_strings.dart';
import 'package:ve_amor_app/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/camera/custom_camera.dart';
import '../../../../common/widgets/question_section/question_section.dart';
import '../../../../generated/assets.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/lifestyle_options.dart';
import '../../../../utils/popups/full_screen_loader.dart';
import '../../../../utils/popups/loaders.dart';
import 'add_photo/initial_profile_photo.dart';

part 'initial_name.dart';

part 'initial_birthday_page.dart';

part 'initial_gender.dart';

part 'initial_interested.dart';

part 'initial_recent_pictures.dart';

part 'initial_lifestyle.dart';

part 'initial_finding_relationship.dart';

part 'identity_verification_qr.dart';

part 'identity_verification_face.dart';

part 'initial_location.dart';

