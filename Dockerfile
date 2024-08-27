FROM ghcr.io/dart-android/toybox

COPY dartsdk-android-x64-release.tar.gz /build/dartsdk-android-x64-release.tar.gz
COPY dartsdk-android-ia32-release.tar.gz /build/dartsdk-android-ia32-release.tar.gz
COPY dartsdk-android-arm64-release.tar.gz /build/dartsdk-android-arm64-release.tar.gz
COPY dartsdk-android-arm-release.tar.gz /build/dartsdk-android-arm-release.tar.gz

RUN case "$(uname -m)" in \
      x86_64) \
        tar -xzf /build/dartsdk-android-x64-release.tar.gz && mv dart-sdk /system/lib64/dart && \
        tar -xzf /build/dartsdk-android-ia32-release.tar.gz && mv dart-sdk /system/lib/dart \
        ;; \
      aarch64) \
        tar -xzf /build/dartsdk-android-arm64-release.tar.gz && mv dart-sdk /system/lib64/dart && \
        tar -xzf /build/dartsdk-android-arm-release.tar.gz && mv dart-sdk /system/lib/dart \
        ;; \
    esac

FROM ghcr.io/dart-android/toybox

ENV DART_SDK=/system/lib64/dart
ENV PATH=$DART_SDK/bin:$PATH

COPY --from=0 /system/lib64/dart /system/lib64/dart
COPY --from=0 /system/lib/dart /system/lib/dart
