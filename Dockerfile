FROM maven:3.8.4-eclipse-temurin-16 as builder
WORKDIR /tmp/maven

COPY pom.xml .
RUN mvn -B dependency:go-offline

COPY src ./src
RUN mvn -B package -DskipTests

FROM openjdk:17
COPY --from=BUILDER /tmp/maven/target/JMusicBot-Snapshot-All.jar /payload.jar
WORKDIR /rundir
ENTRYPOINT ["java", "-jar", "/payload.jar"]
