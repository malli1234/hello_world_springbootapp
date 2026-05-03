# syntax=docker/dockerfile:1.6

# ---- Build stage ----
FROM eclipse-temurin:17-jdk-jammy AS builder
WORKDIR /workspace

# Cache wrapper + dependency descriptors first for better layer caching.
COPY gradle gradle
COPY gradlew settings.gradle build.gradle ./
RUN chmod +x ./gradlew && ./gradlew --no-daemon --version

# Now copy sources and build the executable jar.
COPY src src
RUN ./gradlew --no-daemon clean bootJar

# ---- Runtime stage ----
FROM eclipse-temurin:17-jre-jammy

# OpenShift runs containers with an arbitrary UID in group 0 (root group).
# Make /app writable by group 0 so the random UID can read/write as needed.
WORKDIR /app
COPY --from=builder /workspace/build/libs/*.jar /app/app.jar
RUN chgrp -R 0 /app && chmod -R g=u /app

EXPOSE 8080

# Use a non-root UID; OpenShift will override this with an arbitrary UID anyway,
# but this keeps the image safe to run on plain Docker / Kubernetes too.
USER 1001

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
