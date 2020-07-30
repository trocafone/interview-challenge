FROM mhart/alpine-node:14.6.0

LABEL maintainer="Trocafone Tech tech@trocafone.com"

WORKDIR /opt/interview-challenge
ENTRYPOINT ["/opt/interview-challenge/entrypoint.sh"]
CMD ["test"]

COPY ./package.json ./
COPY ./yarn.lock ./

RUN yarn install --frozen-lockfile

COPY . ./
