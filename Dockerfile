# Multi-stage Build

# Stage 1: Build .jar
FROM openjdk:11.0-jdk-slim as builder
VOLUME /tmp
COPY . .
RUN ./gradlew build

# Stage 2: Run JRE for the .jar
FROM openjdk:11.0-jre-slim
WORKDIR /app
COPY --from=builder build/libs/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
EXPOSE 8200

