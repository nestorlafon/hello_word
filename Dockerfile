FROM golang:1.20    
WORKDIR /app
COPY main.go ./
RUN go build main.go
EXPOSE 4000
CMD ["/app/main"]
