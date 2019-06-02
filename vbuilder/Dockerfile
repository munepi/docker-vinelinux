FROM local/vineseed

LABEL maintainer="Munehiro Yamamoto <munepi@vinelinux.org>" \
        org.label-schema.schema-version="1.0" \
        org.label-schema.name="vbuilder image" \
        org.label-schema.vendor="Vine Linux" \
        org.label-schema.license="GPLv2" \
        org.label-schema.build-date="20190603"

## install vbuilder
RUN apt update && \
        apt install -y vbootstrap

ENV SUDO_USER=root USERHELPER_UID=0

# ENTRYPOINT [ "vbuilder" ]
# CMD ["--help | head -n 1"]
