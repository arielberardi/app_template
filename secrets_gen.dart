/* SECRET GENERATOR
Script that reads a secret json file with keys and values and applies those
to different android/ios/dart files so it can setup the keys/token
to be used by Facebook and Google Sign In

How to use:
- Create a file "secrets.json" with the needed keys:
{
    "GOOGLE_CLIENT_ID": "",
    "GOOGLE_REVERSED_ID": "",
    "FACEBOOK_CLIENT_TOKEN":"",
    "FACEBOOK_APP_ID":"",
    "FACEBOOK_APP_NAME":""
}

- Fill it with the right values
- Run the script: dart secrets_gen.dart
*/

// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

const androidTemplate = '<?xml version="1.0" encoding="utf-8"?>\n'
    '<resources>\n'
    '<string name="facebook_app_id">__TEMPLATE_FACEBOOK_APP_ID</string>\n'
    '<string name="fb_login_protocol_scheme">fb__TEMPLATE_FACEBOOK_APP_ID</string>\n'
    '<string name="facebook_client_token">__TEMPLATE_FACEBOOK_CLIENT_TOKEN</string>\n'
    '</resources>';

const iosTemplate = 'GOOGLE_CLIENT_ID=__TEMPLATE_GOOGLE_CLIENT_ID\n'
    'GOOGLE_REVERSED_ID=__TEMPLATE_GOOGLE_REVERSED_ID\n'
    'FACEBOOK_CLIENT_TOKEN=__TEMPLATE_FACEBOOK_CLIENT_TOKEN\n'
    'FACEBOOK_APP_ID=__TEMPLATE_FACEBOOK_APP_ID\n'
    'FACEBOOK_APP_NAME=__TEMPLATE_FACEBOOK_APP_NAME';

const envTemplate = 'GOOGLE_CLIENT_ID=__TEMPLATE_GOOGLE_CLIENT_ID\n'
    'FACEBOOK_APP_ID=__TEMPLATE_FACEBOOK_APP_ID';

void main(List<String> arguments) {
  try {
    final secrets = readSecrets('secrets.json');

    writeFile(
      'android/app/src/main/res/values/strings.xml',
      replaceText(androidTemplate, secrets),
    );

    writeFile(
      './ios/Flutter/Env.xcconfig',
      replaceText(iosTemplate, secrets),
    );

    writeFile(
      '.env',
      replaceText(envTemplate, secrets),
    );

    print('Replacement completed.');
  } catch (e) {
    print('An error occurred: $e');
  }
}

Map<String, dynamic> readSecrets(String path) {
  final File input = File(path);

  final jsonContent = input.readAsStringSync();
  final Map<String, dynamic> secrets = json.decode(jsonContent);

  return secrets;
}

void writeFile(String path, String content) {
  final File output = File(path);
  output.writeAsStringSync(content);
}

String replaceText(String text, Map<String, dynamic> secrets) {
  String result = text;

  secrets.forEach((key, value) {
    result = result.replaceAll('__TEMPLATE_$key', value);
  });

  return result;
}
