FROM ghcr.io/dart-android/toybox:nightly

ENV DART_SDK=/system/lib64/dart
ENV PATH=$DART_SDK/bin:$PATH

RUN --mount=type=bind,source=.,target=/build \
    case "$(uname -m)" in \
      x86_64) \
        tar -xzf /build/dartsdk-android-x64-release.tar.gz && mv dart-sdk /system/lib64/dart && \
        tar -xzf /build/dartsdk-android-ia32-release.tar.gz && mv dart-sdk /system/lib/dart \
        ;; \
      aarch64) \
        tar -xzf /build/dartsdk-android-arm64-release.tar.gz && mv dart-sdk /system/lib64/dart && \
        tar -xzf /build/dartsdk-android-arm-release.tar.gz && mv dart-sdk /system/lib/dart \
        ;; \
      riscv64) \
        tar -xzf /build/dartsdk-android-riscv64-release.tar.gz && mv dart-sdk /system/lib64/dart \
        ;; \
    esac
