FROM python:3.4

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip3 install -r requirements.txt
#RUN django-admin startproject exampleapp
RUN addgroup -gid 2001 gpy3 && adduser --disabled-password --system --gid 2001  py3
RUN git clone https://github.com/rodrigo-ramos/exampleapp.git
RUN chown -R py3:gpy3 /usr/src/app/exampleapp
WORKDIR /usr/src/app/exampleapp/mysite
EXPOSE 8000
RUN python manage.py migrate
USER py3
CMD ["python3.4", "manage.py", "runserver", "0.0.0.0:8000"]
