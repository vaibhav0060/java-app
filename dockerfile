FROM openjdk:25-ea-24-jdk
WORKDIR /app
COPY Test.java .
RUN javac Test.java
COPY . /app
CMD ["java","Test"]



