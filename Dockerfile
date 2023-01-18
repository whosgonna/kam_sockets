ARG KAM_VERSION=5.6.3
## Start with the kam-apk for the desired version.

FROM whosgonna/kamailio-apks:$KAM_VERSION AS apks
# FROM registry.nexvortex-cpe.com/engineering/sandbox/kamailio_builds:5.6.1 AS apks


FROM alpine

RUN --mount=type=bind,from=apks,source=/home/builder,target=/builder \
       cp builder/.abuild/-62633096.rsa.pub /etc/apk/keys/ \
    && echo '/builder/packages/kamailio/' >> /etc/apk/repositories \
    && apk add --no-cache kamailio kamailio-json

COPY kamailio.cfg /etc/kamailio/kamailio.cfg

ENTRYPOINT ["kamailio", "-ddDDeE", "-u", "kamailio", "-g", "kamailio"]
#CMD [ "-M", "5", "-m", "17"]

