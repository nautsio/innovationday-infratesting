FROM jenkins
COPY install-plugins.sh /tmp/install-plugins.sh
USER root
RUN chmod +x /tmp/install-plugins.sh
RUN /tmp/install-plugins.sh maven-plugin git github job-dsl gradle
USER jenkins
