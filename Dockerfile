FROM alpine as builder
RUN  apk update && apk add openjdk8 maven git
RUN  git clone https://github.com/wakaleo/game-of-life.git
RUN  cd game-of-life && mvn compile && mvn package

FROM tomcat:8
COPY --from=builder /game-of-life/gameoflife-web/target/gameoflife.war /usr/local/tomcat/webapps/gameoflife.war
EXPOSE 8080
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]

