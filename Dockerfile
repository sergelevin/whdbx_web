# Building
FROM python:3.9-slim as builder

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1\
    PYTHONUNBUFFERED=1       \
    DEBIAN_FRONTEND="noninteractive"

RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc

COPY requirements.txt .
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /app/wheels -r requirements.txt 

# Actual image
FROM python:3.9-slim

WORKDIR /app

ENV DEBIAN_FRONTEND="noninteractive"

COPY --from=builder /app/wheels /wheels
RUN pip install --no-cache /wheels/* && \
    apt-get update && \
    apt-get install -y --no-install-recommends sqlite3 wget bzip2 && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir _caches

COPY . ./

EXPOSE 8081
VOLUME ["/app/_caches", "/app/logs", "/app/db"]

ENTRYPOINT ["/app/entrypoint.sh"]