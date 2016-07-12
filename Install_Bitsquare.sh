echo "Installation of Java 8, Maven and Git"
apt-get update
apt-get install -y software-properties-common python-software-properties
add-apt-repository ppa:webupd8team/java
apt-get update
apt-get install -y oracle-java8-installer git maven

cp bcprov-jdk15on-153.jar /usr/lib/jvm/java-8-oracle/jre/lib/ext/
echo "security.provider.11=org.bouncycastle.jce.provider.BouncyCastleProvider" >> /usr/lib/jvm/java-8-oracle/jre/lib/security/java.security

cp local_policy.jar /usr/lib/jvm/java-8-oracle/jre/lib/security/
cp US_export_policy.jar /usr/lib/jvm/java-8-oracle/jre/lib/security/

git clone -b FixBloomFilters https://github.com/bitsquare/bitcoinj.git
cd bitcoinj
mvn clean install -DskipTests -Dmaven.javadoc.skip=true
cd ..

git clone https://github.com/bitsquare/bitsquare.git
cd bitsquare
mvn clean package -DskipTests

cd gui/target/

echo "Executing Bitsquare with 256 Mo of memory"
java -Xincgc -Xmx256M -Xms256M -jar shaded.jar
