FROM eclipse-temurin:21-jre

WORKDIR /app

COPY target/cicd-demo-1.0.jar app.jar

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]
