# Use a base image with Java installed
FROM openjdk:8-jdk-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the compiled Java application JAR file into the container
COPY target/my-java-app-1.0-SNAPSHOT.jar /app/my-java-app.jar

# Command to run the Java application
CMD ["java", "-jar", "my-java-app.jar"]
