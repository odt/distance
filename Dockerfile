FROM haskell:8.8.1 AS build

RUN cabal update

WORKDIR /app

COPY distance.cabal .
COPY app/ app/
COPY src/ src/
COPY test/ test/
RUN cabal install exe:distance

FROM ubuntu:18.04

COPY --from=build /root/.cabal/bin/distance /distance

CMD ["/distance"]
