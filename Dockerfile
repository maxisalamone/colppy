# Stage 1
FROM golang:1.20 AS builder
WORKDIR /app
COPY /app .
RUN go mod download 
RUN go build -o main .

# Stage 2
FROM alpine:latest
WORKDIR /app
RUN apk add --no-cache libc6-compat
COPY --from=builder /app/main .
EXPOSE 8080
CMD ["./main"]

