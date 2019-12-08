FROM tomcat:jdk8-openjdk
LABEL maintainer="corey@simpleltc.com"

RUN ["apt-get", "update"]
RUN ["apt-get", "install", "-y", "maven", "subversion", "git", "unzip", "wget", "curl", "gettext", "gosu"]

WORKDIR /app/
RUN ["mkdir", "-p", "ctakes-codebase-area"]

COPY entrypoint.sh /app/
RUN ["chmod", "+x", "/app/entrypoint.sh"]

WORKDIR /app/ctakes-codebase-area/
RUN ["svn", "export", "https://svn.apache.org/repos/asf/ctakes/trunk"]

WORKDIR /app/ctakes-codebase-area/trunk/ctakes-distribution/
RUN ["mvn", "install", "-Dmaven.test.skip=true"]

WORKDIR /app/ctakes-codebase-area/trunk/ctakes-assertion-zoner/
RUN ["mvn", "install", "-Dmaven.test.skip=true"]

EXPOSE 8080

COPY ctakes-web-rest /app/ctakes-web-rest/

ENTRYPOINT ["/app/entrypoint.sh"]

WORKDIR $CATALINA_HOME

CMD ["catalina.sh", "run"]
