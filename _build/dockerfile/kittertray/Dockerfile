FROM alpine:latest

# Add HTTP health port
EXPOSE 8001

# Add RPC server
EXPOSE 50051

# Create directory for server files
RUN mkdir /kittertray

WORKDIR /kittertray

# Add server files
COPY kittertray /kittertray/kittertray
COPY ./static /kittertray/static

RUN chmod 755 /kittertray/kittertray

CMD ["./kittertray"]