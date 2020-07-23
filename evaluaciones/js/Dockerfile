FROM mhart/alpine-node:10.21.0

MAINTAINER Trocafone Tech "tech@trocafone.com"

WORKDIR /opt/evaluaciones
ENTRYPOINT ["/opt/evaluaciones/entrypoint.sh"]
CMD ["test"]

COPY ./package.json ./
COPY ./yarn.lock ./

RUN yarn install --frozen-lockfile

COPY . ./
