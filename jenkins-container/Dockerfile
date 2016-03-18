FROM jenkins
COPY install-plugins.sh /tmp/install-plugins.sh
USER root
RUN chmod +x /tmp/install-plugins.sh
RUN /tmp/install-plugins.sh deployit-plugin xlrelease-plugin maven-plugin git job-dsl
USER jenkins
