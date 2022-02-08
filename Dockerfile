FROM java:8
COPY target/*.jar /demoapp.jar

CMD ["--server.port=8080"]

EXPOSE 8080

ENTRYPOINT ["java","-jar","/demoapp.jar"]
