FROM alpine:latest

# Add HTTP health port
EXPOSE 8001

# Add RPC server
EXPOSE 50051

# Create directory for server files
RUN mkdir /kittertray

# Add server files
ADD kittertray /kittertray/kittertray

RUN chmod 755 /kittertray/kittertray

ENTRYPOINT ["exec /kittertray/kittertray"]
CMD []
