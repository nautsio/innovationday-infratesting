FROM jenkins
COPY install-plugins.sh /tmp/install-plugins.sh
USER root
RUN chmod +x /tmp/install-plugins.sh
RUN /tmp/install-plugins.sh maven-plugin git github job-dsl gradle
RUN cd /opt && wget https://services.gradle.org/distributions/gradle-2.12-bin.zip && unzip gradle-2.12-bin.zip && ln -sf /opt/gradle-2.12/bin/gradle /bin/gradle
USER jenkins
