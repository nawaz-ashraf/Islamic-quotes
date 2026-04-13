plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

import java.util.Properties

android {
    namespace = "com.example.islamic_quotes_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    // Load keystore properties for release signing.
    // Create this file at: android/key.properties (do NOT commit it).
    val keystoreProperties = Properties()
    val keystorePropertiesFile = rootProject.file("key.properties")
    if (keystorePropertiesFile.exists()) {
        keystorePropertiesFile.inputStream().use { keystoreProperties.load(it) }
    }

    // Fail fast with a helpful message if someone tries to build Release without signing config.
    val isReleaseTask = gradle.startParameter.taskNames.any { taskName ->
        taskName.contains("release", ignoreCase = true)
    }
    if (isReleaseTask && !keystorePropertiesFile.exists()) {
        throw GradleException(
            "Missing android/key.properties.\n" +
                "Create a release keystore (e.g. android/app/key.jks) and then create android/key.properties.\n" +
                "You can start from android/key.properties.example."
        )
    }

    signingConfigs {
        create("release") {
            // If key.properties is missing, release builds will fail (prevents accidental debug signing).
            if (keystorePropertiesFile.exists()) {
                val requiredKeys = listOf("storeFile", "storePassword", "keyAlias", "keyPassword")
                val missingKeys = requiredKeys.filter { keystoreProperties.getProperty(it).isNullOrBlank() }
                if (missingKeys.isNotEmpty()) {
                    throw GradleException(
                        "android/key.properties is missing: ${missingKeys.joinToString(", ")}.\n" +
                            "Fix android/key.properties (you can copy android/key.properties.example)."
                    )
                }
                storeFile = rootProject.file(keystoreProperties["storeFile"] as String)
                storePassword = keystoreProperties["storePassword"] as String
                keyAlias = keystoreProperties["keyAlias"] as String
                keyPassword = keystoreProperties["keyPassword"] as String
            }
        }
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        // Needed by some plugins (e.g. flutter_local_notifications) that rely on newer Java APIs
        // while still supporting older Android devices.
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "io.github.nawazashraf.islamicquotes"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            // Sign release builds with your upload key (android/key.properties).
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Core library desugaring (Java 8+ APIs on older Android versions)
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.0.4")
}
