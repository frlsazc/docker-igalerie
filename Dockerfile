FROM ubuntu
MAINTAINER samuel le garec

#enable multiverse  repository
RUN sed -i 's/^#\s*\(deb.*multiverse\)$/\1/g' /etc/apt/sources.list
RUN apt-get update

#installation of required package
RUN apt-get install -y apache2 libapache2-mod-php5 php5 php5-mysql mysql-server php5-gd supervisor wget unzip curl

#Download iGalerie sources
RUN wget http://www.igalerie.org/igalerie-2.3.6.zip -O /tmp/igalerie.zip
RUN unzip /tmp/igalerie.zip -d /tmp/

#Install Igalerie in apache Documents
RUN mv /tmp/igalerie /var/www/html/
RUN chown -R www-data:www-data /var/www/html/igalerie


#Create /albums volume
RUN mv /var/www/html/igalerie/albums /
RUN ln -s /albums /var/www/html/igalerie/albums
VOLUME /albums
RUN chown -R www-data:www-data /albums


#Initialisation script of igalerie
ADD init_igalerie.sh /tmp/
RUN chmod +x /tmp/init_igalerie.sh
RUN /tmp/init_igalerie.sh

#Delete install directory
RUN rm -fr /var/www/html/igalerie/install

#Add supervisord configuration
COPY supervisord.conf /etc/supervisor/supervisord.conf

#Clean apt-get
RUN apt-get clean

EXPOSE 80

CMD ["/usr/bin/supervisord","-c","/etc/supervisor/supervisord.conf"]
