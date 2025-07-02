import com.android.build.gradle.internal.api.BaseVariantOutputImpl
import java.util.Date
import java.text.SimpleDateFormat

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.flutter_test_mlkit_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.flutter_test_mlkit_app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
             applicationVariants.all {
                outputs.all { output ->
                    if (output is BaseVariantOutputImpl) {
                        val project = "Sample App MLKit"
                        val separator = "_"
                        val buildType = buildType.name
                        val version = versionName
                        val formattedDate = SimpleDateFormat("MM-dd-yyyy").format(Date())
                        val filename =
                            "$project$separator$version$separator$buildType$separator$formattedDate.apk"
                        output.outputFileName = filename
                    }
                    true
                }
            }

            isMinifyEnabled = false
            isShrinkResources = false
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
