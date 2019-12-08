#!/bin/sh

set -e

cd /app/ctakes-web-rest/src/main/resources/org/apache/ctakes/dictionary/lookup/fast
cat customDictionary.xml | envsubst > customDictionary.xml

cd /app/ctakes-web-rest
mvn install
mv target/ctakes-web-rest.war /usr/local/tomcat/webapps/

exec "$@"
