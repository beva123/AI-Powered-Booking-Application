FROM ghcr.io/cirruslabs/flutter:3.35.2
WORKDIR /app
COPY pubspec.yaml pubspec.lock* ./
RUN flutter pub get
COPY . .
RUN flutter --version && flutter doctor -v
CMD ["bash"]
