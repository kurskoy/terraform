FROM python:3.9-alpine

WORKDIR /web

COPY index.html /web

EXPOSE 8000

CMD [ "python3", "-m", "http.server", "8000" ]