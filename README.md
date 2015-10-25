# docker-igalerie

This is a Dockerfile to build an igalerie docker.
Igalerie is a image gallery built by http://www.igalerie.org.

# Building the docker : 
docker build -t frlsazc/docker-igalerie:2.3.6 .

#Running the docker :
docker run -d --name igalerie -p 8180:80 -v path/to/your/albums:/albums frlsazc/docker-igalerie:2.3.6

Go to http://localhost:8180/igalerie to see your galerie.
The admin page URL is http://localhost:8180/igalerie/admin 

The admin password is set to 123456. You should consider to change it.

Read the igalerie documentation (http://www.igalerie.org/documentation) for more information on how to use igalerie.

