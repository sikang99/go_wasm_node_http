FROM go:1.11beta3-alpine3.8
COPY ./ src/app/
RUN go build -o app.wasm app

FROM node:8-alpine
EXPOSE 3000
RUN mkdir app
WORKDIR /app
COPY --from=builder /go/app.wasm /app
COPY --from=builder /usr/local/go/misc/wasm/wasm_exec.js boot.js
ENTRYPOINT [ "node", "boot.js", "app.wasm"]
