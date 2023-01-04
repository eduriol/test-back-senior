FROM maven:3.8.3-openjdk-17

WORKDIR /usr/src/myapp
COPY . .

RUN mvn compile

CMD ["mvn", "test"]
