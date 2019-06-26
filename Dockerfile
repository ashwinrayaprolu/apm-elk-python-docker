FROM python:3.4

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        postgresql-client \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip3 install -r requirements.txt
RUN django-admin startproject mysite
WORKDIR /usr/src/app/mysite
#COPY . .
EXPOSE 8000
CMD ["python3", "manage.py", "runserver", "0.0.0.0:8000"]
#CMD ["ls", "-lrth"]
