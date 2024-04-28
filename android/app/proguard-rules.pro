# Flutter specific ProGuard configuration

# Preserve all Flutter-related classes and methods
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.MyApp.**  { *; }
-keep class io.flutter.MainActivity.**  { *; }
-keep class io.flutter.freezed.**  { *; }
-keep class io.flutter.JsonSerializable.**  { *; }
-keep class get.** { *; }
-keep class com.airbnb.lottie.** { *; }
-keep class net.fortuna.ical4j.** { *; }
-keep class io.flutter.plugins.pathprovider.** { *; }
-keep class com.example.open_file.** { *; }

# Preserve all classes and methods used by plugins
-keep class com.marzbani.absence.manager.plugin.** { *; }

# To avoid the removal of native method calls that might not have direct references
-keepclasseswithmembernames class * {
    native <methods>;
}

# Allow the obfuscation of certain classes, if needed
-keepclassmembers class * {
    public protected *;
}
