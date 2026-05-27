#!/data/data/com.termux/files/usr/bin/bash
set -e

# Создание каталогов проекта
mkdir -p app/src/main/java/com/mihail/androidmetro
mkdir -p app/src/main/res/layout
mkdir -p app/src/main/res/values

# settings.gradle — описание модулей проекта
cat > settings.gradle << 'EOF'
rootProject.name = "AndroidMetro"
include ':app'
EOF

# Корневой build.gradle — подключаем Android Gradle Plugin
cat > build.gradle << 'EOF'
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:8.3.2'
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

task clean(type: Delete) {
    delete rootProject.buildDir
}
EOF

# gradle.properties — базовые настройки Gradle
cat > gradle.properties << 'EOF'
org.gradle.jvmargs=-Xmx2048m -Dfile.encoding=UTF-8
android.useAndroidX=true
android.nonTransitiveRClass=true
EOF

# app/build.gradle — модуль приложения на Java
cat > app/build.gradle << 'EOF'
plugins {
    id 'com.android.application'
}

android {
    namespace 'com.mihail.androidmetro'
    compileSdk 34

    defaultConfig {
        applicationId 'com.mihail.androidmetro'
        minSdk 24
        targetSdk 34
        versionCode 1
        versionName '1.0'
    }

    buildTypes {
        release {
            minifyEnabled false
            proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
        }
    }

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }
}

dependencies {
    implementation 'androidx.core:core-ktx:1.13.1'
    implementation 'androidx.appcompat:appcompat:1.7.0'
    implementation 'com.google.android.material:material:1.11.0'
    implementation 'androidx.constraintlayout:constraintlayout:2.1.4'
}
EOF

# proguard-rules.pro — пока пустой
cat > app/proguard-rules.pro << 'EOF'
// ProGuard rules (оставим пустым на первом этапе)
EOF

# AndroidManifest.xml — одно активити, MAIN/LAUNCHER
cat > app/src/main/AndroidManifest.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
    package="com.mihail.androidmetro">

    <application
        android:allowBackup="true"
        android:label="@string/app_name"
        android:icon="@mipmap/ic_launcher"
        android:roundIcon="@mipmap/ic_launcher_round"
        android:theme="@style/Theme.AndroidMetro">
        <activity
            android:name=".MainActivity"
            android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN" />
                ategory android:name="android.intent.category.LAUNCHER" />
            </intent-filter>
        </activity>
    </application>

</manifest>
EOF

# MainActivity.java — пока просто текст "Metronome"
cat > app/src/main/java/com/mihail/androidmetro/MainActivity.java << 'EOF'
package com.mihail.androidmetro;

import android.os.Bundle;

import androidx.appcompat.app.AppCompatActivity;

public class MainActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }
}
EOF

# Разметка экрана
cat > app/src/main/res/layout/activity_main.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout xmlns:android="http://schemas.android.com/apk/res/android"
    xmlns:app="http://schemas.android.com/apk/res-auto"
    android:layout_width="match_parent"
    android:layout_height="match_parent"
    android:background="#12121C">

    <TextView
        android:id="@+id/title"
        android:layout_width="wrap_content"
        android:layout_height="wrap_content"
        android:text="Stage Metronome"
        android:textColor="#FFFFFF"
        android:textSize="24sp"
        android:textStyle="bold"
        app:layout_constraintTop_toTopOf="parent"
        app:layout_constraintStart_toStartOf="parent"
        app:layout_constraintEnd_toEndOf="parent"
        android:layout_marginTop="32dp"/>

</androidx.constraintlayout.widget.ConstraintLayout>
EOF

# Строки ресурсов
cat > app/src/main/res/values/strings.xml << 'EOF'
<resources>
    <string name="app_name">Stage Metronome</string>
</resources>
EOF

# Цвета
cat > app/src/main/res/values/colors.xml << 'EOF'
<resources>
    lor name="purple_500">#6C63FF</color>
    lor name="purple_700">#4338CA</color>
    lor name="teal_200">#03DAC5</color>
    lor name="black">#000000</color>
    lor name="white">#FFFFFF</color>
</resources>
EOF

# Тема
cat > app/src/main/res/values/themes.xml << 'EOF'
<resources xmlns:tools="http://schemas.android.com/tools">
    <style name="Theme.AndroidMetro" parent="Theme.MaterialComponents.DayNight.DarkActionBar">
        <item name="colorPrimary">@color/purple_500</item>
        <item name="colorPrimaryVariant">@color/purple_700</item>
        <item name="colorOnPrimary">@color/white</item>
        <item name="android:statusBarColor" tools:targetApi="l">@color/black</item>
    </style>
</resources>
EOF

echo "Проект AndroidMetro развёрнут."
echo "Дальше: python metro_bridge.py push — отправить всё на GitHub."
