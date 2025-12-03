# =========================
# 1) Build stage
# =========================
FROM eclipse-temurin:17-jdk AS build
 
# Set working directory inside the container
WORKDIR /workspace
 
# Copy Gradle wrapper and build files first (better caching)
COPY gradlew .
COPY gradle gradle
COPY settings.gradle .
# If you have build.gradle in root, uncomment:
# COPY build.gradle .
 
# Make gradlew executable
RUN chmod +x gradlew
 
# Copy the rest of the source code
COPY . .
 
# Build only the app module (skip tests if you want faster builds)
RUN ./gradlew :app:clean :app:build -x test
 
# =========================
# 2) Runtime stage
# =========================
FROM eclipse-temurin:17-jre
 
WORKDIR /app
 
# Copy the built JAR from the build stage
# This assumes your jar ends up in app/build/libs/
COPY --from=build /workspace/app/build/libs/*.jar app.jar
 
# Expose the port your app runs on (change if different)
EXPOSE 8080
 
# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
