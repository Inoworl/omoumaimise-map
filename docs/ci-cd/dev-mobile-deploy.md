# Dev mobile deployment

Dev mobile deployment is managed by GitHub Actions.

## Workflows

| Workflow | Trigger | Destination |
| --- | --- | --- |
| `[Release] Dev Android` | push to `dev`, manual dispatch | Firebase App Distribution |
| `[Release] Dev iOS` | manual dispatch only | TestFlight |

Flutter-only CI does not require Docker. Supabase local development still uses Supabase CLI, which requires a Docker API compatible container runtime.

Android dev deploy intentionally uses Firebase App Distribution first. It does not require a Google Play Console app. Add Google Play internal testing only after the `com.inoworl.omoumaimise.dev` app exists in Google Play Console.

iOS dev deploy uses TestFlight only. Do not use Firebase App Distribution for iOS in the initial release pipeline. The `com.inoworl.omoumaimise.dev` app must exist in App Store Connect before running the workflow. The workflow is manual-only until App Store Connect setup, signing assets, and GitHub Actions secrets are complete.

## Console ownership

| Console | Account | Purpose |
| --- | --- | --- |
| Firebase Console | `g.g.rereagirx84@gmail.com` | Firebase project, app registration, App Distribution, FCM/APNs |
| Google Play Console | `keisukeshimizu.inoworl@gmail.com` | Android app creation, internal testing, Play service account |
| App Store Connect | Apple Developer account | iOS app creation, TestFlight, App Store Connect API key |

## Console setup status

Checked on 2026-06-25.

| Item | Status | Notes |
| --- | --- | --- |
| Firebase dev project | Done | `omoumaimise-map-dev` is accessible from `g.g.rereagirx84@gmail.com` |
| Firebase Android app | Done | Registered as `com.inoworl.omoumaimise.dev` |
| Firebase iOS app | Done | Registered as `com.inoworl.omoumaimise.dev` |
| Firebase App Distribution for Android | Done | Android onboarding is complete and the `internal-testers` group exists |
| Firebase App Distribution for iOS | Not used | iOS dev distribution uses TestFlight instead |
| Firebase Cloud Messaging for Android | Ready for Firebase app registration | Android app is registered; client-side notification handling is still separate app work |
| Firebase APNs for iOS | Missing | APNs auth keys and APNs certificates are not uploaded for development or production |
| Google Play Console dev app | Missing | `com.inoworl.omoumaimise.dev` is not yet listed under Inoworl |
| App Store Connect dev app | Missing | Omoumaimise app is not yet listed; Apple Developer Program agreement also needs Account Holder review |

## Android dev deploy

Workflow: `.github/workflows/deploy_dev_android.yml`

The workflow builds the `dev` flavor APK from `apps/mobile_flutter` and distributes it to Firebase App Distribution.

Firebase App Distribution is enabled for the Android dev app. The default distribution group is `internal-testers`.

Required GitHub Actions environment: `dev`

Required secrets:

| Secret | Purpose |
| --- | --- |
| `DEV_GOOGLE_SERVICES_JSON_BASE64` | Base64 encoded `android/app/src/dev/google-services.json`. Registered in the `dev` environment |
| `DEV_FIREBASE_OPTIONS_DART_BASE64` | Base64 encoded `lib/firebase_options.dart`. Registered in the `dev` environment |
| `DEV_DART_DEFINE_JSON_BASE64` | Base64 encoded `dart_define/dev_dart_define.json`. Registered in the `dev` environment |
| `ANDROID_UPLOAD_KEYSTORE_JKS_BASE64` | Base64 encoded Android upload keystore |
| `ANDROID_UPLOAD_KEYSTORE_PASSWORD` | Android keystore password |
| `ANDROID_UPLOAD_KEY_ALIAS` | Android key alias |
| `ANDROID_UPLOAD_KEY_PASSWORD` | Android key password |
| `DEV_FIREBASE_SERVICE_ACCOUNT_KEY_BASE64` | Base64 encoded Firebase service account JSON |
| `DEV_FIREBASE_PROJECT_ID` | Firebase dev project ID. Registered in the `dev` environment |
| `DEV_FIREBASE_ANDROID_APP_ID` | Firebase Android app ID. Registered in the `dev` environment |
| `DEV_FIREBASE_APP_DISTRIBUTION_GROUPS` | Firebase App Distribution groups. Registered as `internal-testers` in the `dev` environment |

Expected dev package name: `com.inoworl.omoumaimise.dev`

Google Play internal testing is intentionally not enabled in this workflow yet. Firebase App Distribution does not require a Google Play Console app. Add Google Play internal testing after the `com.inoworl.omoumaimise.dev` app exists in Google Play Console and the service account has release permissions.

## iOS dev deploy

Workflow: `.github/workflows/deploy_dev_ios.yml`

The workflow builds the `dev` flavor IPA and uploads it to TestFlight with Fastlane.

This workflow is manual-only because TestFlight cannot be used until the dev app exists in App Store Connect.

Required GitHub Actions environment: `dev`

Required secrets:

| Secret | Purpose |
| --- | --- |
| `DEV_GOOGLESERVICE_INFO_PLIST_BASE64` | Base64 encoded dev `GoogleService-Info.plist` |
| `DEV_FIREBASE_OPTIONS_DART_BASE64` | Base64 encoded `lib/firebase_options.dart` |
| `DEV_DART_DEFINE_JSON_BASE64` | Base64 encoded `dart_define/dev_dart_define.json` |
| `CERT_PWD` | Password for the `.p12` signing certificate and temporary keychain |
| `IOS_CERTIFICATE_BASE64` | Base64 encoded `.p12` signing certificate |
| `DEV_PROVISIONING_PROFILE_BASE64` | Base64 encoded dev App Store provisioning profile |
| `DEV_PROVISIONING_PROFILE_NAME` | Provisioning profile name registered in Apple Developer |
| `DEVELOPMENT_TEAM` | Apple Developer Team ID |
| `DEV_BUNDLE_ID` | iOS dev bundle ID |
| `ASC_KEY_ID` | App Store Connect API key ID |
| `ASC_ISSUER_ID` | App Store Connect issuer ID |
| `ASC_API_KEY_BASE64` | Base64 encoded App Store Connect `.p8` API key |
| `IPA_OUTPUT_NAME` | Optional IPA output name. Defaults to `Omoumaimise-Dev` |

Expected dev bundle ID: `com.inoworl.omoumaimise.dev`

TestFlight upload requires the App Store Connect app for `com.inoworl.omoumaimise.dev`, an Apple Distribution certificate, an App Store provisioning profile, and an App Store Connect API key. Push notifications also require an APNs auth key uploaded to Firebase Cloud Messaging.

## Secret generation

Generate Base64 values without line wrapping:

```sh
base64 -i path/to/file | tr -d '\n'
```

Do not commit decoded Firebase config files, signing certificates, provisioning profiles, keystores, or generated `firebase_options.dart`.
