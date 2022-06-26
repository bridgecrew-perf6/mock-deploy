FROM alpine

RUN apk add --update nodejs npm
RUN npm install -g @mockoon/cli@2.0.0
COPY mockoon-mock-food.json ./mockoon-mock-food.json

# Do not run as root.
RUN adduser --shell /bin/sh --disabled-password --gecos "" mockoon
RUN chown -R mockoon ./mockoon-mock-food.json
USER mockoon

EXPOSE 3001

ENTRYPOINT ["mockoon-cli", "start", "--hostname", "0.0.0.0", "--daemon-off", "--data", "mockoon-mock-food.json", "--container"]

# Usage: docker run -p <host_port>:<container_port> mockoon-test