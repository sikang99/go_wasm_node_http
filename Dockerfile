FROM golang:1.11beta3-alpine3.8 as builder
COPY ./ src/app/
RUN go version
RUN GOOS=js GOARCH=wasm go build -o app.wasm app
RUN ls -al /go/app.wasm

FROM node:8-alpine
EXPOSE 3000
RUN mkdir app
WORKDIR /app
COPY --from=builder /go/app.wasm /app
COPY --from=builder /usr/local/go/misc/wasm/wasm_exec.js boot.js
ENTRYPOINT [ "node", "boot.js", "app.wasm"]
