FROM haskell:9.2.4 AS build

RUN cabal update

WORKDIR /app

COPY distance.cabal .
COPY app/ app/
COPY src/ src/
COPY test/ test/
RUN cabal install exe:distance

FROM ubuntu:22.04

COPY --from=build /root/.cabal/bin/distance /distance

CMD ["/distance"]
