FROM mhart/alpine-node:10.21.0

MAINTAINER Trocafone Tech "tech@trocafone.com"

WORKDIR /opt/evaluaciones

COPY ./api/package.json ./
COPY ./api/yarn.lock ./

RUN yarn install --frozen-lockfile

COPY . ./

ENTRYPOINT ["/opt/evaluaciones/entrypoint.sh"]
CMD ["test"]
