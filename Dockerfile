ARG BASE_IMAGE=python:3.8-slim
FROM $BASE_IMAGE as base
COPY ./friendbot/ /app/friendbot
COPY ./healthcheck.py /app
ENV EXPORT_ZIP=/export.zip

FROM base as lint
RUN pip install --upgrade pip --no-cache-dir \
	&& pip install black --no-cache-dir
RUN black --check --diff /app

FROM base as dependencies
WORKDIR /app
COPY ./requirements.txt /app
RUN pip install --upgrade pip --no-cache-dir \
	&& pip install -r requirements.txt --no-cache-dir

FROM dependencies as test
RUN pip install behave --no-cache-dir
COPY ./features /app/features
COPY ./test_data/actions /app/test_data/actions
COPY ./test_data/export.zip /
RUN behave

FROM dependencies as release
HEALTHCHECK --interval=300s --timeout=3s --retries=1 CMD python healthcheck.py
CMD ["gunicorn", "--preload", "--access-logformat", "%(t)s %(p)s %(r)s %(s)s %(b)s %(a)s %(L)ss", "--access-logfile", "-", "-w", "2", "-k", "gthread", "--threads", "4", "-b", "0.0.0.0:6000", "--worker-tmp-dir", "/dev/shm", "friendbot:app"]
