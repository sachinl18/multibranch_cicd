FROM eclipse-temurin:21-jre

# Create app directory
WORKDIR /app

# Copy the built JAR from the build artifact into the image
# This name MUST match your JAR_FILE variable and what ends up in drop/
COPY jb-hello-world-0.1.0-1.0-SNAPSHOT.jar app.jar

# Expose port if your app listens on one (change if needed)
EXPOSE 8080

# Run the JAR
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
